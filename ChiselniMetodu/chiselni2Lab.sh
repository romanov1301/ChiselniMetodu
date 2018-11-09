#include <math.h>
#include <iostream>
using namespace::std;

//Main function.
int main() {
	int n = 4;
	double y = 0;
	bool condition;
	//Error measurement.
	double dd, ee = 0.001;
	double
		A[4][4] = {{ 8.3, 2.62, 4.1, 1.9 },{ 3.92, 8.45, 7.78, 2.4 },{3.77, 7.21, 8.04, 2.28},{ 2.21, 3.65, 1.69, 6.69} };
	double
		B[4] = { -10.65, 12.21, 15.45, -8.35 };
	double V[4][4], P[4], X[4], Y[4];
	for (int i = 0; i < n; i++)
		X[i] = Y[i] = B[i];

	for (int i = 0; i<n; i++)
		for (int j = 0; j<n; j++)
			if (i != j)
			{
				P[i] = B[i] / A[i][i];
				V[i][j] = -A[i][j] / A[i][i];
			}
			else
				V[i][j] = 0;

	do
	{
		condition = false;
		for (int i = 0; i < n; i++)
		{
			dd = 0;
			for (int j = 0; j < n; j++)
				dd += V[i][j] * X[j];
			X[i] = P[i] + dd;

		}

		for (int i = 0; i < n; i++)
		{
			condition = condition || fabs((X[i] - Y[i]) / X[i] * 100) > ee;
			Y[i] = X[i];
		}
	} while (condition);

	//Checking.
	cout << "Solving of system X[]:" << endl;
	for (int i = 0; i < n; i++)
		cout << X[i] << " ";
	cout << endl;

	cout << endl;
	cout << "Check output sum.A[][j]*X[j]:" << endl;

    y=(A[0][0] * X[0] + A[0][1] * X[1] + A[0][2] * X[2] + A[0][3]*X[3]) ;
    cout << y;

	return 0;


}