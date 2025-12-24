open Core

let binary =
  In_channel.read_all "challenge.bin"
  |> String.to_sequence
  |> Sequence.map ~f:Char.to_int
  |> Sequence.to_array
;;

let read_int pc = binary.(2 * pc) + (binary.((2 * pc) + 1) lsl 8)

let rec run pc =
  match read_int pc with
  | 0 -> print_endline "<HALT>"
  | 19 ->
    let c = Char.of_int_exn (read_int (pc + 1)) in
    Printf.printf "%c" c;
    run (pc + 2)
  | 21 -> run (pc + 1)
  | op -> raise_s [%message "Unknown opcode " (op : int)]
;;

let () = run 0
