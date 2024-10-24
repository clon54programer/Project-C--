#ifndef MATH_H
#define MATH_H

extern "C"
{
    int Sum(int numb_a, int numb_b);
}

template <typename Type>
Type SumT(Type numb_a, Type numb_b)
{
    return numb_a + numb_b;
}

#endif