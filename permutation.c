#include <unistd.h>

int	ft_strlen(char *str)
{
	int	i = 0;

	while (str[i])
		i++;
	return (i);
}

void	swap(char *a, char *b)
{
	char tmp;

	tmp = *a;
	*a = *b;
	*b = tmp;
}

void	sort(char *str)
{
	int	i = 0;
	int j;

	while (str[i])
	{
		j = i + 1;
		while (str[j])
		{
			if (str[j] < str[i])
				swap(&str[i], &str[j]);
			j++;
		}
		i++;
	}
}

void	print(char *s, int len)
{
	int	i = 0;
	while (i < len)
		write(1, &s[i++], 1);
	write(1, "\n", 1);
}

void	permute(char *str, char *tmp, int depth, int len)
{
	int	i;
	char	c;

	if (depth == len)
	{
		print(tmp, len);
		return;
	}

	i = 0;
	while (i < len)
	{
		if (str[i])
		{
			c = str[i];
			tmp[depth] = str[i];
			str[i] = 0;
			permute(str, tmp, depth + 1, len);
			str[i] = c;
		}
		i++;
	}
}

int main(int ac, char **av)
{
	char	tmp[100];
	int		len;

	if (ac != 2)
		return 0;

	sort(av[1]);
	len = ft_strlen(av[1]);
	permute(av[1], tmp, 0, len);
}
