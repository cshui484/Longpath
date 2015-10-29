CXX        := g++-4.8
CXXFLAGS   := -pedantic -std=c++11 -Wall
LDFLAGS    := -lgtest -lgtest_main -pthread
GCOV       := gcov-4.8
GCOVFLAGS  := -fprofile-arcs -ftest-coverage
GPROF      := gprof
GPROFFLAGS := -pg
VALGRIND   := valgrind

clean:
	rm -f *.gcda
	rm -f *.gcno
	rm -f *.gcov
	rm -f RunLongpath
	rm -f RunLongpath.tmp
	rm -f TestLongpath
	rm -f TestLongpath.tmp
	rm -f solution
	rm -f *~

config:
	git config -l

scrub:
	make  clean
	rm -f  Longpath.log
	rm -rf longpath-tests
	rm -rf html
	rm -rf latex

status:
	make clean
	@echo
	git branch
	git remote -v
	git status

test: RunLongpath.tmp TestLongpath.tmp

solution: solution.cpp
	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) solution.cpp -o solution

shi: shi.cpp
	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) shi.cpp -o shi

#RunLongpath: Longpath.h Longpath.c++ RunLongpath.c++
#	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) Longpath.c++ RunLongpath.c++ -o RunLongpath
RunLongpath: Longpath.c++
	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) Longpath.c++ -o RunLongpath

RunLongpath.tmp: RunLongpath
	./RunLongpath < RunLongpath.in > RunLongpath.tmp
	diff -w RunLongpath.tmp RunLongpath.out

#TestLongpath: Longpath.h Longpath.c++ TestLongpath.c++
TestLongpath: TestLongpath.c++
	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) TestLongpath.c++ -o TestLongpath $(LDFLAGS)

TestLongpath.tmp: TestLongpath
	$(VALGRIND) ./TestLongpath                                       >  TestLongpath.tmp 2>&1
	$(GCOV) -b Longpath.c++     | grep -A 5 "File 'Longpath.c++'"     >> TestLongpath.tmp
	$(GCOV) -b TestLongpath.c++ | grep -A 5 "File 'TestLongpath.c++'" >> TestLongpath.tmp
	cat TestLongpath.tmp
