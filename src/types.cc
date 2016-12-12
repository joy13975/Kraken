#include <fstream>

#include "types.h"

namespace Kraken
{

ProgramInfo::ProgramInfo(std::ifstream &&binStream)
    : image_(loadImage<Word * >(binStream)),
      elf_(elfPriv_),
      imgSize_(imgSizePriv_),
      entry_(reinterpret_cast<Word*>(elf_.e_entry)),
      textStart_(getTextBoundary<Word * >(binStream, false)),
      textEnd_(getTextBoundary<Word * >(binStream, true))
{
}

size_t ProgramInfo::getImgSize(std::ifstream &binStream)
{
    binStream.seekg(0, std::ios::end);
    return (size_t) binStream.tellg();
}

} // namespace