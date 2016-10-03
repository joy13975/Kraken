#ifndef _logger_h
#define _logger_h

#include <stdio.h>

#define log(fmt, ...) \
    do{ \
        fprintf(stdout, "[Log] "); \
        fprintf(stdout, fmt, ##__VA_ARGS__); \
    } \
    while(0);

typedef enum {DBG_ALL, DBG_WARN} debug_level_t;

#define dbg(dbglvl, fmt, ...) \
    if(debug_level <= dbglvl) { \
        do { \
            fprintf(stdout, "[Dbg] "); \
            fprintf(stdout, fmt, ##__VA_ARGS__); \
        } \
        while(0); \
    }

#define err(fmt, ...) \
    do{ \
        fprintf(stderr, "[Err] %s:%d\n", __FILE__, __LINE__); \
        fprintf(stderr, fmt, ##__VA_ARGS__); \
    } \
    while(0);

#define die(fmt, ...) \
    do { \
        fprintf(stderr, "[Die] %s:%d\n", __FILE__, __LINE__); \
        fprintf(stderr, fmt, ##__VA_ARGS__); \
        exit(1); \
    } \
    while(0);

#endif /* include guard */