#include <stdio.h>
#include <string.h>

int main() {
  char in0[] = "something";
  char in1[] = "SomethinG";
  char in2[] = "S0mething";

  int i = 0;
  while (in0[i]) {
    in0[i] = tolower(in0[i]);
    in1[i] = tolower(in1[i]);
    in2[i] = tolower(in2[i]);
    i++;
  }

  int test_failed = 0;
  if (strcmp(in0, "SOMETHING")) {
    test_failed++;
  }
  if (strcmp(in1, "SOMETHING")) {
    test_failed++;
  }
  if (strcmp(in2, "S0METHING")) {
    test_failed++;
  }

  if (test_failed) {
    printf("%d out of 3 tests failed. Please try again.\n", test_failed);
  } else {
    printf("All tests passed. Congrats!\n");
  }

  return 0;
}
