#include "get_next_line.h"

char *get_next_line(int fd)
{
    static char buf[BUFFER_SIZE], *len;
    static int ret, pos;
    int i = 0;

    if (fd < 0 || !(len = malloc(10000)))
        return NULL;

    while (1)
    {
        if (pos >= ret)
        {
            pos = 0;
            if ((ret = read(fd, buf, BUFFER_SIZE)) <= 0)
                break;
        }
        len[i++] = buf[pos++];
        if (len[i - 1] == '\n')
            break;
    }
    return (i ? (len[i] = '\0', len) : (free(len), NULL));
}