# Game of Life

 ** Author Matt Stevens, done as a coding exercise to get familiar with Ruby. March 2014

 ** To run, use the command line. Navigate to the directory this file is in and type in;
ruby gameOfLife.rb

 ** Pre-requisites
You need Ruby installed - visit the Ruby programming language website 

A unix bash style terminal. If running Windows you need Cygwin - visit the Cygwin website

If you find your terminal screen is not clearing between frames, you also need
'ncurses' installed to Cygwin, it contains the 'clear' command that is used. - google for the how to.

 ** Source Wikipedia
Wikipedia has several articles on Conways Game of Life and patterns.

 ** Design decisions
 I didn't want an infinite surface, so surrounded the surface with a one cell wide dead zone. Gliders, etc will hit this and die.

 Tied in with the dead zone is a 10 cell wide, hidden zone. Partly so the dead zone does not influence the game. 10 cells is overkill, but handy when trying to balance how large the surface should be based on the first few observations of the game.

 Everything is in this one file. Its only ~200 lines of code,plus patterns, plus comments. It just seemed tidier.

 Adding a file reader might be an idea if you want to extrend this, Wikipedia and possibly other places have txt files with interesting patterns. A file reader would make using them easy.

These are notes from a file that helped to me get started.

Conway's Game of Life in Ruby
http://en.wikipedia.org/wiki/Conway's_Game_of_Life

Some code from this excellent article:
http://rubyquiz.strd6.com/quizzes/193-game-of-life

Cheers!
Matt
