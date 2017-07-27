#include <stdio.h>
#include <string.h>

// Disassembling and seeing the relocation tables for q3.o revealed that
// a certain function 'togglestr' is being used whose valid return value is 0.
// Also, strcmp is called on the toggled string and the output string and
// when the two do not match (strcmp returns a non zero value), a test is failed.
// Also, using the -s option with objdump shows the data section and we see that
// the output string is the 'toggled' version of the corresponding input string,
// where 'toggled' means every lowercase character is changed to uppercase and
// every uppercase character is changed to lowercase. Hence, togglestr is known.
// So, we must make a function which toggles a string in place, and returns 0.
// Also, we don't need to specially handle the characters which are not alphabets
// in this case because the only non-alphabet is '0' whose ascii value is less than
// even the character 'A'.

int togglestr(char* a)
{
	int i = 0;
	while (a[i])
	{
		if (a[i] >= 'a')
			a[i] = a[i] - 32;			// Convert lowercase character to uppercase
		else if (a[i] >= 'A')
			a[i] = a[i] + 32;			// Convert uppercase character to lowercase
		i++;
	}
	return 0;
}
