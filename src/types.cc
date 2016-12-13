#include <fstream>

#include "types.h"

namespace Kraken
{

ProgramInfo::ProgramInfo(std::ifstream &&binStream)
    : image_(loadImage<Word * >(binStream)),
      elf_(elfPriv_),
      imgSize_(imgSizePriv_),
      entry_(reinterpret_cast<Word*>(elf_.e_entry)),
      textStart_(getBoundary<Word * >(binStream, ".text", false)),
      textEnd_(getBoundary<Word * >(binStream, ".text", true)),
      dataStart_(getBoundary<Word * >(binStream, ".data", false)),
      dataEnd_(getBoundary<Word * >(binStream, ".data", true))
{
}

size_t ProgramInfo::getImgSize(std::ifstream &binStream)
{
    binStream.seekg(0, std::ios::end);
    return (size_t) binStream.tellg();
}

} // namespace