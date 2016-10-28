#ifndef _JINSTRUCTION_HH_
#define _JINSTRUCTION_HH_

#include "string.h"
#include "JProcDefs.hh"

#define FOREACH_OperandFmt(MACRO) \
    MACRO(OPRFMT_NONE) \
    MACRO(OPRFMT_RRR) \
    MACRO(OPRFMT_RRI) \
    MACRO(OPRFMT_RR) \
    MACRO(OPRFMT_RI) \
    MACRO(OPRFMT_IRR) \
    MACRO(OPRFMT_IR) \
    MACRO(OPRFMT_I)
DECL_ENUM_AND_STRING(OperandFmt, FOREACH_OperandFmt);

#define FOREACH_XUnitOp(MACRO) \
    MACRO(XUOP_NONE) \
    MACRO(XUOP_ADD) \
    MACRO(XUOP_SUB) \
    MACRO(XUOP_MUL) \
    MACRO(XUOP_DIV) \
    MACRO(XUOP_LD) \
    MACRO(XUOP_ST) \
    MACRO(XUOP_B) \
    MACRO(XUOP_BLT) \
    MACRO(XUOP_BZ)
DECL_ENUM_AND_STRING(XUnitOp, FOREACH_XUnitOp);

#define FOREACH_XUnitCtrl(MACRO) \
    MACRO(XUCTRL_NONE) \
    MACRO(XUCTRL_HALT) \
    MACRO(XUCTRL_IMDV) \
    MACRO(XUCTRL_RELV) \
    MACRO(XUCTRL_VSET)
DECL_ENUM_AND_STRING(XUnitCtrl, FOREACH_XUnitCtrl);

#define GET_REAL_ENUM_NAME(NAME_STR) (strstr(NAME_STR, "_") + 1)

typedef struct
{
    XUnitCtrl       xUnitCtrl;
    XUnitOp         xUnitOp;
    OperandFmt      operandFmt;
} JInstruction;

static const JInstruction JInsTable[] = {
    { XUCTRL_NONE,      XUOP_NONE,  OPRFMT_NONE},
    { XUCTRL_NONE,      XUOP_ADD,   OPRFMT_RRR },
    { XUCTRL_IMDV,      XUOP_ADD,   OPRFMT_RRI },
    { XUCTRL_NONE,      XUOP_SUB,   OPRFMT_RRR },
    { XUCTRL_IMDV,      XUOP_SUB,   OPRFMT_RRI },
    { XUCTRL_NONE,      XUOP_MUL,   OPRFMT_RRR },
    { XUCTRL_IMDV,      XUOP_MUL,   OPRFMT_RRI },
    { XUCTRL_NONE,      XUOP_DIV,   OPRFMT_RRR },
    { XUCTRL_IMDV,      XUOP_DIV,   OPRFMT_RRI },
    { XUCTRL_NONE,      XUOP_LD,    OPRFMT_RR  },
    { XUCTRL_IMDV,      XUOP_LD,    OPRFMT_RI  },
    { XUCTRL_NONE,      XUOP_ST,    OPRFMT_RR  },
    { XUCTRL_IMDV,      XUOP_ST,    OPRFMT_IR  },
    { XUCTRL_NONE,      XUOP_B,     OPRFMT_I   },
    { XUCTRL_RELV,      XUOP_B,     OPRFMT_I   },
    { XUCTRL_NONE,      XUOP_BLT,   OPRFMT_IRR },
    { XUCTRL_RELV,      XUOP_BLT,   OPRFMT_IRR },
    { XUCTRL_NONE,      XUOP_BZ,    OPRFMT_IR  },
    { XUCTRL_RELV,      XUOP_BZ,    OPRFMT_IR  },
    { XUCTRL_HALT,      XUOP_NONE,  OPRFMT_NONE},
    { XUCTRL_VSET,      XUOP_NONE,  OPRFMT_RRR }
};

#endif /* include guard */