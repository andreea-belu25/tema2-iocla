# Task 1 - simple cipher #
This encryption algorithm involves shifting to the right within the alphabet a
each character a certain number of times.

For example, the text "ANABANANA" turns into "BOBCBOBOB" when the step is 1.

Thus, an encryption with step 26 does not change the letter because the English alphabet has 26 characters.

For this task, you will need to implement the `simple()` function in the `simple.asm` file
which encrypts a string in the clear using the method described above.

The function header is:

```
void simple(int n, char* plain, char* enc_string, int step);
```

The meaning of the arguments is:
- **n** text size
- **plain** string to be encrypted
- **enc_string** the address to which the encrypted text will be written
- **step** how much each character is shifted

Restrictions:
- all **capital letters** of the English alphabet will be used
- shifting is done **strictly** within the alphabet