# 8_BOX_PUZZLE-SOLVER
## Brief introduction

This is a very simple implementation of an 8 puzzle solver, that uses the in-bult standard libraries of Ruby to provide a solution

Users are required to place their desired **present_state** (the unsolved state) inside the .rb extension file.

We have also provided a **solution_state** so that custom solutions can be solved too.

Using helper methods, the **present_state** and the **solution_state** can be modified too. As for convinience, there is a display method, that prints the present and goal state.

> **What to know before using this:**
>
> You are required to have Ruby installed. Any Ruby compiler will do fine too, but we would recommend to install JRuby for quicker setup, and MRI for the stock development environment.
>
> _How to check if Ruby is properly installed or not?_
>
> Try typing ruby -v in any terminal. If it shows an error, either Ruby was not installed properly, or there is some problem with the **PATH** location.
>
> Here, 0 is the equivalent of blank space.
>
> If the batch or shellscript files are not working, change the directory of the terminal to the location of _heurestic.rb_, and try _ruby heurestic.rb_.

> **Note:**
>
> This is not an optimised code, although it may run without any hitch, and there are many ways by which the memory usage can be reduced.
>
> But assuming that we are using negligible resources, and also following the philosophy of "free RAM is wasted RAM", we will not look into that.

## Problem Definition
In this puzzle, we have a 3x3 grid containing 9 squares out of which eight tiles are numbered and one is blank.

The blank can move in any two dimensional position, but is constrained by the dimension of the nine tiles.

Given an arbitrary initial configuration of the grid,the problem solving agent needs to find an optimal sequence of actions that lead to the goal state, if there is one.

The initial state can be any possible configuration of the 3x3 grid.
On the other hand, the goal state has a definite order that is discussed later.

## Problem Formulation
- State Description
- Initial State & Goal State
- Step & Path Costs

### State Description :
A state is described by the positions of the tiles and blank in a state array. It consists of two states - initial, and final (or goal) state.

    Initial state = [1 2 3]
                    [0 4 6]
                    [7 5 8]

    Final state =   [1 2 3]
                    [0 4 6]
                    [7 5 8]

###  Step & Path Costs
* We can move in any possible direction, as long as it follows the constraints of moving inside a locked two dimensional box.
* We calculate the heurestic value of the next possible combinations using heurestic function, which is based on Manhattan distance traversal.
* We select the lowest heurestic value for each possible movements, and proceed with it
* Repeat it until we reach our goal state.
* Path cost is the sum of all the step costs in the path(sequence of states).
* Consider a transition froSm state A to state B: F(n)= G(n) + H(n) 

                    Initial 
                     State
                    [1 2 3]
                    [0 4 6]
                    [7 5 8]
                    h(n)=4
                    /  |  \
                   /   |   \
                  /    |    \
                 /     |     \
                /      |      \
               /       |       \
        [0 2 3]     [1 2 3]     [1 2 3]
        [1 4 6]     [4 0 6]     [7 4 6]
        [7 5 8]     [7 5 8]     [0 5 8]
        h(n)=5      h(n)=3      h(n)=5
                    /  |  \
                   /   |   \
                  /    |    \
                 /     |     \
                /      |      \
               /       |       \
        [1 0 3]     [1 2 3]     [1 2 3]
        [4 2 6]     [4 5 6]     [4 6 0]
        [7 5 8]     [7 0 8]     [7 5 8]
        h(n)=4      h(n)=2      h(n)=4
                    /     \
                   /       \
                  /         \
                 /           \
                /             \
               /               \
        [1 2 3]                 [1 2 3]
        [4 5 6]                 [4 5 6]
        [0 7 8]                 [7 8 0]
        h(n)=3                  h(n)=0
                                  Goal
                                  State
