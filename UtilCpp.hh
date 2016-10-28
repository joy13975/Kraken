#ifndef _UTILCPP_HH_
#define _UTILCPP_HH_

#include "util.h"

using VoidVoidFunc = void(*)();

class Testable
{
public:
    virtual ~Testable() {};
    virtual void testClass() = 0;
};

#endif /* include guard */