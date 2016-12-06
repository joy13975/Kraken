CXX:=g++
INC:=-I ..
CXXFLAGS:=-c -O3

.PHONY: all clean

all:
	$(CXX) a64/*.cc $(CXXFLAGS) $(INC)
	$(CXX) *.cc $(CXXFLAGS) $(INC)

clean:
	rm -rf *.o