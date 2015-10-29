// ----------------------------
// projects/longpath/Longpath.c++
// Copyright (C) 2015
// CS Hui
// ----------------------------

// --------
// includes
// --------

#include <cassert>  // assert
#include <iostream> // endl, istream, ostream
#include <sstream>  // istringstream
#include <string>   // getline, string
#include <utility>  // make_pair, pair
#include <deque>
#include <functional>
#include <map>
#include <climits>
#include <set>
#include <vector>

//include "Longpath.h

using namespace std;
	
// -------------
// longpath_solve
// -------------

void longpath_solve (istream& r, ostream& w) {
    unsigned int	n, p, v;
    unsigned int	rc;
	unsigned int	MOD = 1000000007;
	vector<unsigned int>		v_in, wt;
	

//cout << " longpath_solve" << endl;

	r >> n;
	v_in.push_back(n);
	v_in.reserve(n+1);
	wt.reserve(n+1);
	for (unsigned int i=0; i<n; i++) {		// read the input into v_in vector
		r >> p;
		v_in.push_back(p); }
	
	wt.push_back(2);								// entry 0 is the result
	wt.push_back(2);								// entry 1, i.e. room 1, always has a value of 2
	
	for (unsigned int i=2; i<=n; i++) {		// get value for every room
	
//cout << "i = " << i << endl;
		p = v_in[i];
		v = 2;										// room value is 2 if route back to itself
		for (unsigned int j=p; j<i; j++) {	// accumulate the value from pevious room values
			v += wt[j]; 
			if (v > MOD) {
				v %= MOD; }}
			
//cout << p << " " << i << " " << j << " " <<  wt[j] << " " << v << endl; }
		wt[i] = v; 									// update the room value
		
//cout << i << " : " << v << endl;
 		
		wt[0] += v; 
		if (wt[0] > MOD) {
			wt[0] %= MOD; }}						// update the total value
			
	rc = wt[0] % MOD;								// per problem requirement
	w << rc << endl; 
/*	
	cout << "==================" << endl;
	for (unsigned long long i=1; i<=n; i++) {
		w << i << " : " << wt[i] << endl; }
*/
	
}
	
// ----
// main
// ----

int main () {
    using namespace std;
//    cout << "main" << endl;
    longpath_solve(cin, cout);
    return 0;}


