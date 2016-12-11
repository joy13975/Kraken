#ifndef _RESETTABLE_H_
#define _RESETTABLE_H_

namespace Kraken
{

class Resettable
{
public:
    Resettable() {};
    virtual ~Resettable() {};

    virtual void Reset() = 0;

private:
};

} // namespace Kraken

#endif /* include guard */