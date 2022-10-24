# Level syntax

A consise summary of the level syntax

## Header

The header contains all metadata and is sepparated from the main body with a `---`

The header is structured as follows:

- `BPM` A number representing the BPM of the level.
- `time` two numbers separated by a `/` denoting the time signature of the level.

## Body

The body contains all the orbs in the level with each line representing a single orb.

The orb syntax is as follows: `<delta_time> <length> <lane_index> <orb_type>`

- `<delta_time>` The time since the previous event.
- `<length>` The amount of time the orb travels, denoted in fractions of a quarter.
- `<lane_index>` The index of the lane which the orb will travel along.
- `<orb_type>` A number specifying the type of the orb.
