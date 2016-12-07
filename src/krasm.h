#ifndef _KRASM_H_
#define _KRASM_H_
#include <string>
#include <vector>

using namespace std;
class Krasm
{
public:
    Krasm(const string _rawAsm) :
        rawAsm(_rawAsm) {};
    virtual ~Krasm() {};

    static vector<Krasm> parseFromFile(const string &asmFile);

private:
    const string rawAsm;
};

#endif /* include guard */