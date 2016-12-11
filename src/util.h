#ifndef _UTIL_H
#define _UTIL_H

#if defined (__cplusplus)
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

//enum-string generation
#define GENERATE_ENUM(ENUM) ENUM,
#define GENERATE_STRING(STRING) #STRING,
#define DECL_ENUM_AND_STRING(TYPE_NAME, TYPE_STRING_NAME, FOREACH_MACRO) \
    typedef enum { \
        FOREACH_MACRO(GENERATE_ENUM) \
    } TYPE_NAME; \
    static const char *TYPE_STRING_NAME[] = { \
        FOREACH_MACRO(GENERATE_STRING) \
    };

//enum-string example
/*

//instead of:
// typedef enum {
//     ADD,
//     SUB,
//     MUL,
//     DIV,
//     CMP
// } ALU_Flag;

//do:
#define FOREACH_ALU_FLAG(MACRO) \
    MACRO(ADD) \
    MACRO(SUB) \
    MACRO(MUL) \
    MACRO(DIV) \
    MACRO(CMP) \

DECL_ENUM_AND_STRING(ALU_Flag, FOREACH_ALU_FLAG);
*/

#define FOREACH_LOG_LEVEL(MACRO) \
    MACRO(LOG_PROOF) \
    MACRO(LOG_DEBUG) \
    MACRO(LOG_WARN) \
    MACRO(LOG_MESSAGE) \
    MACRO(LOG_RAW) \
    MACRO(LOG_ERROR) \
    MACRO(LOG_DEATH)

DECL_ENUM_AND_STRING(Log_Level, Log_Level_String, FOREACH_LOG_LEVEL);

#define UTIL_DEFAULT_LOG_LEVEL LOG_DEBUG

#define DECL_VOID_FUNC_STR(name) void name(const char* arg_in)
#define DECL_ARG_CALLBACK(name) DECL_VOID_FUNC_STR(name)
#define DECL_ARG_IN_FAIL_CALLBACK(name) DECL_VOID_FUNC_STR(name)

typedef struct argument_bundle
{
    const char *const short_form;
    const char *const long_form;
    const char *const description;
    const bool exp_val;
    void (*const call_back)(const char *arg_in);
} argument_bundle;

void parse_args(const int argc,
                char const *argv[],
                const int argbc,
                const argument_bundle *argbv,
                void (*const failure_callback) (const char *failure_arg_in));
int get_leading_spaces();
void reset_leading_spaces();
void set_leading_spaces(int n);
float parse_float(const char *str);
long parse_long(const char *str);
const char *get_error_string();
void print_arg_title(const char *title);
void print_arg_bundles(const argument_bundle *argbv, const int n);
void _log(const char *filename, const int line, const Log_Level lvl, const char *fmt, ...);

#define jmin(a, b)                   (a < b ? a : b)

#define CLEAR_TERM()                raw("\033[H\033[J")
#define MV_CURSOR_UP(lines)         raw("\033[%dA", lines)
#define ERASE_LINE()                raw("\r\33[2K")
#define CLR_NRM "\x1B[0m"
#define CLR_RED "\x1B[31m"
#define CLR_GRN "\x1B[32m"
#define CLR_YEL "\x1B[33m"
#define CLR_BLU "\x1B[34m"
#define CLR_MAG "\x1B[35m"
#define CLR_CYN "\x1B[36m"
#define CLR_WHT "\x1B[37m"

#define prf(fmt, ...) _log(__FILE__, __LINE__, LOG_PROOF, fmt, ##__VA_ARGS__)
#define dbg(fmt, ...) _log(__FILE__, __LINE__, LOG_DEBUG, fmt, ##__VA_ARGS__)
#define wrn(fmt, ...) _log(__FILE__, __LINE__, LOG_WARN, fmt, ##__VA_ARGS__)
#define err(fmt, ...) _log(__FILE__, __LINE__, LOG_ERROR, fmt, ##__VA_ARGS__)
#define msg(fmt, ...) _log(__FILE__, __LINE__, LOG_MESSAGE, fmt, ##__VA_ARGS__)
#define raw(fmt, ...) _log(__FILE__, __LINE__, LOG_RAW, fmt, ##__VA_ARGS__)
#define raw_at(lvl, fmt, ...) do{ if (lvl >= get_log_level()) raw(fmt, ##__VA_ARGS__); } while(0)
#define die(fmt, ...) _log(__FILE__, __LINE__, LOG_DEATH, fmt, ##__VA_ARGS__)

Log_Level get_log_level();
void set_log_level(Log_Level lvl);
void nsleep(long ns);
double get_timestamp_us();

#if defined (__cplusplus)
}
#endif

#endif /* include guard */