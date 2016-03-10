#include <primo.h>

int main(){

  int n = 104395301;

  if (primo(n))
    printf("%d é primo.\n", n);
  else
    printf("%d não é primo.\n", n);
}
