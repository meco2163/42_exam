#include <stdio.h>

char    valid_string[100000][256];
int     valid_counter = 0;

int ft_strcmp(char *s1, char *s2)
{
    int i = 0;
    while (s1 && s2 && s1[i] == s2[i])
        i++;
    return (s1[i] - s2[i]);
}
char    *ft_strcpy(char *dst, char *src)
{
    int i = 0;
    while (src[i])
    {
        dst[i] = src[i];
        i++;
    }
    return (dst);
}
int is_valid(char *s)
{
    int i = 0;
    while (i < valid_counter)
    {
        if (ft_strcmp(valid_string[i], s) == 0)
            return (1);
        i++;
    }
    return (0);
}
void    set_valid(char *s)
{
    if (valid_counter >= 100000)
        return;
    ft_strcpy(valid_string[valid_counter] , s);
    valid_counter++;
}
int paranthesis(char *s)
{
    int opened = 0;
    int closed = 0;
    int i = 0;

    while (s[i])
    {
        if (s[i] == '(')
            opened++;
        else if (s[i] == ')')
        {
            if (opened)
                opened--;
            else
                closed++;
        }
        i++;
    }
    return (opened + closed);
}
void    rip(char *s, int must_fix, int n_fix , int pos)
{
    if (n_fix > must_fix)
        return;
    if (paranthesis(s) > must_fix - n_fix)
        return;
    if (n_fix == must_fix && !paranthesis(s))
    {
        puts(s);
        return;
    }
    if (is_valid(s))
        return;
    set_valid(s);
    int i = pos;
    while (s[i])
    {
        if (s[i] == '(' || s[i] == ')')
        {
            char temp = s[i];
            s[i] = ' ';
            rip(s , must_fix , n_fix + 1 , i + 1);
            s[i] = temp;
        }
        i++;
    }
}
int main (int ac, char **av)
{
    if (ac != 2)
        return (1);
    int must_fix = paranthesis(av[1]);
    rip(av[1] , must_fix , 0 , 0);
}