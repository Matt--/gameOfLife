/* Implementation of Conways Game of life.
	 All up around 160 loc in two files.
	 No parameters, gives a random layout
	'g' shows a glider
	'r' shows the R-pantiminio
*/

#define HEADER "GameOfLife_C.h"

#include HEADER
#define CELL 'O'
#define CELL_EMPTY ' '

int main ( int argc, char *argv[])
{
	int height = 30;
	int width = 60;
	int turns = 2000;
	float seed = 0.1f;
  char pattern;
	/* sets random seed */
	srand(time(NULL));
	/* command line input */
	if(argc > 1){
		if  (*argv[1] == '1'){ seed = 1.0f; }
		else if (*argv[1] == '0') { seed = 0.0f; }
    else if (*argv[1] == 'g'){pattern = 'g'; seed= 0.0f;}
    else if (*argv[1] == 'r'){pattern = 'r'; seed= 0.0f;}
	}
	/* create the board */
	struct Board board = createBoard(height, width, turns, seed);
	boardSetUp(board);
	/* define which pattern */
		// This is a glider
  if(pattern == 'g'){ board = patternGlider(board, pattern);}
		// The R-pentomino
  if(pattern == 'r'){ board = patternRpentomino(board, pattern);}

  /* start loop */
	printBoard(board);
	int count = 0;
	while(count++ < board.turns){
		// count how many cells surround each location
		int *countCells = malloc(sizeof(int) * board.arraySize); // freed after cellLifeCycle method.
		countCells = countNeighbours(board, countCells);
		// use the count to kill/breed cells
    cellLifeCycle(board, countCells);
		free(countCells);
		// display
		printf("turn %d of %d. Control-c to stop.", count, board.turns);
		printBoard(board);
		usleep(100 *1000); // uses micro-seconds => milliseconds *1000.
	};
	free(board.surface);
	return 0;
} /*--------------------- end main ------------------------*/

void cellLifeCycle(struct Board board, int* countCells){
  int i;
  for(i=0; i < board.arraySize; i++){
    if(board.surface[i] == CELL && (*(countCells +i) < 2 || *(countCells +i) > 3)){
      board.surface[i] = CELL_EMPTY;
    }else if(board.surface[i] == CELL_EMPTY && *(countCells +i) == 3){
      board.surface[i] = CELL;
    }
  }
}

int* countNeighbours(struct Board board, int *count){
	int search[8][2] = {
		{-1,-1},{0,-1},{1,-1},
		{-1, 0},			 {1, 0},
		{-1, 1},{0, 1},{1, 1}};
	// loop through the board
	int i, j, x, y, potentialCell;
	for(i = 0 ; i < board.arraySize; i++){
		y = (int)(i/board.width);
		x = i%board.width;
		count[i] = 0;
		int search_x, search_y;
		for(j=0; j < 8; j++){
			// check searched x & y are within the board boundaries.
			search_x = x + search[j][0];
			search_y = ((y + search[j][1]) * board.width);
			if(search_y != clamp(search_y, 0, board.height * board.width) ||
				search_x != clamp(search_x, 0, board.width)) { continue; }
			// if potential cell is a cell, i is the cell being searched from, increase its count
			potentialCell = search_y + search_x;
			if(board.surface[potentialCell] == CELL){
				count[i]++;
			}
		}
	}
  return count;
}

void printBoard(struct Board board){
	int i;
	char *result = malloc(sizeof(int) * board.arraySize); // freed at end of this method

	int b = 0;
	int r = 0;
	for( ; b < board.arraySize; b++){
		if(b != 0 && b%board.width == 0){ result[r++] = '\n';};
		result[r] = board.surface[b];
		r++;
	}
	system("clear");
	printf("%s\n", result );
	free(result);
}

void boardSetUp(struct Board board){
	int i;
	for(i = 0 ; i < board.arraySize; i++){
		if(board.seed == 0.0f || board.seed == 1.0f){
			board.surface[i] = (board.seed == 0.0f) ? CELL_EMPTY : CELL;
		}else{ 
			board.surface[i] = (float) rand()/RAND_MAX > board.seed ? CELL_EMPTY : CELL;
		}
	}
}

struct Board createBoard(int height, int width, int turns, float seed){
	/* create board */
	struct Board board;
	board.turns = turns;
	board.seed = seed;
	board.width = width;
	board.height = height;
	board.surface = malloc(sizeof(int) * board.height * board.width); // freed at end of main method
	board.arraySize = width * height;
	return board;
};

int clamp(int value, int min, int max){
	return (value < min) ? min : (value > max) ? max : value;
}

struct Board patternGlider(struct Board board, char pattern){
    printf("Pattern is : %c\n", pattern);
    board.surface[2 * board.width + 1] = CELL;
    board.surface[2 * board.width + 2] = CELL;
    board.surface[2 * board.width + 3] = CELL;
    board.surface[1 * board.width + 3] = CELL;
    board.surface[0 * board.width + 2] = CELL;
	return board;
}

struct Board patternRpentomino(struct Board board, char pattern){
    printf("Pattern is : %c\n", pattern);
		board = createBoard(50, 120, 1105, 0.0f);
		boardSetUp(board);
    board.surface[(board.height/2 -1) * board.width + board.width/2] = CELL;
    board.surface[(board.height/2 -1) * board.width + board.width/2 +1] = CELL;
    board.surface[(board.height/2) * board.width + board.width/2 -1] = CELL;
    board.surface[(board.height/2) * board.width + board.width/2] = CELL;
    board.surface[(board.height/2 +1) * board.width + board.width/2] = CELL;
	return board;
}

