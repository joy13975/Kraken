#include <stdio.h>
#include <stdarg.h>
#include <time.h>
#include <sys/time.h>
#include <string.h>
#include <errno.h>

#include "util.h"

log_level_t log_level = DEFAULT_LOG_LEVEL;

const char *get_error_string()
{
    return strerror(errno);
}

bool check_arg(const char *arg, const char *arg_forms[2])
{
    return !strcmp(arg, arg_forms[0]) || !strcmp(arg, arg_forms[1]);
}

void set_log_level(log_level_t lvl)
{
    log_level = lvl;
    wrn("Debug level set to: %d\n", log_level);
}

void _log(const char *filename, int line, log_level_t lvl, char *fmt, ...)
{
    if (lvl >= log_level) {
        va_list args;
        va_start(args, fmt);

        char *new_fmt;
        FILE *fd;
        switch (lvl)
        {
        case LOG_PRF:
            fd = stdout;
            asprintf(&new_fmt, "[PRF] %s", fmt);
            break;
        case LOG_DBG:
            fd = stdout;
            asprintf(&new_fmt, "[DBG] %s", fmt);
            break;
        case LOG_WARN:
            fd = stdout;
            asprintf(&new_fmt, "[WRN] %s", fmt);
            break;
        case LOG_MSG:
            fd = stdout;
            asprintf(&new_fmt, "[MSG] %s", fmt);
            break;
        case LOG_RAW:
            fd = stdout;
            new_fmt = fmt;
            break;
        case LOG_ERROR:
            fd = stderr;
            asprintf(&new_fmt, "[ERR] %s\n", filename, line, fmt);
            break;
        case LOG_DEATH:
            fd = stderr;
            asprintf(&new_fmt, "[DIE %s:%d] %s\n", filename, line, fmt);
            break;
        default:
            fd = stdout;
            asprintf(&new_fmt, "[Unknown Log Type] %s", fmt);
        }

        vfprintf(fd, new_fmt, args);
        fflush(fd);

        va_end(args);
    }
}

void nsleep(long ns)
{
    struct timespec sleep_time;
    sleep_time.tv_sec = ns / 1000000000;
    sleep_time.tv_nsec = ns % 1000000000;
    nanosleep(&sleep_time, NULL);
}

double get_timestamp_us()
{
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_usec + tv.tv_sec * 1e6;
}