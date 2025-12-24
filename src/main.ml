open Core

let debug_mode = ref false
let dbg = if !debug_mode then print_s ~mach:() else ignore

type loc =
  | Imm of int
  | Reg of int
[@@deriving sexp]

type storage =
  { registers : int array
  ; memory : int array
  ; mutable stack : int list
  }

let binary =
  In_channel.read_all "challenge.bin"
  |> String.to_list
  |> List.map ~f:Char.to_int
  |> List.chunks_of ~length:2
  |> List.map ~f:(function
    | [ a; b ] -> a + (b lsl 8)
    | _ -> failwith "binary parse error")
  |> List.to_array
;;

let storage : storage =
  { registers = Array.init 8 ~f:(Fn.const 0)
  ; memory =
      Array.init 0x7FFF ~f:(fun i -> if i < Array.length binary then binary.(i) else 0)
  ; stack = []
  }
;;

let read pc =
  let n = storage.memory.(pc) in
  if n < 32768
  then Imm n
  else (
    let reg = n - 32768 in
    if reg < 8 then Reg reg else raise_s [%message "invalid int" (n : int)])
;;

let imm_of = function
  | Imm i -> i
  | Reg r -> storage.registers.(r)
;;

let reg_of = function
  | Imm i -> raise_s [%message "expected register" (Imm i : loc)]
  | Reg r -> r
;;

let rec run pc =
  match read pc with
  | Imm 0 -> print_endline "<HALT>"
  | Imm 1 ->
    let a = read (pc + 1) in
    let b = read (pc + 2) in
    dbg [%message "set" (a : loc) (b : loc)];
    storage.registers.(reg_of a) <- imm_of b;
    run (pc + 3)
  | Imm 2 ->
    let a = read (pc + 1) in
    dbg [%message "push" (a : loc)];
    storage.stack <- imm_of a :: storage.stack;
    run (pc + 2)
  | Imm 3 ->
    let a = read (pc + 1) in
    dbg [%message "pop" (a : loc)];
    (match storage.stack with
     | [] -> failwith "unexpected empty stack"
     | v :: stack ->
       storage.registers.(reg_of a) <- v;
       storage.stack <- stack);
    run (pc + 2)
  | Imm 4 ->
    let a = read (pc + 1) in
    let b = read (pc + 2) in
    let c = read (pc + 3) in
    dbg [%message "eq" (a : loc) (b : loc) (c : loc)];
    storage.registers.(reg_of a) <- (if imm_of b = imm_of c then 1 else 0);
    run (pc + 4)
  | Imm 5 ->
    let a = read (pc + 1) in
    let b = read (pc + 2) in
    let c = read (pc + 3) in
    dbg [%message "gt" (a : loc) (b : loc) (c : loc)];
    storage.registers.(reg_of a) <- (if imm_of b > imm_of c then 1 else 0);
    run (pc + 4)
  | Imm 6 ->
    let a = read (pc + 1) in
    dbg [%message "jmp" (a : loc)];
    run (imm_of a)
  | Imm 7 ->
    let a = read (pc + 1) in
    let b = read (pc + 2) in
    dbg [%message "jt" (a : loc) (b : loc)];
    if imm_of a <> 0 then run (imm_of b) else run (pc + 3)
  | Imm 8 ->
    let a = read (pc + 1) in
    let b = read (pc + 2) in
    dbg [%message "jf" (a : loc) (b : loc)];
    if imm_of a = 0 then run (imm_of b) else run (pc + 3)
  | Imm 9 ->
    let a = read (pc + 1) in
    let b = read (pc + 2) in
    let c = read (pc + 3) in
    dbg [%message "add" (a : loc) (b : loc) (c : loc)];
    storage.registers.(reg_of a) <- (imm_of b + imm_of c) mod 32768;
    run (pc + 4)
  | Imm 10 ->
    let a = read (pc + 1) in
    let b = read (pc + 2) in
    let c = read (pc + 3) in
    dbg [%message "mul" (a : loc) (b : loc) (c : loc)];
    storage.registers.(reg_of a) <- imm_of b * imm_of c mod 32768;
    run (pc + 4)
  | Imm 11 ->
    let a = read (pc + 1) in
    let b = read (pc + 2) in
    let c = read (pc + 3) in
    dbg [%message "mod" (a : loc) (b : loc) (c : loc)];
    storage.registers.(reg_of a) <- imm_of b mod imm_of c;
    run (pc + 4)
  | Imm 12 ->
    let a = read (pc + 1) in
    let b = read (pc + 2) in
    let c = read (pc + 3) in
    dbg [%message "and" (a : loc) (b : loc) (c : loc)];
    storage.registers.(reg_of a) <- imm_of b land imm_of c;
    run (pc + 4)
  | Imm 13 ->
    let a = read (pc + 1) in
    let b = read (pc + 2) in
    let c = read (pc + 3) in
    dbg [%message "or" (a : loc) (b : loc) (c : loc)];
    storage.registers.(reg_of a) <- imm_of b lor imm_of c;
    run (pc + 4)
  | Imm 14 ->
    let a = read (pc + 1) in
    let b = read (pc + 2) in
    dbg [%message "not" (a : loc) (b : loc)];
    storage.registers.(reg_of a) <- imm_of b lxor 0x7FFF;
    run (pc + 3)
  | Imm 15 ->
    let a = read (pc + 1) in
    let b = read (pc + 2) in
    dbg [%message "rmem" (a : loc) (b : loc)];
    storage.registers.(reg_of a) <- storage.memory.(imm_of b);
    run (pc + 3)
  | Imm 16 ->
    let a = read (pc + 1) in
    let b = read (pc + 2) in
    dbg [%message "wmem" (a : loc) (b : loc)];
    storage.memory.(imm_of a) <- imm_of b;
    run (pc + 3)
  | Imm 17 ->
    let a = read (pc + 1) in
    dbg [%message "call" (a : loc)];
    storage.stack <- (pc + 2) :: storage.stack;
    run (imm_of a)
  | Imm 18 ->
    dbg [%message "ret"];
    (match storage.stack with
     | [] -> print_endline "<HALT>"
     | pc :: stack ->
       storage.stack <- stack;
       run pc)
  | Imm 19 ->
    let c = Char.of_int_exn (imm_of (read (pc + 1))) in
    Printf.printf "%c" c;
    run (pc + 2)
  | Imm 20 ->
    let a = read (pc + 1) in
    dbg [%message "in" (a : loc)];
    Out_channel.flush stdout;
    let c = Option.value_exn In_channel.(input_char stdin) in
    storage.registers.(reg_of a) <- Char.to_int c;
    run (pc + 2)
  | Imm 21 -> run (pc + 1)
  | op -> print_s [%message "Unknown opcode " (op : loc)]
;;

let () = run 0
