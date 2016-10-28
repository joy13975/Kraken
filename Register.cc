#include "Register.hh"

Registers Register::makeRegisters(Clock& clock, const int& n, const int& len)
{
    Registers vr;
    for (int i = 0; i < n; i++)
        vr.push_back(Register(clock, len));

    return vr;
}

Outports Register::getOutports(Registers& regs)
{
    Outports o;
    for (int i = 0; i < regs.size(); i++)
        o.push_back(regs[i].getOutport());

    return o;
}

void Register::clear()
{
    memset(this->out_data, 0, this->byteLength);
}

void Register::writeData(const Byte *data)
{
    memcpy(this->in_data, data, this->byteLength);
}

const Byte* Register::getOutport()
{
    return this->out_data;
}

void Register::readData(Byte *buffer)
{
    memcpy(buffer, this->out_data, this->byteLength);
}

Byte* Register::getInport()
{
    return this->in_data;
}


void Register::onClockRising()
{
    memcpy(this->out_data, this->in_data, this->byteLength);
}

void Register::testClass()
{
    prf("Register test bytes: %d\n", this->byteLength);

    const char *content = "abcdefghijkmnopqrstuvwxyz";
    const int test_len = (this->byteLength) - 1 > strlen(content) ?
                         strlen(content) : (this->byteLength) - 1;
    char *data = strndup(content, test_len);
    data[test_len] = '\0';

    set_leading_spaces(4);
    this->clear();
    Byte buffer[test_len];
    memset(buffer, 0, test_len);
    this->readData(buffer);

    if (strcmp((char*)buffer, ""))
        die("Initial buffer check failed: \"%s\" should be \"%s\"\n", buffer, "");

    this->writeData((Byte *) data);
    this->readData(buffer);

    if (strcmp((char*)buffer, ""))
        die("After-writeData() check failed: \"%s\" should be \"%s\"\n", buffer, "");

    this->onClockRising();
    this->readData(buffer);
    set_leading_spaces(0);

    if (strcmp((char*)buffer, data))
        die("After-onClockRising() check failed: \"%s\" should be \"%s\"\n", buffer, data);

    prf("Buffer based read-write test passed\n");



    set_leading_spaces(4);
    this->clear();
    Byte *port1 = this->getInport();
    const Byte *port2 = this->getOutport();

    if (strcmp((char*) port1, data))
        die("Port1 clear() check failed: \"%s\" should be \"%s\"\n", port1, data);


    if (strcmp((char*) port2, ""))
        die("Port2 clear() check failed: \"%s\" should be \"%s\"\n", port2, "");

    memcpy(&port1, data, sizeof(Byte) * test_len);

    if (strcmp((char*) port2, ""))
        die("After-writeData() port2 check failed: \"%s\" should be \"%s\"\n", port2, "");

    this->onClockRising();
    set_leading_spaces(0);

    if (strcmp((char*) port2, data))
        die("After-onClockRising() port2 check failed: \"%s\" should be \"%s\"\n", port2, data);

    prf("Pointer based read-write test passed\n");

    //wipe input and output
    this->clear();
    memcpy(this->in_data, this->out_data, this->byteLength);
}

Register::~Register()
{
    delete in_data;
    delete out_data;
}

Register::Register(Register const& o) :
    Register(*(o.myClock), o.byteLength)
{
    memcpy(this->in_data, o.in_data, this->byteLength);
    memcpy(this->out_data, o.out_data, this->byteLength);
}

Register& Register::operator=(Register const& o)
{
    if (this != &o)
    {
        memcpy(this->in_data, o.in_data, this->byteLength);
        memcpy(this->out_data, o.out_data, this->byteLength);
    }

    return *this;
}

Register::Register(Clock &clock, int byteLength) :
    Clock::Clockable(clock),
    byteLength(byteLength)
{
    if (byteLength < 0)
        die("Trying to create register of byte negative length %d\n", byteLength);
    in_data     = (Byte*) calloc(1, sizeof(Byte) * byteLength);
    out_data    = (Byte*) calloc(1, sizeof(Byte) * byteLength);
}