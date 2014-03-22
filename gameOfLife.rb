# Game of Life

# ** Author Matt Stevens, done as a coding exercise to get familiar with Ruby March 2014


class Cell
	def initialize seed_prob
    if seed_prob == 1
      @alive = true
    elsif seed_prob == 0
      @alive = false
    else
		  @alive = seed_prob > rand
    end
	end

	def alive?
		# satisfies rules 1 to 4 above
		@alive = @alive ? (2..3) === @neighbours : 3 == @neighbours
	end

	def neighbours=(value)
		@neighbours = value
	end

  def dead
    @alive = false
  end

	def to_i
		# allows counting cells
		@alive ? 1 : 0
	end

	def to_s
		# allows printing cells
		@alive ? 'O' : ' '
	end
end

class Board

	def initialize( height, width, turns, seed_probability)
		@height, @width, @turns = height, width, turns
		@surface = 
			Array.new(height){
				Array.new(width){
					Cell.new(seed_probability)}}				
	end

  def surface
    @surface
  end
  def surface= (value)
    @surface = value
  end
  def turns
    @turns
  end

	def play
	  if @turns == 0 then
      # for checking setup is correct
			system('clear') # clears the screen so each frame appears at the same spot
			puts self
    else
      # main game loop
  		(1..@turns).each do |i|
        nextMove
	  		system('clear') # clears the screen so each frame appears at the same spot
	  		puts self.to_s
        puts "turn #{i}"
	  	end
    end
	end

	def nextMove
		# iterate through the cells to get a count of neighbours
		@surface.each_with_index{ |row, x|
			row.each_with_index{		|cell, y|
				cell.neighbours = countNeighbours(x, y) }}
    # iterate through again to reset life based on counts
		@surface.each { 
      |row| row.each {		
        |cell| cell.alive? }}
    # board edges are always dead
    (0..@height-1).each do |y|
      @surface[y][0].dead
      @surface[y][@width-1].dead
    end
    (0..@width-1).each do |x|
      @surface[0][x].dead
      @surface[@height-1][x].dead
    end
	end

	def countNeighbours(x, y)
		# set up reference array
		[[-1,-1], [-1, 0], [-1, 1],
		 [ 0,-1],          [ 0, 1],
		 [ 1,-1], [ 1, 0], [ 1, 1]].inject(0) do |sum, pos|
			sum + @surface[(x + pos[0]) % @height] [(y + pos[1]) % @width].to_i
		end
	end

	# print out the board
	def to_s
    output = ''
    (10..@height-10).each do |y|
      (10..@width-10).each do |x|
        output += @surface[y][x].to_s
      end
      output += "\n"
    end
    return output
	end

end

module Pattern
  def Pattern.random turns
    turns = (Integer(turns) rescue false) ? Integer(turns) : 200
    board = Board.new(60, 60, turns, 0.1)
    return board, board.turns, "Random seed"
  end

  def Pattern.gospersGlider turns
    turns = (Integer(turns) rescue false) ? Integer(turns) : 200
    board = Board.new(60, 60, turns, 0)
    board.surface = Util.setup board.surface, [[0],[0],[0],[0],[0],[0],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,0,0,0,1,0,1,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]
    return board, board.turns, "Gospers glider"
  end

  def Pattern.r_pentomino turns
    turns = (Integer(turns) rescue false) ? Integer(turns) : 1110
    board = Board.new(100, 150, turns, 0)
    board.surface= Util.setup board.surface,[
     [0],[0],[0],[0],[0],
     [0],[0],[0],[0],[0],
     [0],[0],[0],[0],[0],
     [0],[0],[0],[0],[0],
     [0],[0],[0],[0],[0],
     [0],[0],[0],[0],[0],
     [0],[0],[0],[0],[0],
     [0],[0],[0],[0],[0],
     [0],[0],[0],[0],[0],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0]]
    return board, board.turns, "R-pentomino"
  end

  def Pattern.p18 turns
    turns = (Integer(turns) rescue false) ? Integer(turns) : 200
    board = Board.new(60, 60, turns, 0)
    board.surface= Util.setup board.surface,[
     [0],[0],[0],[0],[0],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
     [0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1],
     [0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,0,1],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,0,1,0,0,1,0,0,1,0,0,1,0,0,1],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,1,0,0,1,0,1],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1],
     [0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
     [0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,1],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
     [0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1],
     [0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,0,1],
     [0,0,0,0,0,0,0,1,0,1,0,0,1,0,1,0,0,1,0,0,1,0,0,1,0,0,1],
     [0,0,0,0,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,1,0,0,1,0,1],
     [0,0,0,0,0,0,0,1,0,1,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1],
     [0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
     [0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
     [0,1,1]]
    return board, board.turns, "117P18 oscillator"
  end

end

module Util
  def Util.play board
      board[0].play
      sum=0
      board[0].surface.each {|row|
        row.each {|cell| sum += cell.to_i }}
      puts "#{board[2]} played for #{board[1]} turns. #{sum} cells left alive."
  end
  def Util.setup surface, seeds
    x = y = 10    
    seeds.each do
      |row| row.each do
        |seed| 
          (seed == 1) ? (surface[y][x] = Cell.new seed) : 0
          x+=1  
      end
      y+=1
      x=10
    end
    return surface
  end
end

board = Array.new(3)
ARGV[0].nil? ? ARGV[0]='empty' : 0
case ARGV[0].downcase
  when 'gospers glider', 'gospers', 'gg'
      board = Pattern.gospersGlider ARGV[ARGV.size-1]
  when 'r-pentomino', 'r-p', 'rp'
      board = Pattern.r_pentomino ARGV[ARGV.size-1]
  when '117p18', 'p18', 'p'
      board = Pattern.p18 ARGV[ARGV.size-1]
  when 'random', 'r'
      board = Pattern.random ARGV[ARGV.size-1]
  else
      system "clear"
      puts "\n\n   Game of Life    ...implemented by Matt, March 2014\n\n"
      puts "To run, run the file again and add one of these arguements;"
      puts "   Gospers glider or gospers or gg"
      puts "   R-Pentomino or r-p or p"
      puts "   117P18 or p18 or p"
      puts "A last arguement may be added for a turn limit.\n\n"
      puts "For example R-Pentomino is set to run for 1103 turns\n before stabilising. Feel free to give it a shorter\n turn limit. The other patterns default to 200 turns."
      puts "\nTry 'ruby gameOfLife.rb gg 50'"

  end 
Util.play board if ARGV[0] != 'empty'
