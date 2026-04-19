> 📁 **Files:** [n_queens_tester.sh](n_queens_tester.sh)

<p align="center"><a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a></p>

# 🇬🇧 English

## Tester Description

### How to Run

```bash
bash n_queens_tester.sh
```

### How Does It Work?

The tester compiles `solution/n_queens.c` and applies 3 different verification categories: solution count, validity, and duplicate check.

---

### Test List

#### Category 1: Solution Count Tests

The known correct solution count is checked for each n value:

| # | Command | Expected Solution Count | Description |
|:-:|:--------|:-----------------------:|:------------|
| 1 | `./n_queens 1` | **1** | Single queen — `0` |
| 2 | `./n_queens 2` | **0** | No solution on 2×2 board |
| 3 | `./n_queens 3` | **0** | No solution on 3×3 board |
| 4 | `./n_queens 4` | **2** | `1 3 0 2` and `2 0 3 1` |
| 5 | `./n_queens 5` | **10** | 10 different placements |
| 6 | `./n_queens 6` | **4** | 4 different placements |
| 7 | `./n_queens 7` | **40** | 40 different placements |
| 8 | `./n_queens 8` | **92** | Classic 8-queens — 92 solutions |

#### Category 2: Solution Validity Tests

3 rules are validated for each output line:

| Rule | Check | Detail |
|:-----|:------|:-------|
| Queen count | Must have `n` numbers | Missing or extra numbers → FAIL |
| Row check | No two queens on the same row | `board[i] == board[j]` → FAIL |
| Diagonal check | No two queens on the same diagonal | `|board[i]-board[j]| == |i-j|` → FAIL |

Tested n values:

| # | Command | What is Checked |
|:-:|:--------|:---------------|
| 9 | `./n_queens 4` | Are all solution lines valid? |
| 10 | `./n_queens 5` | Are all solution lines valid? |
| 11 | `./n_queens 6` | Are all solution lines valid? |
| 12 | `./n_queens 8` | Are all 92 solutions valid? |

#### Category 3: Duplicate Check

Checks that the same solution is not printed more than once (using `sort -u`):

| # | Command | What is Checked |
|:-:|:--------|:---------------|
| 13 | `./n_queens 4` | 2 lines, 2 unique |
| 14 | `./n_queens 5` | 10 lines, 10 unique |
| 15 | `./n_queens 8` | 92 lines, 92 unique |

---

### Verification Method

**Solution count:**
- Output line count is counted (`wc -l`) and compared to the known value

**Validity:**
- Each line is parsed → queen positions are stored in an array
- Pairwise comparison: row conflicts and diagonal conflicts are checked

**Duplicates:**
- `sort -u | wc -l` compares the unique line count with the total line count

10 second timeout — infinite loop protection for large n values.

---

### Total Test Count

| Category | Test Count |
|:---------|:---------:|
| Solution count | 8 |
| Validity | 4 |
| Duplicate check | 3 |
| **Total** | **15** |

---

### Reference: N-Queens Solution Counts

| n | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:--:|
| Solutions | 1 | 0 | 0 | 2 | 10 | 4 | 40 | 92 | 352 | 724 |

---

[⬆ Back to n_queens](../)

---

# 🇹🇷 Türkçe

## Tester Açıklaması

### Çalıştırma

```bash
bash n_queens_tester.sh
```

### Nasıl Çalışır?

Tester, `solution/n_queens.c` dosyasını derler ve 3 farklı doğrulama kategorisi uygular: çözüm sayısı, geçerlilik ve tekrar kontrolü.

---

### Test Listesi

#### Kategori 1: Çözüm Sayısı Testleri

Her n değeri için bilinen doğru çözüm sayısı kontrol edilir:

| # | Komut | Beklenen Çözüm Sayısı | Açıklama |
|:-:|:------|:---------------------:|:---------|
| 1 | `./n_queens 1` | **1** | Tek vezir — `0` |
| 2 | `./n_queens 2` | **0** | 2×2 tahtada çözüm yok |
| 3 | `./n_queens 3` | **0** | 3×3 tahtada çözüm yok |
| 4 | `./n_queens 4` | **2** | `1 3 0 2` ve `2 0 3 1` |
| 5 | `./n_queens 5` | **10** | 10 farklı yerleşim |
| 6 | `./n_queens 6` | **4** | 4 farklı yerleşim |
| 7 | `./n_queens 7` | **40** | 40 farklı yerleşim |
| 8 | `./n_queens 8` | **92** | Klasik 8-queens — 92 çözüm |

#### Kategori 2: Çözüm Geçerlilik Testleri

Her çıktı satırı için 3 kural doğrulanır:

| Kural | Kontrol | Detay |
|:------|:--------|:------|
| Vezir sayısı | `n` adet sayı olmalı | Eksik veya fazla sayı → FAIL |
| Satır kontrolü | Hiçbir iki vezir aynı satırda olmamalı | `board[i] == board[j]` → FAIL |
| Çapraz kontrol | Hiçbir iki vezir aynı çaprazda olmamalı | `|board[i]-board[j]| == |i-j|` → FAIL |

Test edilen n değerleri:

| # | Komut | Ne Kontrol Edilir |
|:-:|:------|:-----------------|
| 9 | `./n_queens 4` | Tüm çözüm satırları geçerli mi? |
| 10 | `./n_queens 5` | Tüm çözüm satırları geçerli mi? |
| 11 | `./n_queens 6` | Tüm çözüm satırları geçerli mi? |
| 12 | `./n_queens 8` | 92 çözümün hepsi geçerli mi? |

#### Kategori 3: Tekrar Kontrolü

Aynı çözümün birden fazla yazdırılmadığı kontrol edilir (`sort -u` ile):

| # | Komut | Ne Kontrol Edilir |
|:-:|:------|:-----------------|
| 13 | `./n_queens 4` | 2 satır, 2 benzersiz |
| 14 | `./n_queens 5` | 10 satır, 10 benzersiz |
| 15 | `./n_queens 8` | 92 satır, 92 benzersiz |

---

### Doğrulama Yöntemi

**Çözüm sayısı:**
- Çıktı satır sayısı sayılır (`wc -l`) ve bilinen değerle karşılaştırılır

**Geçerlilik:**
- Her satır parse edilir → queen pozisyonları diziye alınır
- İkili karşılaştırma: satır çakışması ve çapraz çakışması kontrol edilir

**Tekrar:**
- `sort -u | wc -l` ile benzersiz satır sayısı toplam satır sayısıyla karşılaştırılır

10 saniye timeout — büyük n değerlerinde sonsuz döngü koruması.

---

### Toplam Test Sayısı

| Kategori | Test Sayısı |
|:---------|:----------:|
| Çözüm sayısı | 8 |
| Geçerlilik | 4 |
| Tekrar kontrolü | 3 |
| **Toplam** | **15** |

---

### Referans: N-Queens Çözüm Sayıları

| n | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:--:|
| Çözüm | 1 | 0 | 0 | 2 | 10 | 4 | 40 | 92 | 352 | 724 |

---

[⬆ n_queens ana dizinine dön](../)

---

# 🇫🇷 Français

## Description du testeur

### Exécution

```bash
bash n_queens_tester.sh
```

### Comment ça marche ?

Le testeur compile `solution/n_queens.c` et applique 3 catégories de vérification différentes : nombre de solutions, validité et vérification des doublons.

---

### Liste des tests

#### Catégorie 1 : Tests de nombre de solutions

Le nombre correct connu de solutions est vérifié pour chaque valeur de n :

| # | Commande | Nombre de solutions attendu | Description |
|:-:|:---------|:---------------------------:|:------------|
| 1 | `./n_queens 1` | **1** | Une seule reine — `0` |
| 2 | `./n_queens 2` | **0** | Pas de solution sur un échiquier 2×2 |
| 3 | `./n_queens 3` | **0** | Pas de solution sur un échiquier 3×3 |
| 4 | `./n_queens 4` | **2** | `1 3 0 2` et `2 0 3 1` |
| 5 | `./n_queens 5` | **10** | 10 placements différents |
| 6 | `./n_queens 6` | **4** | 4 placements différents |
| 7 | `./n_queens 7` | **40** | 40 placements différents |
| 8 | `./n_queens 8` | **92** | 8-reines classique — 92 solutions |

#### Catégorie 2 : Tests de validité

3 règles sont validées pour chaque ligne de sortie :

| Règle | Vérification | Détail |
|:------|:-------------|:-------|
| Nombre de reines | Doit avoir `n` nombres | Nombres manquants ou en trop → FAIL |
| Vérification de ligne | Aucune reine sur la même ligne | `board[i] == board[j]` → FAIL |
| Vérification diagonale | Aucune reine sur la même diagonale | `|board[i]-board[j]| == |i-j|` → FAIL |

Valeurs de n testées :

| # | Commande | Ce qui est vérifié |
|:-:|:---------|:------------------|
| 9 | `./n_queens 4` | Toutes les lignes de solution sont-elles valides ? |
| 10 | `./n_queens 5` | Toutes les lignes de solution sont-elles valides ? |
| 11 | `./n_queens 6` | Toutes les lignes de solution sont-elles valides ? |
| 12 | `./n_queens 8` | Les 92 solutions sont-elles toutes valides ? |

#### Catégorie 3 : Vérification des doublons

Vérifie que la même solution n'est pas affichée plus d'une fois (avec `sort -u`) :

| # | Commande | Ce qui est vérifié |
|:-:|:---------|:------------------|
| 13 | `./n_queens 4` | 2 lignes, 2 uniques |
| 14 | `./n_queens 5` | 10 lignes, 10 uniques |
| 15 | `./n_queens 8` | 92 lignes, 92 uniques |

---

### Méthode de vérification

**Nombre de solutions :**
- Le nombre de lignes de sortie est compté (`wc -l`) et comparé à la valeur connue

**Validité :**
- Chaque ligne est analysée → les positions des reines sont stockées dans un tableau
- Comparaison par paires : les conflits de lignes et de diagonales sont vérifiés

**Doublons :**
- `sort -u | wc -l` compare le nombre de lignes uniques avec le nombre total de lignes

Timeout de 10 secondes — protection contre les boucles infinies pour les grandes valeurs de n.

---

### Nombre total de tests

| Catégorie | Nombre de tests |
|:----------|:---------------:|
| Nombre de solutions | 8 |
| Validité | 4 |
| Vérification des doublons | 3 |
| **Total** | **15** |

---

### Référence : Nombre de solutions N-Reines

| n | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:--:|
| Solutions | 1 | 0 | 0 | 2 | 10 | 4 | 40 | 92 | 352 | 724 |

---

[⬆ Retour à n_queens](../)
