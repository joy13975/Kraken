#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <string.h>
#include <errno.h>

#include "util.h"

Log_Level log_level       = DEFAULT_LOG_LEVEL;
int print_leading_spaces    = 0;

//argument parsing
bool args_initilaised       = false;
int arg_count, arg_idx;
char **arg_val;

int get_leading_spaces()
{
    return print_leading_spaces;
}

void set_leading_spaces(int n)
{
    print_leading_spaces = n;
}

float parse_float(const char *str)
{
    char *next;
    float val = strtof(str, &next);
    if (strlen(next))
        die("Failed to parse float from \"%s\"\n", str);
    return val;
}

long parse_long(const char *str)
{
    char *next;
    long val = strtol(str, &next, 10);
    if (strlen(next))
        die("Failed to parse long integer from \"%s\"\n", str);

    return val;
}

const char *get_error_string()
{
    return strerror(errno);
}

void print_help_arguement(const argument_format af)
{
    set_leading_spaces(get_leading_spaces() + 4);
    raw("%s, %s\n", af.short_form, af.long_form);
    set_leading_spaces(get_leading_spaces() + 4);
    raw("%s\n", af.description);
    set_leading_spaces(get_leading_spaces() - 8);
}

char *next_arg()
{
    if (arg_idx > arg_count - 1)
        die("Argument index overflow - you need to check have_next_arg()\n");
    return arg_val[arg_idx++];
}

bool have_next_arg()
{
    if (!args_initilaised)
        die("Must call init_args() first\n");
    return arg_idx <= arg_count - 1;
}

bool next_arg_matches(const argument_format af)
{
    if (arg_idx > arg_count - 1)
        die("Argument index overflow - you need to check have_next_arg()\n");

    const char *arg = arg_val[arg_idx];
    bool match = !strcmp(arg, af.short_form) || !strcmp(arg, af.long_form);

    if (!match)
        return false;

    if ((arg_idx + af.num_parts) > arg_count - 1)
    {
        err("Missing argument value for \"%s\" (\"%s\")\n",
            af.short_form, af.long_form);
        return false;
    }

    arg_idx++;

    return true;
}

void init_args(int argc, char *argv[])
{
    arg_count           = argc;
    arg_val             = argv;
    arg_idx             = 1;
    args_initilaised    = true;
}

void set_log_level(Log_Level lvl)
{
    if (lvl < 0 || lvl >= LOG_ERROR)
    {
        err("Invalid log level: %d\n", lvl);
        err("Must be between 0 and %d\n", LOG_ERROR);
        raw("   LOG_PRF    : %d\n", LOG_PRF);
        raw("   LOG_DBG    : %d\n", LOG_DBG);
        raw("   LOG_WARN   : %d\n", LOG_WARN);
        raw("   LOG_MSG    : %d\n", LOG_MSG);
        raw("   LOG_RAW    : %d\n", LOG_RAW)
        // raw("   LOG_ERROR  : %d\n", LOG_ERROR);
        // raw("   LOG_DEATH  : %d\n", LOG_DEATH);
        exit(1);
    }
    log_level = lvl;
    msg("Debug level set to: %d\n", log_level);
}

void _log(const char *filename, const int line, const Log_Level lvl, const char *fmt, ...)
{
    if (lvl >= log_level) {
        va_list args;
        va_start(args, fmt);

        char space_buffer[print_leading_spaces + 2];
        memset(space_buffer, ' ', print_leading_spaces + 1);
        space_buffer[print_leading_spaces + 1] = '\0';

        char *new_fmt;
        FILE *fd;
        switch (lvl)
        {
        case LOG_PRF:
            fd = stdout;
            asprintf(&new_fmt, "%s[PRF]%s%s%s",
                     CLR_CYN, CLR_NRM, space_buffer, fmt);
            break;
        case LOG_DBG:
            fd = stdout;
            asprintf(&new_fmt, "%s[DBG]%s%s%s",
                     CLR_BLU, CLR_NRM, space_buffer, fmt);
            break;
        case LOG_WARN:
            fd = stdout;
            asprintf(&new_fmt, "%s[WRN]%s%s%s",
                     CLR_YEL, CLR_NRM, space_buffer, fmt);
            break;
        case LOG_MSG:
            fd = stdout;
            asprintf(&new_fmt, "%s[MSG]%s%s%s",
                     CLR_MAG, CLR_NRM, space_buffer, fmt);
            break;
        case LOG_RAW:
            fd = stdout;
            asprintf(&new_fmt, "%s%s", space_buffer, fmt);
            break;
        case LOG_ERROR:
            fd = stderr;
            asprintf(&new_fmt, "%s[ERR]%s%s%s",
                     CLR_RED, CLR_NRM, space_buffer, fmt);
            break;
        case LOG_DEATH:
            fd = stderr;
            asprintf(&new_fmt, "%s[DIE %s:%d]%s%s%s\n",
                     CLR_RED, filename,  line, CLR_NRM, space_buffer, fmt);
            break;
        default:
            fd = stdout;
            asprintf(&new_fmt, "%s[???]%s%s%s",
                     CLR_RED, CLR_NRM, space_buffer, fmt);
        }

        vfprintf(fd, new_fmt, args);
        fflush(fd);

        va_end(args);

        if (lvl == LOG_DEATH)
        {
            if (errno != 0)
                fprintf(fd, "\nError before death: code %d (%s)\n", errno, get_error_string());
            exit(1);
        }
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