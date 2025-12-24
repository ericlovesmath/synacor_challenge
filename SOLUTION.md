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

## Strange Book Contents

Recent advances in interdimensional physics have produced fascinating
predictions about the fundamentals of our universe!  For example,
interdimensional physics seems to predict that the universe is, at its root, a
purely mathematical construct, and that all events are caused by the
interactions between eight pockets of energy called "registers".
Furthermore, it seems that while the lower registers primarily control mundane
things like sound and light, the highest register (the so-called "eighth
register") is used to control interdimensional events such as teleportation.

A hypothetical such teleportation device would need to have have exactly two
destinations.  One destination would be used when the eighth register is at its
minimum energy level - this would be the default operation assuming the user
has no way to control the eighth register.  In this situation, the teleporter
should send the user to a preconfigured safe location as a default.

The second destination, however, is predicted to require a very specific
energy level in the eighth register.  The teleporter must take great care to
confirm that this energy level is exactly correct before teleporting its user!
If it is even slightly off, the user would (probably) arrive at the correct
location, but would experience anomalies in the fabric of reality itself - this
is, of course, not recommended.  Any teleporter would need to test the energy
level in the eighth register and abort teleportation if it is not exactly
correct.

This required precision implies that the confirmation mechanism would be very
computationally expensive.  While this would likely not be an issue for large-
scale teleporters, a hypothetical hand-held teleporter would take billions of
years to compute the result and confirm that the eighth register is correct.

If you find yourself trapped in an alternate dimension with nothing but a
hand-held teleporter, you will need to extract the confirmation algorithm,
reimplement it on more powerful hardware, and optimize it.  This should, at the
very least, allow you to determine the value of the eighth register which would
have been accepted by the teleporter's confirmation mechanism.

Then, set the eighth register to this value, activate the teleporter, and
bypass the confirmation mechanism.  If the eighth register is set correctly, no
anomalies should be experienced, but beware - if it is set incorrectly, the
now-bypassed confirmation mechanism will not protect you!

Of course, since teleportation is impossible, this is all totally ridiculous.

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
