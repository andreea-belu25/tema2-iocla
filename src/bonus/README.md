# Optimized checkers

We want to optimize the representation of the playing surface from Task 4 so that it takes up less memory and the position calculations are done faster.

A possible optimization is represented by the notion of "Bitboard". "Bitboard" represents a binary data structure in which each bit represents the presence or absence of a piece on a certain position of the game board. Usually, in C, to represent a bitboard, a variable of type 'unsigned long long' is used.
'unsigned long long' is a data type that contains 64 bits (8 bytes). An 8x8 game board can be intuitively represented with a single variable of this type, grouping, at a logical level, 8 bits for each line on the surface. Unfortunately, we do not have access to 64-bit registers in the course, so you have to use 2 registers to represent the game surface.

`x - the column on which the piece whose position we want to calculate is located'

`y - the line on which the piece whose position we want to calculate is located'

`board - two whole numbers that represent the playing surface. The first number represents the upper part of the surface, while the second number represents the lower part.`