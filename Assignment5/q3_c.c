#include<stdio.h>
/* Opening the file with hexdump, we saw that there were a set of toggled strings where letters were toggled and the number 0 was left unchanged. Also all the test case were versions of string 'Something'. Compiling both the files gave an error saying 'undefined reference to function _toglestr' which confirmed the suspicion that a togglestr function is called in the assembly program. Therefore, we wrote a togglestr function in C which toggled the argument string in place. Linking both the  object files together then, gave the message 'All test cases passed.' So that was all that was needed.. */

void togglestr(char *a){
int i=0;
while(a[i]){
	if(a[i]>='a')
	a[i]=a[i]-32;
	else if (a[i]>='A')
	a[i]=a[i]+32;
	i++;
}
//	return a;
}

