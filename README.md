# Game of Life

Author Matt Stevens. Done as a coding exercise to get familiar with Ruby and C. March 2014

To run, use the command line. Navigate to the directory this file is in and type in;
ruby gameOfLife.rb

or for C
gcc GameOfLife_C.c
a.out

## Pre-requisites

You need Ruby and C installed - visit the Ruby and C programming language websites. 

A unix bash style terminal. If running Windows you need Cygwin - visit the Cygwin website

If you find your terminal screen is not clearing between frames, you also need
'ncurses' installed to Cygwin, it contains the 'clear' command that is used. - google for the how to.

## Source Wikipedia

Wikipedia has several articles on Conways Game of Life and patterns.

## Ruby

 I didn't want an infinite surface, so surrounded the surface with a one cell wide dead zone. Gliders, etc will hit this and die.

 Tied in with the dead zone is a 10 cell wide, hidden zone. Partly so the dead zone does not influence the game. 10 cells is overkill, but handy when trying to balance how large the surface should be based on the first few observations of the game.

 Everything is in this one file. Its only ~200 lines of code,plus patterns, plus comments. It just seemed tidier.

 Adding a file reader might be an idea if you want to extrend this, Wikipedia and possibly other places have txt files with interesting patterns. A file reader would make using them easy.

## C
Pointers as expected gave hassles. Otherwise pretty straight forward. It is feature light...

