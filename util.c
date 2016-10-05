#include <stdio.h>
#include <stdarg.h>
#include <time.h>
#include <sys/time.h>

#include "util.h"

log_level_t log_level = DEFAULT_LOG_LEVEL;

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

        char *tag;
        FILE *fd;
        switch (lvl)
        {
        case LOG_DBG:
            fd = stdout;
            fprintf(fd, "[DBG] ");
            break;
        case LOG_WARN:
            fd = stdout;
            fprintf(fd, "[WRN] ");
            break;
        case LOG_MSG:
            fd = stdout;
            fprintf(fd, "[MSG] ");
            break;
        case LOG_RAW:
            fd = stdout;
            tag = "RAW";
            break;
        case LOG_ERROR:
            fd = stderr;
            fprintf(fd, "[ERR] %s:%d\n", filename, line);
            break;
        case LOG_DEATH:
            fd = stderr;
            fprintf(fd, "[DIE] %s:%d\n", filename, line);
            break;
        default:
            fd = stdout;
            fprintf(fd, "[Unknown Log Type] ");
        }

        vfprintf(fd, fmt, args);

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