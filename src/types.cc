#include <fstream>

#include "types.h"
#include "vixl/a64/decoder-a64.h"

namespace Kraken
{

void BranchRecords::updateRecord(const InstrPtr instr,
                                 const InstrPtr branchDest)
{
    for (Record & br : records)
        if (br.instr == instr)
        {
            br.update(branchDest != instr->NextInstruction());
            return;
        }

    if (instr == branchDest)
        die("Tried to add record of no pc change\n");

    // no matching record
    dbg("Adding new BP record for %p -> %p\n", instr, branchDest);
    records.emplace_back(maxLen, instr, branchDest);
}

void BranchRecords::clearRecords()
{
    records.clear();
}

InstrPtr BranchRecords::predict(const InstrPtr instr) const
{
    if (!instr)
        return 0;

    if (!vixl::Decoder::isBranch(instr))
        return instr->NextInstruction();

    if (instr >= textEnd)
    {
        wrn("Branch predict: reaching end of instructions\n");
        return instr;
    }

    if (mode == NoneMode)
    {
        // no prediction - simply return next instr
        return fixedPredict(instr);
    }
    else
    {
        for (const Record & br : records)
            if (br.instr == instr)
                return mode == StaticMode ?
                       br.staticPredict()
                       :
                       br.dynamicPredict();

        // no matching record; default to fixed (no) prediction
        return fixedPredict(instr);
    }
}

InstrPtr BranchRecords::fixedPredict(const InstrPtr _instr) const
{
    if ((short) mode >= StaticMode)
    {
        // at least check uncond
        const uint32_t flag1 = _instr->Bits(27, 24);
        if (flag1 >= 4 && flag1 <= 7)
        {
            const uint32_t flag2 = _instr->Bits(31, 29);
            const bool isUncondBr = flag2 == 4 || flag2 == 0;
            if (isUncondBr)
                return _instr->ImmPCOffsetTarget();
        }
    }

    return _instr->NextInstruction();
}

BranchRecords::Record::Record(const unsigned short _maxLen,
                              const InstrPtr _instr,
                              const InstrPtr _branchDest)
    : maxLen(_maxLen),
      instr(_instr),
      branchDest(_branchDest)
{
}

void BranchRecords::Record::update(bool branchTaken)
{
    if (history.size() >= maxLen)
        history.pop_back();

    history.push_front(branchTaken);
}

InstrPtr BranchRecords::Record::staticPredict() const
{
    // forward not taken, backward -> loop, mostly taken
    return branchDest > instr ? instr->NextInstruction() : branchDest;
}

InstrPtr BranchRecords::Record::dynamicPredict() const
{
    int direction = 0;
    for (bool taken : history)
        direction += taken;

    if (direction > 0)
        return branchDest;
    else if (direction < 0)
        return instr->NextInstruction();
    else // could not decide - default to static
        return staticPredict();
}

ProgramInfo::ProgramInfo(std::ifstream &&binStream)
    : image(loadImage<Word * >(binStream)),
      elf(elfPriv),
      imgSize(imgSizePriv),
      entry(reinterpret_cast<Word*>(elf.e_entry)),
      textStart(getBoundary<Word * >(binStream, ".text", false)),
      textEnd(getBoundary<Word * >(binStream, ".text", true)),
      dataStart(getBoundary<Word * >(binStream, ".data", false)),
      dataEnd(getBoundary<Word * >(binStream, ".data", true))
{
}

size_t ProgramInfo::getImgSize(std::ifstream &binStream)
{
    binStream.seekg(0, std::ios::end);
    return (size_t) binStream.tellg();
}

} // namespace