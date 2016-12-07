#include <fstream>

#include "krasm.h"
#include "util.h"

vector<Krasm> Krasm::parseFromFile(const string &asmFile)
{
    vector<Krasm> prog;

    std::ifstream ifs(asmFile);
    if (!ifs.is_open())
        err("Could not open file: %s\n", asmFile.c_str());

    for (string line; getline(ifs, line); )
    {
        // dbg("%s\n", line.c_str());
        prog.emplace_back(line);
    }

    return prog;
}