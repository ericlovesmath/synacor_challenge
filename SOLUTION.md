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
