#include <iostream>
#include <cmath>
#include <iomanip>

using namespace std;

void gausObr(int cnt_str, double** mass, double** &M_obr)
{
    int i, j, k;
    M_obr = new double*[cnt_str];
    for (i = 0; i < cnt_str; i++)
    {
        M_obr[i] = new double[cnt_str];
        for (j = 0; j < cnt_str; j++)
            M_obr[i][j] = 0;
        M_obr[i][i] = 1;
    }
    
    double a, b;
    for (i = 0; i < cnt_str; i++)
    {
        a = mass[i][i];
        for (j = i + 1; j < cnt_str; j++)
        {
            b = mass[j][i];
            for (k = 0; k < cnt_str; k++)
            {
                mass[j][k] = mass[i][k] * b - mass[j][k] * a;
                M_obr[j][k] = M_obr[i][k] * b - M_obr[j][k] * a;
            }
        }
    }

    double sum;
    for (i = 0; i < cnt_str; i++)
    {
        for (j = cnt_str - 1; j >= 0; j--)
        {
            sum = 0;
            for (k = cnt_str - 1; k > j; k--)
                sum += mass[j][k] * M_obr[k][i];
            if (mass[j][j] == 0)
            {
                for (i = 0; i < cnt_str; i++)
                    delete[] M_obr[i];
                delete[] M_obr;
            }
            M_obr[j][i] = (M_obr[j][i] - sum) / mass[j][j];
        }
    }
}

double** getJ(double* x)
{
    double** J = new double*[2];
    J[0] = new double[2];
    J[1] = new double[2];

    J[0][0] = -2*x[0] - 1;
    J[0][1] = 2*x[1];

    J[1][0] = -2*x[1];
    J[1][1] = -1 - 2*x[0];

    return J;
}

double f1(double* x)
{
  return x[1]*x[1] - x[0]*x[0] - 0.1 - x[0];
}

double f2(double* x)
{
    return 0.1 - x[1] - 2*x[0]*x[1];
}

void perevirka(double x0, double x1) {
  float p1 = x1*x1 - x0*x0 - 0.1 - x0;
  float p2 = 0.1 - x1 - 2*x0*x1;
  cout << endl << "Підставляємо знайдені корені у початкову систему рівнянь: " << endl;
  cout << "Перше рівняння " << setprecision(6) << p1 << endl;
  cout << "Друге рівняння " << setprecision(6) << p2 << endl;
}

int main()
{
    double* x0 = new double[2];
    x0[0] = 0.5; x0[1] = 0.5;

    double** _J = getJ(x0);
    double** J;
    gausObr(2, _J, J);

    double* x1 = new double[2];
    while (true)
    {
        x1[0] = x0[0] - (J[0][0] * f1(x0) + J[0][1] * f2(x0));
        x1[1] = x0[1] - (J[1][0] * f1(x0) + J[1][1] * f2(x0));

        if (abs(x1[0] - x0[0]) < 0.00001 && abs(x1[1] - x0[1]) < 0.00001)
            break;

        x0[0] = x1[0];
        x0[1] = x1[1];
    }

    cout << "Solution:" << endl;
    cout << "x1 = " << x1[0] << endl;
    cout << "x2 = " << x1[1] << endl;

    perevirka(x1[0], x1[1]);
}