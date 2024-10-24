#include <iostream>
#include "Math/Math.h"

int main()
{

    const int numb_a = 234;
    const int numb_b = 50;

    auto result = Sum(numb_a, numb_b);

    if (result != 284)
    {
        return -1;
    }
    std::cout << "[debug] Paso el test" << '\n';

    return 0;
}