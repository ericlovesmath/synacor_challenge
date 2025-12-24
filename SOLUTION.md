# Codes

```
- LDOb7UGhTi   (in hint)
- ImoFztWQCvxj (upon finishing no-op and print instrs)
- BNCyODLfQkIl (upon finishing VM)
- pWDWTEfURAdS (written in tablet at start)
- JyDQhSbkpyns (after teleporter)
```

# NOTES

## Start of [ladder] to find lantern

```
x> east        You are in a maze of alike little passages, all twisty.
  x> north     You are in a maze of alike twisty passages, all little.
    x> south   (back to east below)
    x> north   You are in a maze of little twisty passages, all alike.
      x> north (back to start)
      x> south (back to east below)
      x> east  (loop)
    x> east    You are in a twisty maze of little passages, all alike.
      x> west  (loop)
x> north       East above, You are in a twisty maze of little passages, all alike.
x> south       North above, You are in a maze of little twisty passages, all alike.
=> west        You are in a little maze of twisty passages, all alike.
  x> north     (loop to west)
  x> east      (start)
  => south     (grue!)
    -> north   CODE: rdMkyZhveeIv, take can, use can, use lantern
      -> west  Return to start, but this is fine
    x> south   (loop)
    x> west    North above, You are in a maze of little twisty passages, all alike.
    x> east    You are in a twisty maze of little passages, all alike.
      x> north (loop)
      x> south (loop)
```

## Coins in Door

- Hint: `_ + _ * _^2 + _^3 - _ = 399`
- Corroded Coin: This coin is somewhat corroded.  It has a triangle on one side.
- Shiny Coin: This coin is somehow still quite shiny.  It has a pentagon on one side.
- Blue Coin: This coin is made of a blue metal.  It has nine dots on one side.
- Concave Coin: This coin is slightly rounded, almost like a tiny bowl.  It has seven dots on one side.

```python
from itertools import permutations

for (a, b, c, d, e) in permutations([2, 3, 5, 9, 7]):
    if a + b * c * c + d * d * d - e == 399:
        print(a, b, c, d, e)
```

- Output: 9 2 5 7 3
- Order: blue, red, shiny, concave, corroded

# Raw Cumulative Input

```
take tablet
use table
doorway
north
north
bridge
continue
down
east
take empty lantern
west
west
passage
ladder
west
south
north
take can
use can
use lantern
west
ladder
darkness
continue
west
west
west
west
north
take red coin
north
west
take blue coin
up
take shiny coin
down
east
east
take concave coin
down
take corroded coin
up
west
use blue coin
use red coin
use shiny coin
use concave coin
use corroded coin
north
take teleporter
use teleporter
take business card
take strange book
```
