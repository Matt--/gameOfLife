/* wrapper ifndef, stops the header file being read twice */
#ifndef HEADER_FILE
#define HEADER_FILE

#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

struct Board{
	int turns;
	float seed;
	int width;
	int height;
	char *surface;
	int arraySize;
} board;

struct Board createBoard(int, int, int, float);
void boardSetUp(struct Board);
void printBoard(struct Board);
int* countNeighbours(struct Board, int*);
void cellLifeCycle(struct Board, int*);
int clamp(int, int, int);
struct Board patternGlider(struct Board, char);
struct Board patternRpentomino(struct Board, char);

#endif
