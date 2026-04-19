<p align="center"><a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a></p>

# 🇬🇧 English

# permutations — Solution Architecture

### General Approach

1. **Sort** the input string (guarantees alphabetical output)
2. Recursively pick an unused character for each position
3. Print when all positions are filled

---

### Flow Diagram

```
main("abc")
  │
  ├── sort(av[1])      → "abc" (already sorted)
  ├── len = 3
  │
  └── permute(str="abc", tmp, depth=0, len=3)
       │
       ├── i=0: str[0]='a' ≠ 0
       │    ├── tmp[0]='a', str="·bc"
       │    ├── permute(str="·bc", tmp="a__", depth=1, len=3)
       │    │    ├── i=0: str[0]=0 → skip
       │    │    ├── i=1: str[1]='b' ≠ 0
       │    │    │    ├── tmp[1]='b', str="··c"
       │    │    │    ├── permute(depth=2)
       │    │    │    │    ├── i=2: tmp[2]='c'
       │    │    │    │    ├── depth==len → print "abc"
       │    │    │    │    └── str[2]='c' restore
       │    │    │    └── str[1]='b' restore
       │    │    ├── i=2: str[2]='c' ≠ 0
       │    │    │    └── ... → print "acb"
       │    │    └── done
       │    └── str[0]='a' restore
       │
       ├── i=1: str[1]='b' → ... → "bac", "bca"
       └── i=2: str[2]='c' → ... → "cab", "cba"
```

---

### Function Details

#### `sort(char *str)` — Selection Sort

```c
void sort(char *str)
{
    int i = 0, j;
    while (str[i])
    {
        j = i + 1;
        while (str[j])
        {
            if (str[j] < str[i])
                swap(&str[i], &str[j]);  // bring smallest to front
            j++;
        }
        i++;
    }
}
```

$O(n^2)$ but not a problem since input will be short.

#### `swap(char *a, char *b)`

Swaps two character values:

```c
tmp = *a;
*a = *b;
*b = tmp;
```

#### `permute(char *str, char *tmp, int depth, int len)`

The main recursive function:

```c
void permute(char *str, char *tmp, int depth, int len)
{
    if (depth == len)          // base case: all positions filled
    {
        print(tmp, len);       // print
        return;
    }

    for (int i = 0; i < len; i++)
    {
        if (str[i])            // if character is unused (not 0)
        {
            char c = str[i];   // save
            tmp[depth] = str[i]; // write to temporary array
            str[i] = 0;        // mark as "used"
            permute(str, tmp, depth + 1, len);  // recursive
            str[i] = c;        // restore (backtrack)
        }
    }
}
```

**Why does this approach guarantee alphabetical order?**
- Input is sorted: `"abc"`
- We start from `i=0` → the smallest unused character is always picked first
- This way, the output is naturally in lexicographic order

#### `print(char *s, int len)`

Prints character by character with `write` and appends `\n`. Uses `write` instead of `puts`.

---

### Memory Usage

```c
char tmp[100];  // on the stack — no malloc, no free
```

- `tmp` is kept on the stack as a temporary array
- `str` (input) is modified directly (by setting to 0) and restored
- No `malloc` is used → no memory leak risk

---

### Complexity

- **Time**: $O(n \times n!)$ — $n!$ permutations, each takes $O(n)$ to print
- **Space**: $O(n)$ — `tmp` array + recursion stack depth

---

### Example Trace — input "ba"

```
1. sort("ba") → "ab"
2. permute("ab", tmp, 0, 2)
   ├── i=0: c='a', str="·b", tmp="a_"
   │   permute("·b", tmp="a_", 1, 2)
   │   ├── i=0: str[0]=0 → skip
   │   └── i=1: c='b', tmp="ab" → depth==len → PRINT: "ab"
   │       str[1]='b' restore
   │   str[0]='a' restore
   │
   └── i=1: c='b', str="a·", tmp="b_"
       permute("a·", tmp="b_", 1, 2)
       ├── i=0: c='a', tmp="ba" → depth==len → PRINT: "ba"
       └── i=1: str[1]=0 → skip
```

**Output**: `ab`, `ba` (alphabetical order ✓)

---

[⬆ Back to permutations](../) · [⬆ Level 2](../../)

---

# 🇹🇷 Türkçe

# permutations — Çözüm Mimarisi

### Genel Yaklaşım

1. Input string'i **sırala** (alfabetik sırada çıktı garantisi)
2. Recursive olarak her pozisyon için kullanılmamış bir karakter seç
3. Tüm pozisyonlar dolduğunda yazdır

---

### Akış Diyagramı

```
main("abc")
  │
  ├── sort(av[1])      → "abc" (zaten sıralı)
  ├── len = 3
  │
  └── permute(str="abc", tmp, depth=0, len=3)
       │
       ├── i=0: str[0]='a' ≠ 0
       │    ├── tmp[0]='a', str="·bc"
       │    ├── permute(str="·bc", tmp="a__", depth=1, len=3)
       │    │    ├── i=0: str[0]=0 → atla
       │    │    ├── i=1: str[1]='b' ≠ 0
       │    │    │    ├── tmp[1]='b', str="··c"
       │    │    │    ├── permute(depth=2)
       │    │    │    │    ├── i=2: tmp[2]='c'
       │    │    │    │    ├── depth==len → print "abc"
       │    │    │    │    └── str[2]='c' geri koy
       │    │    │    └── str[1]='b' geri koy
       │    │    ├── i=2: str[2]='c' ≠ 0
       │    │    │    └── ... → print "acb"
       │    │    └── bitti
       │    └── str[0]='a' geri koy
       │
       ├── i=1: str[1]='b' → ... → "bac", "bca"
       └── i=2: str[2]='c' → ... → "cab", "cba"
```

---

### Fonksiyon Detayları

#### `sort(char *str)` — Selection Sort

```c
void sort(char *str)
{
    int i = 0, j;
    while (str[i])
    {
        j = i + 1;
        while (str[j])
        {
            if (str[j] < str[i])
                swap(&str[i], &str[j]);  // en küçüğü başa al
            j++;
        }
        i++;
    }
}
```

$O(n^2)$ ama input kısa olacağı için sorun değil.

#### `swap(char *a, char *b)`

İki karakter değeri yer değiştirir:

```c
tmp = *a;
*a = *b;
*b = tmp;
```

#### `permute(char *str, char *tmp, int depth, int len)`

Asıl recursive fonksiyon:

```c
void permute(char *str, char *tmp, int depth, int len)
{
    if (depth == len)          // base case: tüm pozisyonlar dolu
    {
        print(tmp, len);       // yazdır
        return;
    }

    for (int i = 0; i < len; i++)
    {
        if (str[i])            // karakter kullanılmamışsa (0 değilse)
        {
            char c = str[i];   // sakla
            tmp[depth] = str[i]; // geçici diziye yaz
            str[i] = 0;        // "kullanıldı" işaretle
            permute(str, tmp, depth + 1, len);  // recursive
            str[i] = c;        // geri koy (backtrack)
        }
    }
}
```

**Neden bu yaklaşım alfabetik sıra garantisi verir?**
- Input sıralı: `"abc"`
- `i=0`'dan başlıyoruz → her zaman en küçük kullanılmamış karakter önce seçilir
- Bu sayede çıktı doğal olarak leksikografik sıradadır

#### `print(char *s, int len)`

`write` ile karakter karakter yazdırır + `\n` ekler. `puts` yerine `write` kullanılmış.

---

### Bellek Kullanımı

```c
char tmp[100];  // stack üzerinde — malloc yok, free yok
```

- `tmp` geçici dizi olarak stack'te tutulur
- `str` (input) doğrudan modifiye edilir (0 koyarak) ve geri alınır
- Hiç `malloc` kullanılmaz → bellek sızıntısı riski yok

---

### Karmaşıklık

- **Zaman**: $O(n \times n!)$ — $n!$ permütasyon, her biri $O(n)$ yazdırma
- **Alan**: $O(n)$ — `tmp` dizisi + recursion stack derinliği

---

### Örnek İz (trace) — "ba" inputu

```
1. sort("ba") → "ab"
2. permute("ab", tmp, 0, 2)
   ├── i=0: c='a', str="·b", tmp="a_"
   │   permute("·b", tmp="a_", 1, 2)
   │   ├── i=0: str[0]=0 → atla
   │   └── i=1: c='b', tmp="ab" → depth==len → YAZDIR: "ab"
   │       str[1]='b' geri koy
   │   str[0]='a' geri koy
   │
   └── i=1: c='b', str="a·", tmp="b_"
       permute("a·", tmp="b_", 1, 2)
       ├── i=0: c='a', tmp="ba" → depth==len → YAZDIR: "ba"
       └── i=1: str[1]=0 → atla
```

**Çıktı**: `ab`, `ba` (alfabetik sırada ✓)

---

[⬆ permutations ana dizinine dön](../) · [⬆ Level 2](../../)

---

# 🇫🇷 Français

# permutations — Architecture de la solution

### Approche générale

1. **Trier** la chaîne d'entrée (garantit une sortie alphabétique)
2. Choisir récursivement un caractère non utilisé pour chaque position
3. Afficher quand toutes les positions sont remplies

---

### Diagramme de flux

```
main("abc")
  │
  ├── sort(av[1])      → "abc" (déjà trié)
  ├── len = 3
  │
  └── permute(str="abc", tmp, depth=0, len=3)
       │
       ├── i=0: str[0]='a' ≠ 0
       │    ├── tmp[0]='a', str="·bc"
       │    ├── permute(str="·bc", tmp="a__", depth=1, len=3)
       │    │    ├── i=0: str[0]=0 → passer
       │    │    ├── i=1: str[1]='b' ≠ 0
       │    │    │    ├── tmp[1]='b', str="··c"
       │    │    │    ├── permute(depth=2)
       │    │    │    │    ├── i=2: tmp[2]='c'
       │    │    │    │    ├── depth==len → print "abc"
       │    │    │    │    └── str[2]='c' restaurer
       │    │    │    └── str[1]='b' restaurer
       │    │    ├── i=2: str[2]='c' ≠ 0
       │    │    │    └── ... → print "acb"
       │    │    └── terminé
       │    └── str[0]='a' restaurer
       │
       ├── i=1: str[1]='b' → ... → "bac", "bca"
       └── i=2: str[2]='c' → ... → "cab", "cba"
```

---

### Détails des fonctions

#### `sort(char *str)` — Tri par sélection

```c
void sort(char *str)
{
    int i = 0, j;
    while (str[i])
    {
        j = i + 1;
        while (str[j])
        {
            if (str[j] < str[i])
                swap(&str[i], &str[j]);  // amener le plus petit en tête
            j++;
        }
        i++;
    }
}
```

$O(n^2)$ mais pas un problème car l'entrée sera courte.

#### `swap(char *a, char *b)`

Échange deux valeurs de caractères :

```c
tmp = *a;
*a = *b;
*b = tmp;
```

#### `permute(char *str, char *tmp, int depth, int len)`

La fonction récursive principale :

```c
void permute(char *str, char *tmp, int depth, int len)
{
    if (depth == len)          // cas de base : toutes les positions remplies
    {
        print(tmp, len);       // afficher
        return;
    }

    for (int i = 0; i < len; i++)
    {
        if (str[i])            // si le caractère n'est pas utilisé (pas 0)
        {
            char c = str[i];   // sauvegarder
            tmp[depth] = str[i]; // écrire dans le tableau temporaire
            str[i] = 0;        // marquer comme "utilisé"
            permute(str, tmp, depth + 1, len);  // récursif
            str[i] = c;        // restaurer (backtrack)
        }
    }
}
```

**Pourquoi cette approche garantit-elle l'ordre alphabétique ?**
- L'entrée est triée : `"abc"`
- On commence à `i=0` → le plus petit caractère non utilisé est toujours choisi en premier
- Ainsi, la sortie est naturellement en ordre lexicographique

#### `print(char *s, int len)`

Affiche caractère par caractère avec `write` et ajoute `\n`. Utilise `write` au lieu de `puts`.

---

### Utilisation mémoire

```c
char tmp[100];  // sur la pile — pas de malloc, pas de free
```

- `tmp` est conservé sur la pile comme tableau temporaire
- `str` (entrée) est modifié directement (en mettant à 0) puis restauré
- Aucun `malloc` utilisé → aucun risque de fuite mémoire

---

### Complexité

- **Temps** : $O(n \times n!)$ — $n!$ permutations, chacune prend $O(n)$ pour l'affichage
- **Espace** : $O(n)$ — tableau `tmp` + profondeur de la pile de récursion

---

### Exemple de trace — entrée "ba"

```
1. sort("ba") → "ab"
2. permute("ab", tmp, 0, 2)
   ├── i=0: c='a', str="·b", tmp="a_"
   │   permute("·b", tmp="a_", 1, 2)
   │   ├── i=0: str[0]=0 → passer
   │   └── i=1: c='b', tmp="ab" → depth==len → AFFICHER: "ab"
   │       str[1]='b' restaurer
   │   str[0]='a' restaurer
   │
   └── i=1: c='b', str="a·", tmp="b_"
       permute("a·", tmp="b_", 1, 2)
       ├── i=0: c='a', tmp="ba" → depth==len → AFFICHER: "ba"
       └── i=1: str[1]=0 → passer
```

**Sortie** : `ab`, `ba` (ordre alphabétique ✓)

---

[⬆ Retour à permutations](../) · [⬆ Level 2](../../)
