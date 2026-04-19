<p align="center"><a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a></p>

# 🇬🇧 English

## Subject Description

### What Does the Question Ask?

Given an `n` argument, print all solutions to the **N-Queens** problem.

```bash
./n_queens 4
# 1 3 0 2
# 2 0 3 1
```

---

### What is the N-Queens Problem?

Place $n$ queens on an $n \times n$ chessboard such that no queen threatens another.

A queen moves in 3 directions:
- **Row** (horizontal) — no other queen in the same row
- **Column** (vertical) — no other queen in the same column
- **Diagonal** — no other queen on the same diagonal

#### Visualization (n=4)

```
Solution: 1 3 0 2

    C0  C1  C2  C3
R0 [ ] [ ] [Q] [ ]     → board[2] = 0
R1 [Q] [ ] [ ] [ ]     → board[0] = 1
R2 [ ] [ ] [ ] [Q]     → board[3] = 2
R3 [ ] [Q] [ ] [ ]     → board[1] = 3
```

Output format: print `board[i]` values in order → `1 3 0 2`

---

### Concepts You Need to Know

#### 1. Backtracking

Backtracking is an algorithm that systematically tries possible solutions:

```
1. Place a queen in a column
2. Check if valid
   ├── YES → move to the next column
   └── NO  → skip this row, try the next row
3. If all rows tried → go back to the previous column
4. If all columns filled → SOLUTION FOUND
```

#### 2. Safety Check (is_safe)

Before placing a new queen, 3 checks are performed:

| Check | How | Formula |
|:------|:----|:--------|
| Same row | Is the same row used in previous columns? | `board[i] == row` |
| Same diagonal | Does row difference = column difference? | `abs(board[i] - row) == abs(i - col)` |
| Same column | Only 1 queen per column | Guaranteed by algorithm design |

#### 3. Output Format

```
<col_0_row> <col_1_row> ... <col_n-1_row>\n
```

- Numbers start from 0
- Separated by spaces (no trailing space after the last number)
- Each solution on a new line

---

### Allowed Functions

| Function | Usage |
|:---------|:------|
| `atoi` | Convert argument to integer |
| `fprintf` / `write` | Print output |
| `malloc` / `calloc` / `realloc` / `free` | Memory for board array |
| `stdout` / `stderr` | Output streams |

---

### Edge Cases

| n | Solution Count | Note |
|:-:|:-------------:|:-----|
| 1 | 1 | `0` |
| 2 | 0 | No solution |
| 3 | 0 | No solution |
| 4 | 2 | First meaningful solutions |
| 8 | 92 | Classic chessboard |

> For `n <= 3` no output is produced (except n=1, but exam tests usually use n > 3).

---

### Tips

1. **Use a global board array** — reduces parameter passing between recursive functions
2. **`ft_abs` function** — compute `|board[i] - row|` for diagonal checks
3. **n ≤ 3 → exit immediately** — if you don't handle this edge case you may get empty output issues

---

[⬆ Back to n_queens](../) · [⬆ Level 2](../../)

---

# 🇹🇷 Türkçe

## Subject Açıklaması

### Soru Ne İstiyor?

Argüman olarak verilen `n` sayısı için **N-Queens** probleminin tüm çözümlerini yazdır.

```bash
./n_queens 4
# 1 3 0 2
# 2 0 3 1
```

---

### N-Queens Problemi Nedir?

$n \times n$ boyutunda bir satranç tahtasına $n$ adet vezir (queen) yerleştir. Hiçbir vezir başka bir veziri tehdit etmemeli.

Vezir 3 yönde hareket eder:
- **Satır** (yatay) — aynı satırda başka vezir olamaz
- **Sütun** (dikey) — aynı sütunda başka vezir olamaz
- **Çapraz** (diagonal) — aynı çaprazda başka vezir olamaz

#### Görselleştirme (n=4)

```
Çözüm: 1 3 0 2

    C0  C1  C2  C3
R0 [ ] [ ] [Q] [ ]     → board[2] = 0
R1 [Q] [ ] [ ] [ ]     → board[0] = 1
R2 [ ] [ ] [ ] [Q]     → board[3] = 2
R3 [ ] [Q] [ ] [ ]     → board[1] = 3
```

Çıktı formatı: `board[i]` değerlerini sırayla yazdır → `1 3 0 2`

---

### Bilmen Gereken Kavramlar

#### 1. Backtracking (Geri İzleme)

Backtracking, olası çözümleri sistematik olarak deneyen bir algoritmadır:

```
1. Bir sütuna vezir yerleştir
2. Geçerli mi kontrol et
   ├── EVET → sonraki sütuna geç
   └── HAYIR → bu satırı atla, sonraki satırı dene
3. Tüm satırlar denendiyse → bir önceki sütuna geri dön
4. Tüm sütunlar dolduysa → ÇÖZÜM BULUNDU
```

#### 2. Güvenlik Kontrolü (is_safe)

Yeni bir vezir yerleştirmeden önce 3 kontrol yapılır:

| Kontrol | Nasıl | Formül |
|:--------|:------|:-------|
| Aynı satır | Önceki sütunlarda aynı satır var mı? | `board[i] == row` |
| Aynı çapraz | Satır farkı = sütun farkı mı? | `abs(board[i] - row) == abs(i - col)` |
| Aynı sütun | Her sütuna sadece 1 vezir konabilir | Algoritma doğası gereği sağlanır |

#### 3. Çıktı Formatı

```
<sütun_0_satırı> <sütun_1_satırı> ... <sütun_n-1_satırı>\n
```

- Her sayı 0'dan başlar
- Sayılar arası boşluk (son sayıdan sonra boşluk yok)
- Her çözüm yeni satırda

---

### İzin Verilen Fonksiyonlar

| Fonksiyon | Nerede Kullanılır |
|:----------|:-----------------|
| `atoi` | Argümanı integer'a çevirme |
| `fprintf` / `write` | Çıktı yazdırma |
| `malloc` / `calloc` / `realloc` / `free` | Board dizisi için bellek |
| `stdout` / `stderr` | Çıktı akışları |

---

### Edge Cases

| n | Çözüm Sayısı | Not |
|:-:|:------------:|:----|
| 1 | 1 | `0` |
| 2 | 0 | Çözüm yok |
| 3 | 0 | Çözüm yok |
| 4 | 2 | İlk anlamlı çözüm |
| 8 | 92 | Klasik satranç tahtası |

> `n <= 3` için hiçbir çıktı verilmez (n=1 hariç, ama sınav testleri genellikle n > 3 ile yapılır).

---

### İpuçları

1. **Global board dizisi** kullan — recursive fonksiyonlar arasında parametre taşımayı azaltır
2. **`ft_abs` fonksiyonu** → çapraz kontrolü için `|board[i] - row|` hesapla
3. **n ≤ 3 → hemen çık** — bu edge case'i kontrol etmezsen boş çıktı problemi olabilir

---

[⬆ n_queens ana dizinine dön](../) · [⬆ Level 2](../../)

---

# 🇫🇷 Français

## Description du sujet

### Que demande la question ?

Pour un nombre `n` donné en argument, afficher toutes les solutions du problème des **N-Reines**.

```bash
./n_queens 4
# 1 3 0 2
# 2 0 3 1
```

---

### Qu'est-ce que le problème des N-Reines ?

Placer $n$ reines sur un échiquier $n \times n$ de sorte qu'aucune reine ne menace une autre.

Une reine se déplace dans 3 directions :
- **Ligne** (horizontale) — aucune autre reine sur la même ligne
- **Colonne** (verticale) — aucune autre reine dans la même colonne
- **Diagonale** — aucune autre reine sur la même diagonale

#### Visualisation (n=4)

```
Solution : 1 3 0 2

    C0  C1  C2  C3
R0 [ ] [ ] [Q] [ ]     → board[2] = 0
R1 [Q] [ ] [ ] [ ]     → board[0] = 1
R2 [ ] [ ] [ ] [Q]     → board[3] = 2
R3 [ ] [Q] [ ] [ ]     → board[1] = 3
```

Format de sortie : afficher les valeurs `board[i]` dans l'ordre → `1 3 0 2`

---

### Concepts à connaître

#### 1. Backtracking (Retour sur trace)

Le backtracking est un algorithme qui essaie systématiquement les solutions possibles :

```
1. Placer une reine dans une colonne
2. Vérifier si c'est valide
   ├── OUI → passer à la colonne suivante
   └── NON → sauter cette ligne, essayer la suivante
3. Si toutes les lignes essayées → revenir à la colonne précédente
4. Si toutes les colonnes remplies → SOLUTION TROUVÉE
```

#### 2. Vérification de sécurité (is_safe)

Avant de placer une nouvelle reine, 3 vérifications sont effectuées :

| Vérification | Comment | Formule |
|:-------------|:--------|:--------|
| Même ligne | La même ligne existe-t-elle dans les colonnes précédentes ? | `board[i] == row` |
| Même diagonale | Différence de lignes = différence de colonnes ? | `abs(board[i] - row) == abs(i - col)` |
| Même colonne | Une seule reine par colonne | Garanti par la conception de l'algorithme |

#### 3. Format de sortie

```
<ligne_col_0> <ligne_col_1> ... <ligne_col_n-1>\n
```

- Les nombres commencent à 0
- Séparés par des espaces (pas d'espace après le dernier nombre)
- Chaque solution sur une nouvelle ligne

---

### Fonctions autorisées

| Fonction | Utilisation |
|:---------|:-----------|
| `atoi` | Convertir l'argument en entier |
| `fprintf` / `write` | Afficher la sortie |
| `malloc` / `calloc` / `realloc` / `free` | Mémoire pour le tableau board |
| `stdout` / `stderr` | Flux de sortie |

---

### Cas limites

| n | Nombre de solutions | Note |
|:-:|:-------------------:|:-----|
| 1 | 1 | `0` |
| 2 | 0 | Pas de solution |
| 3 | 0 | Pas de solution |
| 4 | 2 | Premières solutions significatives |
| 8 | 92 | Échiquier classique |

> Pour `n <= 3` aucune sortie n'est produite (sauf n=1, mais les tests d'examen utilisent généralement n > 3).

---

### Conseils

1. **Utiliser un tableau board global** — réduit le passage de paramètres entre les fonctions récursives
2. **Fonction `ft_abs`** → calculer `|board[i] - row|` pour les vérifications diagonales
3. **n ≤ 3 → quitter immédiatement** — si vous ne gérez pas ce cas limite, des problèmes de sortie vide peuvent survenir

---

[⬆ Retour à n_queens](../) · [⬆ Level 2](../../)
