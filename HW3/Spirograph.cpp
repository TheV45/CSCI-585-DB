#include<bits/stdc++.h>
using namespace std;

int main(){
#ifndef ONLINE_JUDGE
	freopen("output1.txt","w",stdout);
#endif

	double R = 36, r = 9, a = 30;
    double nRev = 10;
    double limit_t = nRev * M_PI;
    double x = 0, y = 0;
    double t = 0;
    double scalingConstant = 0.00004;

    
    while (t <= limit_t) {
        x = (R + r) * cos((r / R) * t) - a * cos((1 + r / R) * t);
        y = (R + r) * sin((r / R) * t) - a * sin((1 + r / R) * t);
        x *= scalingConstant;
        y *= scalingConstant;
        x = -118.28542534540625+ x;
        y = 34.020552980719195 + y;
        cout <<setprecision(17)<< x << "," << y << ",0"<<endl;
        t += 0.01;
    }
}
