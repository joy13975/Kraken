#ifndef _UTIL_H
#define _UTIL_H

#if defined (__cplusplus)
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

typedef enum {LOG_PRF, LOG_DBG, LOG_WARN, LOG_MSG, LOG_RAW, LOG_ERROR, LOG_DEATH} Log_Level;

#define DEFAULT_LOG_LEVEL LOG_DBG

typedef struct argument_format
{
    const char *short_form;
    const char *long_form;
    const int num_parts;
    const char *description;
} argument_format;

int get_leading_spaces();
void set_leading_spaces(int n);
float parse_float(const char *str);
long parse_long(const char *str);
const char *get_error_string();
void print_help_arguement(const argument_format af);
char *next_arg();
bool have_next_arg();
bool next_arg_matches(const argument_format af);
void init_args(int argc, char *argv[]);
void _log(const char *filename, const int line, const Log_Level lvl, const char *fmt, ...);

//enum-string generation
#define GENERATE_ENUM(ENUM) ENUM,
#define GENERATE_STRING(STRING) #STRING,
#define DECL_ENUM_AND_STRING(TYPE_NAME, FOREACH_MACRO) \
    typedef enum { \
        FOREACH_MACRO(GENERATE_ENUM) \
    } TYPE_NAME; \
    static const char *TYPE_NAME ## _String[] = { \
        FOREACH_MACRO(GENERATE_STRING) \
    }; \


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

#define min(a, b)                   (a < b ? a : b)

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

#define prf(fmt, ...) _log(__FILE__, __LINE__, LOG_PRF, fmt, ##__VA_ARGS__);
#define dbg(fmt, ...) _log(__FILE__, __LINE__, LOG_DBG, fmt, ##__VA_ARGS__);
#define wrn(fmt, ...) _log(__FILE__, __LINE__, LOG_WARN, fmt, ##__VA_ARGS__);
#define err(fmt, ...) _log(__FILE__, __LINE__, LOG_ERROR, fmt, ##__VA_ARGS__);
#define msg(fmt, ...) _log(__FILE__, __LINE__, LOG_MSG, fmt, ##__VA_ARGS__);
#define raw(fmt, ...) _log(__FILE__, __LINE__, LOG_RAW, fmt, ##__VA_ARGS__);
#define die(fmt, ...) _log(__FILE__, __LINE__, LOG_DEATH, fmt, ##__VA_ARGS__);

void set_log_level(Log_Level lvl);
void nsleep(long ns);
double get_timestamp_us();

#if defined (__cplusplus)
}
#endif

#endif /* include guard */