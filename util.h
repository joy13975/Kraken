#ifndef _UTIL_H
#define _UTIL_H

#include <stdint.h>
#include <stdbool.h>

typedef enum {LOG_PRF, LOG_DBG, LOG_WARN, LOG_MSG, LOG_RAW, LOG_ERROR, LOG_DEATH} log_level_t;

#define DEFAULT_LOG_LEVEL LOG_DBG

const char *get_error_string();
bool check_arg(const char *arg, const char *arg_forms[2]);
void _log(const char *filename, int line, log_level_t lvl, char *fmt, ...);

#define prf(fmt, ...) _log(__FILE__, __LINE__, LOG_PRF, fmt, ##__VA_ARGS__);
#define dbg(fmt, ...) _log(__FILE__, __LINE__, LOG_DBG, fmt, ##__VA_ARGS__);
#define wrn(fmt, ...) _log(__FILE__, __LINE__, LOG_WARN, fmt, ##__VA_ARGS__);
#define err(fmt, ...) _log(__FILE__, __LINE__, LOG_ERROR, fmt, ##__VA_ARGS__);
#define msg(fmt, ...) _log(__FILE__, __LINE__, LOG_MSG, fmt, ##__VA_ARGS__);
#define raw(fmt, ...) _log(__FILE__, __LINE__, LOG_RAW, fmt, ##__VA_ARGS__);
#define die(fmt, ...) _log(__FILE__, __LINE__, LOG_DEATH, fmt, ##__VA_ARGS__);

void set_log_level(log_level_t lvl);
void nsleep(long ns);
double get_timestamp_us();

#endif /* include guard */