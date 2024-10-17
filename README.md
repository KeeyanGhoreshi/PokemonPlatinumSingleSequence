# Overview

This repository contains a list of inputs that will beat Pokemon Platinum.  Using a combination of techniques and simulations, progress through the game is guarenteed. There is no RNG-manipulation involved, no frame-perfect inputs required, and the sequence of inputs is static and unchanging regardless of in-game occurences.

# Contents

The inputs can be found in the `commands` directory.  Each file corresponds to a different part of the game, and they each flow into each other from 1 to 9.  There is also a helper file to alter the memory of the game for testing, and a file for recording inputs while playing.

Each command file contains a list of commands with the format `[<command>, <frames>]`, where the first value is which command to do, and the second is how many frames to hold that command for.  In cases where the command is a set of button presses, `<frames>` indicates how many repititions of that command to do.

The basic commands are as follows:

| Command | Description |
| ------------- | ------------- |
| a  | A |
| b  | B |
| uf  | Up |
| df  | Down |
| lf  | Left |
| rf  | Right |
| st  | Start |
| x | X |
| y | Y |
| ub  | Up + B |
| db  | Down + B |
| lb  | Left + B |
| rb  | Right + B |
| w  | Wait |

Other buttons, like select, L, and R, are unused.

In the command files, additional commands are used to represent a set of these basic button presses. For example, to press A 10 times, `{'press_a', 10}` is used as shorthand, rather than 10 commands in a row to hold the A button for 60 frames.

Each file also defines up to 12 custom commands that do various routines like handle memory mail, do standard battle actions, or navigate sections of the game that must be repeated.

Note that the `l`, `r`, `u`, and `d` commands are shorthand for taking one step in a direction, and `lf`, `rf`, `uf`, and `df` are the commands for holding a directional button for a certain number of frames.

# Notes

There may be some volatility with the touch control, which is a required input at the very beginning of the game.  To advance, you must tap the middle of the screen, hitting the center of a pokeball.  This is a non-standard analog input, and is denoted in the code as `touch_middle`.  This only occurs once.

There is also a chance that the inputs don't account for something I am simply unaware of, or didn't think to check.  This human error is always present, regardless of how many times I've checked and rechecked the sequence for problems and bugs.

# More Info

Pokemon uses a Linear Congruent Random Number Generator (LCRNG) to produce most of its random numbers.  This works by creating a sequence of numbers that appears random enough, and then stepping through the sequence one at a time to produce "random" numbers.

The generation 4 pokemon games are different from their predecessors in that they do not cycle through random numbers, they only use a random number when it is needed.  

For example, in Ruby/Sapphire/Emerald, the game will step through the sequence of random numbers every other frame, even if nothing is happening in game, and produce whatever number its currently on when the game asks for one. 

In Diamond/Pearl/Platinum, the random number generator stays static until the game asks for a value.  Meaning if you're standing in an empty area in the game, the random number generator won't do anything.

If you simulate all possible outcomes of the random number generator for a given action, say flip a coin, in Gen 4 games this outcome is deterministic (assuming you are in an empty, or "quiet" area) regardless of your timing.

In Gen 3 games this outcome is not deterministic, it depends on your timing.  Meaning if you flip the coin now, it could have a different result than if you flipped it 2 seconds later.

For our purposes, this quality of the Gen 4 games makes it so that even if a human player uses this list of inputs to play the game, it will still function properly, since a human player would not do the inputs at exact times, and either press the buttons a bit early or a bit late.  So long as the buttons aren't pressed too early, you can delay them for an indefinite amount of time, with no effect on the outcome of the game (assuming you do, eventually, press the buttons).

Using this principle, simulating all 4 billion possible seeds, or starting positions, on Pokemon Platinum's random number sequence allows us to predict what will happen in all possible games.  For example, flipping a coin 100 times has a deterministic number of outcomes.  By checking all of them, we can discover the worst/best case scenario, which in this case is an 80/20 split.

For coin flipping, this process very closely resembles using math to just determine our expected value using simple statistics.  For more complicated things, like Pokemon battles, it becomes much more difficult to use math to determine the outcome.  It is easier to simulate all 4 billion possibilities than it is to calculate the probability given the chance to crit, miss, damage rolls, AI rng, secondary effect chances, etc. 

Doing this gives us insight into which strategies win in every possible game, and allow me to defeat different trainers with 100% certainty, even if mathematically there would be a chance to fail or lose.

The end result is this sequence of inputs, which should beat every game of platinum start to finish without any chances of failure, barring misinputs or bugs.