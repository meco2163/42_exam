#include <unistd.h>
#include <stdlib.h>
#include <string.h>

size_t	ft_strlen(char *str)
{
	size_t	i;

	i = 0;
	while (str[i] != '\0')
		i++;
	return (i);
}

int	ft_strncmp(char *dst, char *src, size_t len)
{
	size_t	i;

	i = 0;
	while (i < len)
	{
		if (dst[i] != src[i])
			return (0);
		i++;
	}
	return (1);
}

char	*filter(char *input, char *arg)
{
	char	*result;
	size_t	i;
	size_t	count;
	size_t	len_arg;
	size_t	len_inp;

	i = 0;
	len_arg = ft_strlen(arg);
	len_inp = ft_strlen(input);
	result = malloc(len_inp + 1);
	if (!result)
		return (NULL);
	memmove(result, input, len_inp);
	while (input[i] != '\0')
	{
		if (input[i] == arg[0] && ft_strncmp(&input[i], arg, len_arg))
		{
			count = 0;
			while (count < len_arg)
			{
				result[i] = '*';
				i++;
				count++;
			}
		}
		else
			i++;
	}
	result[len_inp] = '\0';
	return (result);
}
#include <stdio.h>
int	main(int ac, char **av)
{
	char	std_input[1024];
	char	*result;
	int		ret;

	if (ac != 2 || av[1][0] == '\0')
		return (1);
	while ((ret = read(0, std_input, 1023)) > 0)
	{
        printf("%d", ret);
		std_input[ret] = '\0';
		result = filter(std_input, av[1]);
		if (!result)
			return (1);
		write(1, result, ft_strlen(result));
		free(result);
	}
	return (0);
}