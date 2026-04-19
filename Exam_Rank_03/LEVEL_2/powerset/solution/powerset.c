#include <stdio.h>
#include <stdlib.h>


void powerset(int *array, int *player, int target, int sum, int i, int j, int count)
{
    int index;

    if (sum == target && count == 0)
    {
        index = 0;
        while(j > 0)
        {
            printf("%d", player[index++]);
            if ((j - 1) == 0)
                break;
            printf(" ");
            j--;
        }
        printf("\n");
        return ;
    }
    if (count > 0)
    {
        sum = sum + array[i];
        player[j] = array[i];
        powerset(array, player, target, sum, i + 1, j + 1, count - 1);
        player[j] = 0;
        sum = sum - array[i];
        powerset(array, player, target, sum, i + 1, j, count - 1);
    }
}

int main(int ac, char **av)
{
    int array[1024];
    int player[1024];
    int i = 0;
    int j = 2;
    int target;

    if (ac <= 2)
        return 1;
    target = atoi(av[1]);
    while (av[j])
        array[i++] = atoi(av[j++]);
    powerset(array, player, target, 0, 0, 0, ac - 2);
}