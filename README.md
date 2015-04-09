Prerequisites
=============
It is assumed that the `haskell` is installed on the machine. No external
libraries are used.

Running
=======
This program should be invoked with

    runghc GamesysSeries.hs $X $Y0 $L $Y1 $Z

where the variables refer to the variables from the assignment. The assignment
makes mention of two variables named `y` - they are `$Y0` and `$Y1` in their
respective order.

Output
======
Doing

    runghc GamesysSeries.hs 1 5062.5 5 1000 160

As corresponding to the example in the assignment. Will yield the following
output:

    First: 1.62
    Growth: 2.5
    Series: [1.62,4.05,6.561,10.628819,17.218687]
    - sorted: [1.62,4.05,6.561,10.628819,17.218687]
    - rounded: [1.5,4.0,6.5,10.75,17.25]
    Third largest 6.5
    Candidate: 6.25
    Closest: 6.5

The responses to the different tasks can be read from this output.

The numbers reffered to as "special numbers" are "Third largest" and "Closest"
respectively.
