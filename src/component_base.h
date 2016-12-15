#ifndef _COMPONENT_BASE_H_
#define _COMPONENT_BASE_H_

#include <vector>

#include "util.h"

namespace Kraken
{

class ComponentBase
{
public:
    ComponentBase() {};
    virtual ~ComponentBase() {};

    virtual void hardReset() final
    {
        masters.clear();
        slaves.clear();
        softReset();
        hardResetComponent();
    }

    virtual void softReset() final
    {
        hasReset = true;
        readyCountdown = 0;
        softResetComponent();
    }

    virtual void compute() final
    {
        if (isReady())
            computeComponent();

        readyCountdown--;
    }

    virtual void update() final
    {
        // can only update if ready (except for ready flag itself)
        if (isReady())
            updateComponent();

    }
    virtual void sync() final
    {
        syncComponent();
    }

    bool isReady() const {
        bool amReady = readyCountdown <= 0;

        if (!amReady)
            return false;
        else if (slaves.size() == 0)
            return true;
        else
            for (const ComponentBase * slave : slaves)
                if (slave->isReady())
                    return true;

        // am ready but all slaves busy
        return false;
    }

    static void connect(ComponentBase * master,
                        ComponentBase * slave)
    {
        bool masterHasSlave = false;
        for (const ComponentBase * s : master->slaves)
            if (masterHasSlave = (s == slave))
                return;

        if (!masterHasSlave)
            master->slaves.push_back(slave);

        bool slaveHasMaster = false;
        for (const ComponentBase * m : slave->masters)
            if (slaveHasMaster = (m == master))
                return;

        if (!slaveHasMaster)
            slave->masters.push_back(master);
    }

protected:
    virtual void hardResetComponent() {}
    virtual void softResetComponent() {}
    virtual void computeComponent() {}
    virtual void updateComponent() {}
    virtual void syncComponent() {}
    bool hasReset = false;
    int readyCountdown = 0;

private:
    std::vector<const ComponentBase *> masters;
    std::vector<const ComponentBase *> slaves;

};

} // namespace Kraken

#endif /* include guard */