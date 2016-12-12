#ifndef _COMPONENT_BASE_H_
#define _COMPONENT_BASE_H_

namespace Kraken
{

class ComponentBase
{
public:
    ComponentBase() {};
    virtual ~ComponentBase() {};

    virtual void reset() = 0;
    virtual void update() = 0;

private:
};

} // namespace Kraken

#endif /* include guard */