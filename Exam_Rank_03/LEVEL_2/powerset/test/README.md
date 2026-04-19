> 📁 **Files:** [powerset_tester.sh](powerset_tester.sh)

# powerset — Tester

<p align="center"><a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a></p>

---

# 🇬🇧 English

### Tester Description

### Running

```bash
bash powerset_tester.sh
```

### How It Works

The tester compiles `solution/powerset.c` and applies 3 different verification categories. Since line order does not matter, outputs are sorted with `sort` before comparison.

---

### Test List

#### Category 1: Subject Examples

| # | Command | Expected Output | Description |
|:-:|:--------|:----------------|:------------|
| 1 | `./powerset 3 1 0 2 4 5 3` | `3`<br>`0 3`<br>`1 2`<br>`1 0 2` | Target=3, set={1,0,2,4,5,3} — 4 subsets |
| 2 | `./powerset 12 5 2 1 8 4 3 7 11` | `8 4`<br>`1 11`<br>`1 4 7`<br>`1 8 3`<br>`2 3 7`<br>`5 7`<br>`5 4 3`<br>`5 2 1 4` | Target=12, large set — 8 subsets |
| 3 | `./powerset 0 1 -1` | *(empty line)*<br>`1 -1` | Target=0, negative numbers — empty set + {1,-1} |

> **Test 3 detail**: The empty subset sums to 0. It appears as an empty line in the output. `1 + (-1) = 0` is also valid.

#### Category 2: Additional Tests

| # | Command | Expected Output | Description |
|:-:|:--------|:----------------|:------------|
| 4 | `./powerset 5 1 2 3 4 5` | `5`<br>`1 4`<br>`2 3` | Target=5, set={1,2,3,4,5} — 3 subsets |
| 5 | `./powerset 10 10` | `10` | Single element, exact match |
| 6 | `./powerset 100 1 2 3` | *(empty)* | No solution — no subset can reach 100 |

#### Category 3: Error Handling (Exit Code)

| # | Command | Expected Exit Code | Description |
|:-:|:--------|:------------------:|:------------|
| 7 | `./powerset` | `1` | No arguments |
| 8 | `./powerset 5` | `1` | Only target given, no set elements |

---

### Verification Method

**Subject and additional tests:**
1. The program is run and its output is captured
2. Expected and actual outputs are sorted with `sort` (line order does not matter)
3. Sorted strings are compared — if equal, **PASS**

**No solution test:**
- Checks that the output is completely empty

**Exit code tests:**
- Checks whether `$?` equals `1`

10-second timeout.

---

### Total Test Count

| Category | Test Count |
|:---------|:---------:|
| Subject examples | 3 |
| Additional tests | 3 |
| Error handling | 2 |
| **Total** | **8** |

---

### Detailed Expected Output for Each Test

#### Test 1: `./powerset 3 1 0 2 4 5 3`

```
Target: 3
Set:    {1, 0, 2, 4, 5, 3}

Finding subsets:
  {3}       → 3 = 3 ✓
  {0, 3}    → 0+3 = 3 ✓
  {1, 2}    → 1+2 = 3 ✓
  {1, 0, 2} → 1+0+2 = 3 ✓
```

#### Test 2: `./powerset 12 5 2 1 8 4 3 7 11`

```
Target: 12
Set:    {5, 2, 1, 8, 4, 3, 7, 11}

Finding subsets:
  {8, 4}       → 8+4 = 12 ✓
  {1, 11}      → 1+11 = 12 ✓
  {1, 4, 7}    → 1+4+7 = 12 ✓
  {1, 8, 3}    → 1+8+3 = 12 ✓
  {2, 3, 7}    → 2+3+7 = 12 ✓
  {5, 7}       → 5+7 = 12 ✓
  {5, 4, 3}    → 5+4+3 = 12 ✓
  {5, 2, 1, 4} → 5+2+1+4 = 12 ✓
```

#### Test 3: `./powerset 0 1 -1`

```
Target: 0
Set:    {1, -1}

Finding subsets:
  {}       → 0 = 0 ✓ (empty line)
  {1, -1}  → 1+(-1) = 0 ✓
```

---

[⬆ Back to powerset](../) · [⬆ Level 2](../../)

---

# 🇹🇷 Türkçe

### Tester Açıklaması

### Çalıştırma

```bash
bash powerset_tester.sh
```

### Nasıl Çalışır?

Tester, `solution/powerset.c` dosyasını derler ve 3 farklı doğrulama kategorisi uygular. Satır sırası önemli olmadığından çıktılar `sort` ile sıralanarak karşılaştırılır.

---

### Test Listesi

#### Kategori 1: Subject Örnekleri

| # | Komut | Beklenen Çıktı | Açıklama |
|:-:|:------|:---------------|:---------|
| 1 | `./powerset 3 1 0 2 4 5 3` | `3`<br>`0 3`<br>`1 2`<br>`1 0 2` | Hedef=3, küme={1,0,2,4,5,3} — 4 alt küme |
| 2 | `./powerset 12 5 2 1 8 4 3 7 11` | `8 4`<br>`1 11`<br>`1 4 7`<br>`1 8 3`<br>`2 3 7`<br>`5 7`<br>`5 4 3`<br>`5 2 1 4` | Hedef=12, büyük küme — 8 alt küme |
| 3 | `./powerset 0 1 -1` | *(boş satır)*<br>`1 -1` | Hedef=0, negatif sayılar — boş küme + {1,-1} |

> **Test 3 detayı**: Boş alt kümenin toplamı 0'dır. Çıktıda boş satır olarak görünür. `1 + (-1) = 0` da geçerli.

#### Kategori 2: Ek Testler

| # | Komut | Beklenen Çıktı | Açıklama |
|:-:|:------|:---------------|:---------|
| 4 | `./powerset 5 1 2 3 4 5` | `5`<br>`1 4`<br>`2 3` | Hedef=5, küme={1,2,3,4,5} — 3 alt küme |
| 5 | `./powerset 10 10` | `10` | Tek eleman, tam eşleşme |
| 6 | `./powerset 100 1 2 3` | *(boş)* | Çözüm yok — hiçbir alt küme 100'e ulaşamaz |

#### Kategori 3: Hata Yönetimi (Exit Code)

| # | Komut | Beklenen Exit Code | Açıklama |
|:-:|:------|:------------------:|:---------|
| 7 | `./powerset` | `1` | Argüman yok |
| 8 | `./powerset 5` | `1` | Sadece hedef var, küme elemanı yok |

---

### Doğrulama Yöntemi

**Subject ve ek testler:**
1. Program çalıştırılır, çıktı alınır
2. Beklenen ve gerçek çıktı `sort` ile sıralanır (satır sırası önemli değil)
3. Sıralanmış stringler karşılaştırılır — eşitse **PASS**

**Çözüm yok testi:**
- Çıktının tamamen boş olduğu kontrol edilir

**Exit code testleri:**
- `$?` değeri `1` mi kontrol edilir

10 saniye timeout.

---

### Toplam Test Sayısı

| Kategori | Test Sayısı |
|:---------|:----------:|
| Subject örnekleri | 3 |
| Ek testler | 3 |
| Hata yönetimi | 2 |
| **Toplam** | **8** |

---

### Her Testin Detaylı Beklenen Çıktısı

#### Test 1: `./powerset 3 1 0 2 4 5 3`

```
Hedef: 3
Küme:  {1, 0, 2, 4, 5, 3}

Alt küme bulma:
  {3}       → 3 = 3 ✓
  {0, 3}    → 0+3 = 3 ✓
  {1, 2}    → 1+2 = 3 ✓
  {1, 0, 2} → 1+0+2 = 3 ✓
```

#### Test 2: `./powerset 12 5 2 1 8 4 3 7 11`

```
Hedef: 12
Küme:  {5, 2, 1, 8, 4, 3, 7, 11}

Alt küme bulma:
  {8, 4}       → 8+4 = 12 ✓
  {1, 11}      → 1+11 = 12 ✓
  {1, 4, 7}    → 1+4+7 = 12 ✓
  {1, 8, 3}    → 1+8+3 = 12 ✓
  {2, 3, 7}    → 2+3+7 = 12 ✓
  {5, 7}       → 5+7 = 12 ✓
  {5, 4, 3}    → 5+4+3 = 12 ✓
  {5, 2, 1, 4} → 5+2+1+4 = 12 ✓
```

#### Test 3: `./powerset 0 1 -1`

```
Hedef: 0
Küme:  {1, -1}

Alt küme bulma:
  {}       → 0 = 0 ✓ (boş satır)
  {1, -1}  → 1+(-1) = 0 ✓
```

---

[⬆ powerset ana dizinine dön](../) · [⬆ Level 2](../../)

---

# 🇫🇷 Français

### Description du testeur

### Exécution

```bash
bash powerset_tester.sh
```

### Comment ça marche ?

Le testeur compile `solution/powerset.c` et applique 3 catégories de vérification différentes. Comme l'ordre des lignes n'a pas d'importance, les sorties sont triées avec `sort` avant comparaison.

---

### Liste des tests

#### Catégorie 1 : Exemples du sujet

| # | Commande | Sortie attendue | Description |
|:-:|:---------|:----------------|:------------|
| 1 | `./powerset 3 1 0 2 4 5 3` | `3`<br>`0 3`<br>`1 2`<br>`1 0 2` | Cible=3, ensemble={1,0,2,4,5,3} — 4 sous-ensembles |
| 2 | `./powerset 12 5 2 1 8 4 3 7 11` | `8 4`<br>`1 11`<br>`1 4 7`<br>`1 8 3`<br>`2 3 7`<br>`5 7`<br>`5 4 3`<br>`5 2 1 4` | Cible=12, grand ensemble — 8 sous-ensembles |
| 3 | `./powerset 0 1 -1` | *(ligne vide)*<br>`1 -1` | Cible=0, nombres négatifs — ensemble vide + {1,-1} |

> **Détail du test 3** : La somme du sous-ensemble vide est 0. Il apparaît comme une ligne vide dans la sortie. `1 + (-1) = 0` est aussi valide.

#### Catégorie 2 : Tests supplémentaires

| # | Commande | Sortie attendue | Description |
|:-:|:---------|:----------------|:------------|
| 4 | `./powerset 5 1 2 3 4 5` | `5`<br>`1 4`<br>`2 3` | Cible=5, ensemble={1,2,3,4,5} — 3 sous-ensembles |
| 5 | `./powerset 10 10` | `10` | Élément unique, correspondance exacte |
| 6 | `./powerset 100 1 2 3` | *(vide)* | Pas de solution — aucun sous-ensemble ne peut atteindre 100 |

#### Catégorie 3 : Gestion des erreurs (Exit Code)

| # | Commande | Exit Code attendu | Description |
|:-:|:---------|:------------------:|:------------|
| 7 | `./powerset` | `1` | Aucun argument |
| 8 | `./powerset 5` | `1` | Seulement la cible, pas d'éléments d'ensemble |

---

### Méthode de vérification

**Tests du sujet et supplémentaires :**
1. Le programme est exécuté et sa sortie est capturée
2. Les sorties attendue et réelle sont triées avec `sort` (l'ordre des lignes n'a pas d'importance)
3. Les chaînes triées sont comparées — si égales, **PASS**

**Test sans solution :**
- Vérifie que la sortie est complètement vide

**Tests de code de sortie :**
- Vérifie si `$?` est égal à `1`

Timeout de 10 secondes.

---

### Nombre total de tests

| Catégorie | Nombre de tests |
|:----------|:---------------:|
| Exemples du sujet | 3 |
| Tests supplémentaires | 3 |
| Gestion des erreurs | 2 |
| **Total** | **8** |

---

### Sortie attendue détaillée pour chaque test

#### Test 1 : `./powerset 3 1 0 2 4 5 3`

```
Cible :    3
Ensemble : {1, 0, 2, 4, 5, 3}

Recherche de sous-ensembles :
  {3}       → 3 = 3 ✓
  {0, 3}    → 0+3 = 3 ✓
  {1, 2}    → 1+2 = 3 ✓
  {1, 0, 2} → 1+0+2 = 3 ✓
```

#### Test 2 : `./powerset 12 5 2 1 8 4 3 7 11`

```
Cible :    12
Ensemble : {5, 2, 1, 8, 4, 3, 7, 11}

Recherche de sous-ensembles :
  {8, 4}       → 8+4 = 12 ✓
  {1, 11}      → 1+11 = 12 ✓
  {1, 4, 7}    → 1+4+7 = 12 ✓
  {1, 8, 3}    → 1+8+3 = 12 ✓
  {2, 3, 7}    → 2+3+7 = 12 ✓
  {5, 7}       → 5+7 = 12 ✓
  {5, 4, 3}    → 5+4+3 = 12 ✓
  {5, 2, 1, 4} → 5+2+1+4 = 12 ✓
```

#### Test 3 : `./powerset 0 1 -1`

```
Cible :    0
Ensemble : {1, -1}

Recherche de sous-ensembles :
  {}       → 0 = 0 ✓ (ligne vide)
  {1, -1}  → 1+(-1) = 0 ✓
```

---

[⬆ Retour à powerset](../) · [⬆ Level 2](../../)
