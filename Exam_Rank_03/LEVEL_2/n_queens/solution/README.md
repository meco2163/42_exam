> 📁 **Files:** [n_queens.c](n_queens.c)

<p align="center"><a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a></p>

# 🇬🇧 English

## Solution Architecture

### General Approach

Use **Backtracking** to advance column by column. Find a safe row for each column; if none found, backtrack.

---

### Data Structure

```c
int *board;      // board[col] = row → row of the queen in column col
int board_size;  // board size (n)
```

A one-dimensional `board` array is used because there can only be 1 queen per column.

---

### Flow Diagram

```
main(ac, av)
  │
  ├── ac != 2? → return 1
  ├── n = atoi(av[1])
  ├── n <= 3? → return 0 (no solution)
  ├── board = malloc(n * sizeof(int))
  │
  └── solve(col=0)
       │
       ├── col == board_size? → print_solution() + return
       │
       └── for row = 0 to board_size-1
            │
            ├── is_safe(row, col)?
            │    │
            │    ├── YES → board[col] = row
            │    │         solve(col + 1)  ← recursive call
            │    │
            │    └── NO  → try next row
            │
            └── all rows tried → go back (backtrack)
```

---

### Function Details

#### `is_safe(row, col)`

Can we place a new queen at position `(row, col)`?

```c
for (int i = 0; i < col; i++)
{
    // Same row check
    if (board[i] == row)
        return 0;

    // Diagonal check: |row_diff| == |col_diff|
    if (ft_abs(board[i] - row) == ft_abs(i - col))
        return 0;
}
return 1;
```

**Why only check `i < col`?**
Because we haven't placed any queens in columns after `col` yet.

##### How Does Diagonal Check Work?

If two positions are on the same diagonal, the row difference equals the column difference:

```
(1,0) and (3,2): |1-3| = 2, |0-2| = 2 → SAME DIAGONAL ✗
(1,0) and (2,2): |1-2| = 1, |0-2| = 2 → DIFFERENT     ✓
```

#### `solve(col)`

Recursive backtracking function:

```
solve(0):
  row=0: safe? → board[0]=0, solve(1)
    solve(1):
      row=0: conflicts with board[0]=0 → NO
      row=1: diagonal conflict → NO
      row=2: safe? → board[1]=2, solve(2)
        solve(2):
          ... continues
      row=3: safe? → board[1]=3, solve(2) → ...
  row=1: board[0]=1, solve(1) → ...
  ...
```

#### `print_solution()`

```c
// board = {1, 3, 0, 2}
// Output: "1 3 0 2\n"
//          ↑ no space after the last number
```

#### `ft_abs(n)`

Absolute value function — written manually since `abs()` from `stdlib.h` is not allowed.

---

### Complexity

- **Time**: $O(n!)$ — at most n choices per column, but `is_safe` prunes
- **Space**: $O(n)$ — only the `board` array

---

### Example Execution (n=4)

```
solve(0): row=1 → board={1,_,_,_}
  solve(1): row=3 → board={1,3,_,_}
    solve(2): row=0 → board={1,3,0,_}
      solve(3): row=2 → board={1,3,0,2}
        solve(4): → SOLUTION! → "1 3 0 2"

... backtrack ...

solve(0): row=2 → board={2,_,_,_}
  solve(1): row=0 → board={2,0,_,_}
    solve(2): row=3 → board={2,0,3,_}
      solve(3): row=1 → board={2,0,3,1}
        solve(4): → SOLUTION! → "2 0 3 1"
```

---

[⬆ Back to n_queens](../) · [⬆ Level 2](../../)

---

# 🇹🇷 Türkçe

## Çözüm Mimarisi

### Genel Yaklaşım

**Backtracking** ile sütun sütun ilerle. Her sütuna güvenli bir satır bul, bulamazsan geri dön.

---

### Veri Yapısı

```c
int *board;      // board[col] = row → sütun col'daki vezirin satırı
int board_size;  // tahta boyutu (n)
```

`board` tek boyutlu dizi kullanılır çünkü her sütunda sadece 1 vezir olabilir.

---

### Akış Diyagramı

```
main(ac, av)
  │
  ├── ac != 2? → return 1
  ├── n = atoi(av[1])
  ├── n <= 3? → return 0 (çözüm yok)
  ├── board = malloc(n * sizeof(int))
  │
  └── solve(col=0)
       │
       ├── col == board_size? → print_solution() + return
       │
       └── for row = 0 to board_size-1
            │
            ├── is_safe(row, col)?
            │    │
            │    ├── EVET → board[col] = row
            │    │          solve(col + 1)  ← recursive çağrı
            │    │
            │    └── HAYIR → sonraki row'u dene
            │
            └── tüm row'lar denendi → geri dön (backtrack)
```

---

### Fonksiyon Detayları

#### `is_safe(row, col)`

Yeni bir veziri `(row, col)` pozisyonuna koyabilir miyiz?

```c
for (int i = 0; i < col; i++)
{
    // Aynı satır kontrolü
    if (board[i] == row)
        return 0;

    // Çapraz kontrol: |satır_farkı| == |sütun_farkı|
    if (ft_abs(board[i] - row) == ft_abs(i - col))
        return 0;
}
return 1;
```

**Neden sadece `i < col` kontrol ediliyor?**
Çünkü henüz `col`'dan sonraki sütunlara vezir yerleştirmedik.

##### Çapraz Kontrol Nasıl Çalışır?

İki pozisyon aynı çaprazdaysa, satır farkı ile sütun farkı eşittir:

```
(1,0) ve (3,2): |1-3| = 2, |0-2| = 2 → AYNI ÇAPRAZ ✗
(1,0) ve (2,2): |1-2| = 1, |0-2| = 2 → FARKLI       ✓
```

#### `solve(col)`

Recursive backtracking fonksiyonu:

```
solve(0):
  row=0: safe? → board[0]=0, solve(1)
    solve(1):
      row=0: board[0]=0 ile çakışıyor → HAYIR
      row=1: çapraz çakışma → HAYIR
      row=2: safe? → board[1]=2, solve(2)
        solve(2):
          ... devam eder
      row=3: safe? → board[1]=3, solve(2) → ...
  row=1: board[0]=1, solve(1) → ...
  ...
```

#### `print_solution()`

```c
// board = {1, 3, 0, 2}
// Çıktı: "1 3 0 2\n"
//         ↑ son sayıdan sonra boşluk YOK
```

#### `ft_abs(n)`

Mutlak değer fonksiyonu — `stdlib.h`'deki `abs()` izin verilmediğinden manual yazılmış.

---

### Karmaşıklık

- **Zaman**: $O(n!)$ — her sütunda en fazla n seçenek, ama `is_safe` budama yapar
- **Alan**: $O(n)$ — sadece `board` dizisi

---

### Örnek Çalıştırma (n=4)

```
solve(0): row=1 → board={1,_,_,_}
  solve(1): row=3 → board={1,3,_,_}
    solve(2): row=0 → board={1,3,0,_}
      solve(3): row=2 → board={1,3,0,2}
        solve(4): → ÇÖZÜM! → "1 3 0 2"

... backtrack ...

solve(0): row=2 → board={2,_,_,_}
  solve(1): row=0 → board={2,0,_,_}
    solve(2): row=3 → board={2,0,3,_}
      solve(3): row=1 → board={2,0,3,1}
        solve(4): → ÇÖZÜM! → "2 0 3 1"
```

---

[⬆ n_queens ana dizinine dön](../) · [⬆ Level 2](../../)

---

# 🇫🇷 Français

## Architecture de la solution

### Approche générale

Utiliser le **Backtracking** pour avancer colonne par colonne. Trouver une ligne sûre pour chaque colonne ; si aucune n'est trouvée, revenir en arrière.

---

### Structure de données

```c
int *board;      // board[col] = row → ligne de la reine dans la colonne col
int board_size;  // taille de l'échiquier (n)
```

Un tableau `board` unidimensionnel est utilisé car il ne peut y avoir qu'une seule reine par colonne.

---

### Diagramme de flux

```
main(ac, av)
  │
  ├── ac != 2? → return 1
  ├── n = atoi(av[1])
  ├── n <= 3? → return 0 (pas de solution)
  ├── board = malloc(n * sizeof(int))
  │
  └── solve(col=0)
       │
       ├── col == board_size? → print_solution() + return
       │
       └── for row = 0 to board_size-1
            │
            ├── is_safe(row, col)?
            │    │
            │    ├── OUI → board[col] = row
            │    │         solve(col + 1)  ← appel récursif
            │    │
            │    └── NON → essayer la ligne suivante
            │
            └── toutes les lignes essayées → revenir (backtrack)
```

---

### Détails des fonctions

#### `is_safe(row, col)`

Peut-on placer une nouvelle reine à la position `(row, col)` ?

```c
for (int i = 0; i < col; i++)
{
    // Vérification même ligne
    if (board[i] == row)
        return 0;

    // Vérification diagonale : |diff_ligne| == |diff_colonne|
    if (ft_abs(board[i] - row) == ft_abs(i - col))
        return 0;
}
return 1;
```

**Pourquoi vérifier seulement `i < col` ?**
Parce que nous n'avons pas encore placé de reines dans les colonnes après `col`.

##### Comment fonctionne la vérification diagonale ?

Si deux positions sont sur la même diagonale, la différence de lignes est égale à la différence de colonnes :

```
(1,0) et (3,2): |1-3| = 2, |0-2| = 2 → MÊME DIAGONALE ✗
(1,0) et (2,2): |1-2| = 1, |0-2| = 2 → DIFFÉRENT      ✓
```

#### `solve(col)`

Fonction récursive de backtracking :

```
solve(0):
  row=0: sûr ? → board[0]=0, solve(1)
    solve(1):
      row=0: conflit avec board[0]=0 → NON
      row=1: conflit diagonal → NON
      row=2: sûr ? → board[1]=2, solve(2)
        solve(2):
          ... continue
      row=3: sûr ? → board[1]=3, solve(2) → ...
  row=1: board[0]=1, solve(1) → ...
  ...
```

#### `print_solution()`

```c
// board = {1, 3, 0, 2}
// Sortie : "1 3 0 2\n"
//           ↑ pas d'espace après le dernier nombre
```

#### `ft_abs(n)`

Fonction valeur absolue — écrite manuellement car `abs()` de `stdlib.h` n'est pas autorisé.

---

### Complexité

- **Temps** : $O(n!)$ — au maximum n choix par colonne, mais `is_safe` élague
- **Espace** : $O(n)$ — uniquement le tableau `board`

---

### Exemple d'exécution (n=4)

```
solve(0): row=1 → board={1,_,_,_}
  solve(1): row=3 → board={1,3,_,_}
    solve(2): row=0 → board={1,3,0,_}
      solve(3): row=2 → board={1,3,0,2}
        solve(4): → SOLUTION ! → "1 3 0 2"

... backtrack ...

solve(0): row=2 → board={2,_,_,_}
  solve(1): row=0 → board={2,0,_,_}
    solve(2): row=3 → board={2,0,3,_}
      solve(3): row=1 → board={2,0,3,1}
        solve(4): → SOLUTION ! → "2 0 3 1"
```

---

[⬆ Retour à n_queens](../) · [⬆ Level 2](../../)
