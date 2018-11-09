#include <iostream>
#include <math.h>
using namespace std;

float f(float x)
{
    return 1/(x*pow(1+2*x,2));
}

float pervisna(float x){
    return 1/(1+2*x) - log((1+2*x)/x);
}

float integralpram(int a,int b,int n)
{
    float h,sum,x;
    int i;
    h=(b-a) * 1.0 /n;
    sum=0;
    for(i=1;i<n;i++)
    {
        x=a+i*h;
        sum=sum+f(x);
    }
    sum=h*(sum+f(a)/2+f(b)/2);
    return sum;
}

int main()
{
   float  result;
   result = integralpram(1,2,30);
   cout << "Метод трапецій " << endl;
   cout << "Отриманий корінь " << result << endl;
   cout << "Перевірка(формула Ньютона-Лейбніца) " << pervisna(2)-pervisna(1);
   return 0;
}