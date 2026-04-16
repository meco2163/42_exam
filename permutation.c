#include <stdlib.h>
#include <unistd.h>

int	has_duplicate(char *str)
{
	int	i = 0, j = 0;

	while (str[i])
	{
		j = i + 1;
		while (str[j])
		{
			if (str[i] == str[j])
				return 1;
			j++;
		}
		i++;
	}
	return 0;
}

int	ft_strlen(char *str)
{
	int	i = 0;

	while (str[i])
		i++;
	return (i);
}

int	ft_isalpha(char *str)
{
	int	i = 0;

	while (str[i])
	{
		if (!((str[i] >= 'a' && str[i] <= 'z') || (str[i] >= 'A' && str[i] <= 'Z')))
			return (0);
		i++;
	}
	return (1);
}

void	swap(char *a, char *b)
{
	char tmp;

	tmp = *a;
	*a = *b;
	*b = tmp;
}

void	permute(char *str, int l, int r)
{
	int i;

	if (l == r)
	{
		write(1, str, r + 1);
		write(1, "\n", 1);
		return;
	}
	i = l;
	while (i <= r)
	{
		swap(&str[l], &str[i]);
		permute(str, l + 1, r);
		swap(&str[l], &str[i]);
		i++;
	}
}

int main(int ac, char **av)
{
	int	len;

	if (ac != 2)
		return 1;
	if (has_duplicate(av[1]))
		return 1;
	if (!ft_isalpha(av[1]))
		return 1;
	
	len = ft_strlen(av[1]) - 1;
	permute(av[1], 0, len);
	return 0;

}
