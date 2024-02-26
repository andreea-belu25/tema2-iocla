TASK 1:
I go through the string, put each letter in an empty register, add step to it. Then, I compare the letter with Z (in the string we only have capital letters). If it is smaller than Z => I put it in the resulting string and move to the next letter, otherwise I subtract 26 from it.

TASK 2:
Exercise 1 (sorting):
-> sort with two fors: the first goes from i = 0 to i = length -2, the second from j = i + 1 to j = length - 1
-> I save the element from position i, I move 5 bytes and save the second one
-> compare the priorities of the two elements, taking into account that they are of the byte type, if they are in order desc => interchange. Otherwise, if they are equal => compare the times of the two elements. If they are in order descr => exchange, if they are equal => compare the pids. For exchanges, I use an auxiliary variable. I cast to the size when I move to a register/sub-register. Then, I move on to the element from pose j + 1. When I have finished the second step for the element from step i => I move on to the first step. When I reached the end of the first frame => I finish the program.

Exercise 2:
I go through the vector and check what priority the current element has. As a result, I add the time of the current element to the corresponding value in the time_result vector and add 1 to the number of elements that have the same priority to the corresponding value in prio_result. Both vectors are indexed from 0, so for prio i, I will have time_result[i - 1] and prio_result[i - 1]. I take care to move to the next element, taking into account the type of element in the vectors, that is, the number of bytes between 2 consecutive elements. After I have finished putting values in the two vectors, for each priority I share time_result with prio_result, taking care to have the registers eax (in which I keep the bit) and edx (in which I keep the rest) empty, but also to deal with the case when I share to 0, in which case I go to the last priority. Then, I move the content of eax and edx into the proc_avg vector, always moving by 2 bytes from the initial position.

TASK 3:
I determine which lines need to be changed, according to the rotor. Then, I determine if I have to move with the characters to the right or to the left, as forward.
-> For the right, I exchange the elements from picture i - 1 and i on the respective line, starting from the end of the line/the last character (picture 25) up to the character on picture 1 of the string.
-> For the left, we exchange elements from position i + 1 and i on the respective line, starting from the beginning of the line/first character (position 0) up to the character on position 24 of the string.
I repeat the procedure x times. I do the same thing for the next line, taking care to reinitialize the two forums that I use accordingly. I take into account that there are 26 characters on each line to find out the index of the beginning of the next line.

TASK 4:
Starting from x and y, I treat the cases:
1. x - 1, y - 1. I compare the values with 0 to know if I left the matrix, in which case I move to the next case. Otherwise, I calculate at the next element of the matrix I have to put 1 according to the formula no. of lines * 8 + no. of columns.
2. x + 1, y + 1. I compare the values with 7 to know if I left the matrix, in which case I move to the last case. Otherwise, I calculate at the next element of the matrix I have to put 1 according to the formula above.
3. x - 1 which I compare with 0 and y + 1 which I compare with 7. If x - 1 < 0 or y + 1 > 7 => I cannot put 1 in this position => I go to the last case . Otherwise, I calculate at the next element of the matrix I have to put 1 according to the formula above.
4. x + 1 > 7 or y - 1 < 0 => I cannot put 1 => end the program. Otherwise, I put 1 as above.

BONUS:
I find out if I can put it in the corresponding position 1 according to the cases above. I find out which element in the matrix becomes 1 and compare this value with 31 to find out in which part of the matrix I am, board[0] - the top part, bits 32->63 or board[1] - the bottom part, bits 0->31. I have the relationship [ecx] | (1 << th elem) or [ecx + 4] | (1 << th elem). In addition, if I am in board[1] => the next element is calculated with no. of lines * 8 + no. of columns, for board[1] => 31 - (7 - line) * 8 - (7 - column). The procedure is repeated for all 4 cases.