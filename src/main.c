#include "stdio.h"
#include "pico/stdlib.h"


int main() {
    stdio_init_all();
    printf("Hello PICO!");
    while(true) {}
    return 0;
}
