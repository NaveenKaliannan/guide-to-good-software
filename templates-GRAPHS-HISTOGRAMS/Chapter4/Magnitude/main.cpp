/**
 *
 * @author  Naveen Kumar Kaliannan
 * @
 */



#include<iostream>
#include<fstream>
#include<string>
#include<cmath>
#include<typeinfo>
#include<cstdlib>
#include<vector>

using namespace std;


// Main implementation
int main(int argc, char** argv)
{
  unsigned int len = 228 * 2, len2 = 25;//25
  double dt = 0.4;//0.4
  vector<double> r(len,0.0);
  string filename1 =  "pulse.dat";
  ifstream infile(filename1);
  uint count = 0;
  for(unsigned int i = 0 ; i < len ; ++i)
    {
      infile >> r[i];
      for(uint j = 0; j <  len2; ++j)
        {
          cout << count * dt << "  " << r[i] * 3  << "  " <<  0 << "  " << 0 << endl; 
          count += 1;
        }
    }
  infile.close();
  infile.clear();

  return 0;
}
