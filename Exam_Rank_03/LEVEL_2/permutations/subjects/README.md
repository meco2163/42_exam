<p align="center"><a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a></p>

# 🇬🇧 English

# permutations — Subject Description

### What Does the Question Ask?

Print all **permutations** of a string given as argument, in alphabetical order.

```bash
./permutations abc
# abc
# acb
# bac
# bca
# cab
# cba
```

---

### What is a Permutation?

All possible orderings of the elements of a set.

- A set of `n` elements has $n!$ (n factorial) permutations
- `"abc"` → $3! = 6$ permutations
- `"abcd"` → $4! = 24$ permutations

| n | $n!$ |
|:-:|:----:|
| 1 | 1 |
| 2 | 2 |
| 3 | 6 |
| 4 | 24 |
| 5 | 120 |
| 6 | 720 |
| 7 | 5040 |

---

### Concepts You Need to Know

#### 1. Recursion

Generating permutations is naturally a recursive process:

```
Permutations of "abc":
├── pick 'a' → permutations of "bc": "abc", "acb"
├── pick 'b' → permutations of "ac": "bac", "bca"
└── pick 'c' → permutations of "ab": "cab", "cba"
```

At each step:
1. Pick an unused character
2. Append it to the temporary string
3. Make a recursive call with the remaining characters
4. Put the character back (backtrack)

#### 2. Alphabetical Sorting

The output must be in **alphabetical order**. To achieve this:
1. **Sort** the string at the beginning (selection sort is sufficient)
2. Always scan **left to right** in the recursive function

```
Sorted "abc" → permutations come in alphabetical order automatically
Unsorted "cba" → sort first: "abc" → then permute
```

#### 3. "Used" Marking

When you use a character, temporarily "delete" it (set to 0), and restore it when done:

```c
c = str[i];       // save the character
str[i] = 0;       // mark as "used"
// ... recursive call ...
str[i] = c;       // restore
```

---

### Allowed Functions

| Function | Where Used |
|:---------|:----------|
| `puts` | Line printing |
| `write` | Character-by-character printing |
| `malloc` / `calloc` / `realloc` / `free` | Temporary buffer |

---

### Output Format

- Each permutation on a separate line
- Ordering: lexicographic (dictionary) order
- No duplicate characters are guaranteed (inputs like `"abccd"` will not be given)

---

### Tips

1. **Sort first** — required for alphabetical output
2. **`tmp` buffer** — pass a temporary array to the recursive function, track position with `depth`
3. **NULL terminator** — mark as "used" with `str[i] = 0`, restore when done
4. **Base case**: when `depth == len`, print `tmp`

---

[⬆ Back to permutations](../) · [⬆ Level 2](../../)

---

# 🇹🇷 Türkçe

# permutations — Subject Açıklaması

### Soru Ne İstiyor?

Argüman olarak verilen bir stringin **tüm permütasyonlarını** alfabetik sırada yazdır.

```bash
./permutations abc
# abc
# acb
# bac
# bca
# cab
# cba
```

---

### Permütasyon Nedir?

Bir kümenin elemanlarının tüm olası sıralamalarıdır.

- `n` elemanlı bir kümenin $n!$ (n faktöriyel) permütasyonu vardır
- `"abc"` → $3! = 6$ permütasyon
- `"abcd"` → $4! = 24$ permütasyon

| n | $n!$ |
|:-:|:----:|
| 1 | 1 |
| 2 | 2 |
| 3 | 6 |
| 4 | 24 |
| 5 | 120 |
| 6 | 720 |
| 7 | 5040 |

---

### Bilmen Gereken Kavramlar

#### 1. Recursion (Özyineleme)

Permütasyon oluşturmak doğal olarak recursive bir süreçtir:

```
"abc" permütasyonları:
├── 'a' seç → "bc" nin permütasyonları: "abc", "acb"
├── 'b' seç → "ac" nin permütasyonları: "bac", "bca"
└── 'c' seç → "ab" nin permütasyonları: "cab", "cba"
```

Her adımda:
1. Kullanılmamış bir karakter seç
2. Onu geçici string'e ekle
3. Kalan karakterlerle recursive çağrı yap
4. Karakteri geri bırak (backtrack)

#### 2. Alfabetik Sıralama

Çıktı **alfabetik sırada** olmalı. Bunun için:
1. Başlangıçta string'i **sırala** (selection sort yeterli)
2. Recursive fonksiyonda her zaman **soldan sağa** tara

```
Sıralı "abc" → permütasyonlar otomatik alfabetik sırada gelir
Sırasız "cba" → önce sırala: "abc" → sonra permüte et
```

#### 3. "Kullanıldı" İşaretleme

Bir karakteri kullandığında onu geçici olarak "sil" (0 yap), işi bitince geri koy:

```c
c = str[i];       // karakteri sakla
str[i] = 0;       // "kullanıldı" olarak işaretle
// ... recursive çağrı ...
str[i] = c;       // geri koy
```

---

### İzin Verilen Fonksiyonlar

| Fonksiyon | Nerede Kullanılır |
|:----------|:-----------------|
| `puts` | Satır yazdırma |
| `write` | Karakter karakter yazdırma |
| `malloc` / `calloc` / `realloc` / `free` | Geçici buffer |

---

### Çıktı Formatı

- Her permütasyon ayrı satırda
- Sıralama: leksikografik (sözlük) sırası
- Tekrar eden karakter olmayacağı garanti (`"abccd"` gibi input verilmez)

---

### İpuçları

1. **Önce sırala** — alfabetik çıktı için şart
2. **`tmp` buffer** — recursive fonksiyona geçici dizi ver, `depth` ile pozisyon takip et
3. **NULL terminator** — `str[i] = 0` ile "kullandım" işareti koy, bitince geri yaz
4. **Base case**: `depth == len` olduğunda `tmp`'yi yazdır

---

[⬆ permutations ana dizinine dön](../) · [⬆ Level 2](../../)

---

# 🇫🇷 Français

# permutations — Description du sujet

### Que demande la question ?

Afficher toutes les **permutations** d'une chaîne donnée en argument, dans l'ordre alphabétique.

```bash
./permutations abc
# abc
# acb
# bac
# bca
# cab
# cba
```

---

### Qu'est-ce qu'une permutation ?

Tous les arrangements possibles des éléments d'un ensemble.

- Un ensemble de `n` éléments a $n!$ (n factorielle) permutations
- `"abc"` → $3! = 6$ permutations
- `"abcd"` → $4! = 24$ permutations

| n | $n!$ |
|:-:|:----:|
| 1 | 1 |
| 2 | 2 |
| 3 | 6 |
| 4 | 24 |
| 5 | 120 |
| 6 | 720 |
| 7 | 5040 |

---

### Concepts à connaître

#### 1. Récursion

La génération de permutations est naturellement un processus récursif :

```
Permutations de "abc" :
├── choisir 'a' → permutations de "bc" : "abc", "acb"
├── choisir 'b' → permutations de "ac" : "bac", "bca"
└── choisir 'c' → permutations de "ab" : "cab", "cba"
```

À chaque étape :
1. Choisir un caractère non utilisé
2. L'ajouter à la chaîne temporaire
3. Faire un appel récursif avec les caractères restants
4. Remettre le caractère en place (backtrack)

#### 2. Tri alphabétique

La sortie doit être dans l'**ordre alphabétique**. Pour cela :
1. **Trier** la chaîne au début (le tri par sélection suffit)
2. Toujours parcourir **de gauche à droite** dans la fonction récursive

```
Trié "abc" → les permutations arrivent automatiquement dans l'ordre alphabétique
Non trié "cba" → trier d'abord : "abc" → puis permuter
```

#### 3. Marquage "utilisé"

Quand vous utilisez un caractère, « supprimez-le » temporairement (mettez-le à 0), puis restaurez-le une fois terminé :

```c
c = str[i];       // sauvegarder le caractère
str[i] = 0;       // marquer comme "utilisé"
// ... appel récursif ...
str[i] = c;       // restaurer
```

---

### Fonctions autorisées

| Fonction | Utilisation |
|:---------|:-----------|
| `puts` | Affichage de ligne |
| `write` | Affichage caractère par caractère |
| `malloc` / `calloc` / `realloc` / `free` | Buffer temporaire |

---

### Format de sortie

- Chaque permutation sur une ligne séparée
- Ordre : lexicographique (dictionnaire)
- Aucun caractère en double n'est garanti (des entrées comme `"abccd"` ne seront pas données)

---

### Conseils

1. **Trier d'abord** — indispensable pour une sortie alphabétique
2. **Buffer `tmp`** — passer un tableau temporaire à la fonction récursive, suivre la position avec `depth`
3. **Terminateur NULL** — marquer comme « utilisé » avec `str[i] = 0`, restaurer une fois terminé
4. **Cas de base** : quand `depth == len`, afficher `tmp`

---

[⬆ Retour à permutations](../) · [⬆ Level 2](../../)
