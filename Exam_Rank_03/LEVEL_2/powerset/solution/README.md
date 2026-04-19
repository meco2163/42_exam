> 📁 **Files:** [powerset.c](powerset.c)

# powerset — Solution

<p align="center"><a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a></p>

---

# 🇬🇧 English

### Solution Architecture

### General Approach

**Include/Exclude** technique — try two paths for each element:
1. Add this element to the subset → recursive call
2. Skip this element → recursive call

---

### Flow Diagram

```
main(ac, av)
  │
  ├── ac <= 2? → return 1
  ├── target = atoi(av[1])     → target sum
  ├── array[] = av[2..n]       → set elements
  │
  └── powerset(array, player, target, sum=0, i=0, j=0, count=ac-2)
       │
       ├── sum == target AND count == 0?
       │    └── YES → print player[] (j elements) → return
       │
       ├── count > 0?
       │    │
       │    ├── INCLUDE: sum += array[i], player[j] = array[i]
       │    │   └── powerset(..., sum, i+1, j+1, count-1)
       │    │       └── player[j] = 0, sum -= array[i]  (undo)
       │    │
       │    └── EXCLUDE:
       │        └── powerset(..., sum, i+1, j, count-1)
       │
       └── count == 0? → return (all elements processed)
```

---

### Function Detail: `powerset()`

```c
void powerset(int *array, int *player, int target,
              int sum, int i, int j, int count)
```

| Parameter | Meaning |
|:----------|:--------|
| `array` | Original set elements |
| `player` | Temporary array holding selected elements |
| `target` | Target sum |
| `sum` | Current sum |
| `i` | Current position in `array` |
| `j` | Current position in `player` (number of selected elements) |
| `count` | Remaining element count |

#### Base Case

```c
if (sum == target && count == 0)
{
    // print j elements in player[]
    return;
}
```

`count == 0`: All elements have been decided (include/exclude) + `sum == target`: target reached.

#### Recursive Case

```c
if (count > 0)
{
    // INCLUDE
    sum = sum + array[i];
    player[j] = array[i];
    powerset(array, player, target, sum, i + 1, j + 1, count - 1);

    // UNDO (backtrack)
    player[j] = 0;
    sum = sum - array[i];

    // EXCLUDE
    powerset(array, player, target, sum, i + 1, j, count - 1);
}
```

---

### Example Trace

```
Input: ./powerset 3 1 2 3

array = {1, 2, 3}, target = 3, count = 3

powerset(sum=0, i=0, j=0, count=3)
├── INCLUDE 1: sum=1, player={1}
│   powerset(sum=1, i=1, j=1, count=2)
│   ├── INCLUDE 2: sum=3, player={1,2}
│   │   powerset(sum=3, i=2, j=2, count=1)
│   │   ├── INCLUDE 3: sum=6, player={1,2,3}
│   │   │   count=0, sum≠target → no print
│   │   └── EXCLUDE 3:
│   │       count=0, sum=3=target → PRINT: "1 2"
│   └── EXCLUDE 2: sum=1
│       powerset(sum=1, i=2, j=1, count=1)
│       ├── INCLUDE 3: sum=4
│       │   count=0, sum≠target → no print
│       └── EXCLUDE 3: sum=1
│           count=0, sum≠target → no print
│
└── EXCLUDE 1: sum=0
    powerset(sum=0, i=1, j=0, count=2)
    ├── INCLUDE 2: sum=2
    │   powerset(sum=2, i=2, j=1, count=1)
    │   ├── INCLUDE 3: sum=5
    │   │   count=0, sum≠target → no print
    │   └── EXCLUDE 3: sum=2
    │       count=0, sum≠target → no print
    └── EXCLUDE 2: sum=0
        powerset(sum=0, i=2, j=0, count=1)
        ├── INCLUDE 3: sum=3
        │   count=0, sum=3=target → PRINT: "3"
        └── EXCLUDE 3: sum=0
            count=0, sum≠target → no print

Result: "1 2" and "3"
```

---

### Print Logic

```c
if (sum == target && count == 0)
{
    int index = 0;
    while (j > 0)
    {
        printf("%d", player[index++]);
        if ((j - 1) == 0)
            break;
        printf(" ");   // no space after the last element
        j--;
    }
    printf("\n");
}
```

`j` holds the number of selected elements. The `j - 1 == 0` check prevents a trailing space after the last element.

---

### Complexity

- **Time**: $O(2^n)$ — two choices per element (include/exclude)
- **Space**: $O(n)$ — `player[]` array + recursion stack

---

[⬆ Back to powerset](../) · [⬆ Level 2](../../)

---

# 🇹🇷 Türkçe

### Çözüm Mimarisi

### Genel Yaklaşım

**Include/Exclude (Dahil Et/Hariç Tut)** tekniği ile her eleman için iki yol dene:
1. Bu elemanı alt kümeye ekle → recursive çağrı
2. Bu elemanı atlayıp → recursive çağrı

---

### Akış Diyagramı

```
main(ac, av)
  │
  ├── ac <= 2? → return 1
  ├── target = atoi(av[1])     → hedef toplam
  ├── array[] = av[2..n]       → küme elemanları
  │
  └── powerset(array, player, target, sum=0, i=0, j=0, count=ac-2)
       │
       ├── sum == target VE count == 0?
       │    └── EVET → player[] yazdır (j eleman) → return
       │
       ├── count > 0?
       │    │
       │    ├── DAHIL ET: sum += array[i], player[j] = array[i]
       │    │   └── powerset(..., sum, i+1, j+1, count-1)
       │    │       └── player[j] = 0, sum -= array[i]  (geri al)
       │    │
       │    └── HARİÇ TUT:
       │        └── powerset(..., sum, i+1, j, count-1)
       │
       └── count == 0? → return (tüm elemanlar işlendi)
```

---

### Fonksiyon Detayı: `powerset()`

```c
void powerset(int *array, int *player, int target,
              int sum, int i, int j, int count)
```

| Parametre | Anlamı |
|:----------|:-------|
| `array` | Orijinal küme elemanları |
| `player` | Seçilen elemanları tutan geçici dizi |
| `target` | Hedef toplam |
| `sum` | Şu anki toplam |
| `i` | `array`'deki mevcut pozisyon |
| `j` | `player`'daki mevcut pozisyon (kaç eleman seçildi) |
| `count` | Kalan eleman sayısı |

#### Base Case

```c
if (sum == target && count == 0)
{
    // player[]'daki j elemanı yazdır
    return;
}
```

`count == 0`: Tüm elemanlar dahil/hariç kararı verildi + `sum == target`: hedefe ulaşıldı.

#### Recursive Case

```c
if (count > 0)
{
    // DAHİL ET
    sum = sum + array[i];
    player[j] = array[i];
    powerset(array, player, target, sum, i + 1, j + 1, count - 1);

    // GERİ AL (backtrack)
    player[j] = 0;
    sum = sum - array[i];

    // HARİÇ TUT
    powerset(array, player, target, sum, i + 1, j, count - 1);
}
```

---

### Örnek İz (trace)

```
Input: ./powerset 3 1 2 3

array = {1, 2, 3}, target = 3, count = 3

powerset(sum=0, i=0, j=0, count=3)
├── DAHİL 1: sum=1, player={1}
│   powerset(sum=1, i=1, j=1, count=2)
│   ├── DAHİL 2: sum=3, player={1,2}
│   │   powerset(sum=3, i=2, j=2, count=1)
│   │   ├── DAHİL 3: sum=6, player={1,2,3}
│   │   │   count=0, sum≠target → yazdırma
│   │   └── HARİÇ 3:
│   │       count=0, sum=3=target → YAZDIR: "1 2"
│   └── HARİÇ 2: sum=1
│       powerset(sum=1, i=2, j=1, count=1)
│       ├── DAHİL 3: sum=4
│       │   count=0, sum≠target → yazdırma
│       └── HARİÇ 3: sum=1
│           count=0, sum≠target → yazdırma
│
└── HARİÇ 1: sum=0
    powerset(sum=0, i=1, j=0, count=2)
    ├── DAHİL 2: sum=2
    │   powerset(sum=2, i=2, j=1, count=1)
    │   ├── DAHİL 3: sum=5
    │   │   count=0, sum≠target → yazdırma
    │   └── HARİÇ 3: sum=2
    │       count=0, sum≠target → yazdırma
    └── HARİÇ 2: sum=0
        powerset(sum=0, i=2, j=0, count=1)
        ├── DAHİL 3: sum=3
        │   count=0, sum=3=target → YAZDIR: "3"
        └── HARİÇ 3: sum=0
            count=0, sum≠target → yazdırma

Sonuç: "1 2" ve "3"
```

---

### Yazdırma Mantığı

```c
if (sum == target && count == 0)
{
    int index = 0;
    while (j > 0)
    {
        printf("%d", player[index++]);
        if ((j - 1) == 0)
            break;
        printf(" ");   // son elemandan sonra boşluk YOK
        j--;
    }
    printf("\n");
}
```

`j` değeri seçilen eleman sayısını tutar. Son elemandan sonra boşluk bırakmamak için `j - 1 == 0` kontrolü yapılır.

---

### Karmaşıklık

- **Zaman**: $O(2^n)$ — her eleman için 2 seçenek (include/exclude)
- **Alan**: $O(n)$ — `player[]` dizisi + recursion stack

---

[⬆ powerset ana dizinine dön](../) · [⬆ Level 2](../../)

---

# 🇫🇷 Français

### Architecture de la solution

### Approche générale

Technique **Include/Exclude (Inclure/Exclure)** — essayer deux chemins pour chaque élément :
1. Ajouter cet élément au sous-ensemble → appel récursif
2. Ignorer cet élément → appel récursif

---

### Diagramme de flux

```
main(ac, av)
  │
  ├── ac <= 2? → return 1
  ├── target = atoi(av[1])     → somme cible
  ├── array[] = av[2..n]       → éléments de l'ensemble
  │
  └── powerset(array, player, target, sum=0, i=0, j=0, count=ac-2)
       │
       ├── sum == target ET count == 0?
       │    └── OUI → afficher player[] (j éléments) → return
       │
       ├── count > 0?
       │    │
       │    ├── INCLURE: sum += array[i], player[j] = array[i]
       │    │   └── powerset(..., sum, i+1, j+1, count-1)
       │    │       └── player[j] = 0, sum -= array[i]  (annuler)
       │    │
       │    └── EXCLURE:
       │        └── powerset(..., sum, i+1, j, count-1)
       │
       └── count == 0? → return (tous les éléments traités)
```

---

### Détail de la fonction : `powerset()`

```c
void powerset(int *array, int *player, int target,
              int sum, int i, int j, int count)
```

| Paramètre | Signification |
|:----------|:--------------|
| `array` | Éléments de l'ensemble original |
| `player` | Tableau temporaire contenant les éléments sélectionnés |
| `target` | Somme cible |
| `sum` | Somme actuelle |
| `i` | Position actuelle dans `array` |
| `j` | Position actuelle dans `player` (nombre d'éléments sélectionnés) |
| `count` | Nombre d'éléments restants |

#### Base Case

```c
if (sum == target && count == 0)
{
    // afficher j éléments dans player[]
    return;
}
```

`count == 0` : Tous les éléments ont été décidés (inclure/exclure) + `sum == target` : cible atteinte.

#### Recursive Case

```c
if (count > 0)
{
    // INCLURE
    sum = sum + array[i];
    player[j] = array[i];
    powerset(array, player, target, sum, i + 1, j + 1, count - 1);

    // ANNULER (backtrack)
    player[j] = 0;
    sum = sum - array[i];

    // EXCLURE
    powerset(array, player, target, sum, i + 1, j, count - 1);
}
```

---

### Exemple de trace

```
Input: ./powerset 3 1 2 3

array = {1, 2, 3}, target = 3, count = 3

powerset(sum=0, i=0, j=0, count=3)
├── INCLURE 1: sum=1, player={1}
│   powerset(sum=1, i=1, j=1, count=2)
│   ├── INCLURE 2: sum=3, player={1,2}
│   │   powerset(sum=3, i=2, j=2, count=1)
│   │   ├── INCLURE 3: sum=6, player={1,2,3}
│   │   │   count=0, sum≠target → pas d'affichage
│   │   └── EXCLURE 3:
│   │       count=0, sum=3=target → AFFICHER: "1 2"
│   └── EXCLURE 2: sum=1
│       powerset(sum=1, i=2, j=1, count=1)
│       ├── INCLURE 3: sum=4
│       │   count=0, sum≠target → pas d'affichage
│       └── EXCLURE 3: sum=1
│           count=0, sum≠target → pas d'affichage
│
└── EXCLURE 1: sum=0
    powerset(sum=0, i=1, j=0, count=2)
    ├── INCLURE 2: sum=2
    │   powerset(sum=2, i=2, j=1, count=1)
    │   ├── INCLURE 3: sum=5
    │   │   count=0, sum≠target → pas d'affichage
    │   └── EXCLURE 3: sum=2
    │       count=0, sum≠target → pas d'affichage
    └── EXCLURE 2: sum=0
        powerset(sum=0, i=2, j=0, count=1)
        ├── INCLURE 3: sum=3
        │   count=0, sum=3=target → AFFICHER: "3"
        └── EXCLURE 3: sum=0
            count=0, sum≠target → pas d'affichage

Résultat : "1 2" et "3"
```

---

### Logique d'affichage

```c
if (sum == target && count == 0)
{
    int index = 0;
    while (j > 0)
    {
        printf("%d", player[index++]);
        if ((j - 1) == 0)
            break;
        printf(" ");   // pas d'espace après le dernier élément
        j--;
    }
    printf("\n");
}
```

`j` contient le nombre d'éléments sélectionnés. Le test `j - 1 == 0` empêche un espace en fin de ligne après le dernier élément.

---

### Complexité

- **Temps** : $O(2^n)$ — deux choix par élément (inclure/exclure)
- **Espace** : $O(n)$ — tableau `player[]` + pile de récursion

---

[⬆ Retour à powerset](../) · [⬆ Level 2](../../)
