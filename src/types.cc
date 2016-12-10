#include <fstream>

#include "types.h"

namespace Kraken
{

ProgramInfo::ProgramInfo(std::ifstream &&binStream)
    : binSize_(getBinSize(binStream)),
      binary_(getBinary<Word>(binStream)),
      elf_(reinterpret_cast<const Elf64_Ehdr * const>(binary_)),
      entry_(getEntryPoint<Word * >()),
      textStart_(getTextBoundary<Word * >(false)),
      textEnd_(getTextBoundary<Word * >(true))
{
}

size_t ProgramInfo::getBinSize(std::ifstream &binStream)
{
    binStream.seekg(0, std::ios::end);
    return (size_t) binStream.tellg();
}

State::State(const ProgramInfo &pi)
    : baseAddr_(initMemory<Word>(pi))
{
};

ptrdiff_t State::getPcOffset() const
{
    return subPointers<ptrdiff_t>(pc_, baseAddr_);
};

} // namespace