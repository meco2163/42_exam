<p align="center"><a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a></p>

# 🇬🇧 English

# permutations — Tester Description

### Running

```bash
bash permutations_tester.sh
```

### How Does It Work?

The tester compiles `solution/permutations.c` and applies 4 different verification categories.

---

### Test List

#### Category 1: Subject Examples

Direct comparison with the official examples given in the subject:

| # | Command | Expected Output | Description |
|:-:|:--------|:---------------|:-----------|
| 1 | `./permutations a` | `a` | Single character — 1 permutation |
| 2 | `./permutations ab` | `ab`<br>`ba` | 2 characters — 2 permutations |
| 3 | `./permutations abc` | `abc`<br>`acb`<br>`bac`<br>`bca`<br>`cab`<br>`cba` | 3 characters — 6 permutations, alphabetical order |

#### Category 2: Permutation Count Tests ($n!$ check)

Output line count is compared with the expected $n!$ value:

| # | Command | Expected Line Count | Formula |
|:-:|:--------|:------------------:|:------:|
| 4 | `./permutations z` | **1** | $1! = 1$ |
| 5 | `./permutations xy` | **2** | $2! = 2$ |
| 6 | `./permutations abc` | **6** | $3! = 6$ |
| 7 | `./permutations abcd` | **24** | $4! = 24$ |
| 8 | `./permutations abcde` | **120** | $5! = 120$ |

#### Category 3: Alphabetical Order Tests

Sorts the output with `sort` and compares with the original output — if equal, it's in alphabetical order:

| # | Command | What Is Checked |
|:-:|:--------|:---------------|
| 9 | `./permutations abc` | Is output the same as `sort`? |
| 10 | `./permutations abcd` | Are 24 lines alphabetical? |
| 11 | `./permutations cba` | Unsorted input — is output still alphabetical? |
| 12 | `./permutations bac` | Unsorted input — is output still alphabetical? |

> **Note**: Even if input is `"cba"`, the output must be in `abc, acb, bac, ...` order.

#### Category 4: Duplicate Check

Verifies that no permutation is printed more than once:

| # | Command | What Is Checked |
|:-:|:--------|:---------------|
| 13 | `./permutations abcd` | 24 lines, 24 unique (no duplicates) |

---

### Verification Method

**Subject examples:**
- Output is compared exactly with the expected string (including order)

**Count tests:**
- Line count is measured with `wc -l`

**Order tests:**
- Output is sorted with the `sort` command and compared with the original
- Equality = already sorted

**Duplicate test:**
- Unique line count is checked with `sort -u | wc -l`

10 second timeout.

---

### Total Test Count

| Category | Test Count |
|:---------|:---------:|
| Subject examples | 3 |
| Count check ($n!$) | 5 |
| Alphabetical order | 4 |
| Duplicate check | 1 |
| **Total** | **13** |

---

[⬆ Back to permutations](../)

---

# 🇹🇷 Türkçe

# permutations — Tester Açıklaması

### Çalıştırma

```bash
bash permutations_tester.sh
```

### Nasıl Çalışır?

Tester, `solution/permutations.c` dosyasını derler ve 4 farklı doğrulama kategorisi uygular.

---

### Test Listesi

#### Kategori 1: Subject Örnekleri

Subject'te verilen resmi örneklerle birebir karşılaştırma:

| # | Komut | Beklenen Çıktı | Açıklama |
|:-:|:------|:---------------|:---------|
| 1 | `./permutations a` | `a` | Tek karakter — 1 permütasyon |
| 2 | `./permutations ab` | `ab`<br>`ba` | 2 karakter — 2 permütasyon |
| 3 | `./permutations abc` | `abc`<br>`acb`<br>`bac`<br>`bca`<br>`cab`<br>`cba` | 3 karakter — 6 permütasyon, alfabetik sıra |

#### Kategori 2: Permütasyon Sayısı Testleri ($n!$ kontrolü)

Çıktı satır sayısı ile beklenen $n!$ değeri karşılaştırılır:

| # | Komut | Beklenen Satır Sayısı | Formül |
|:-:|:------|:--------------------:|:------:|
| 4 | `./permutations z` | **1** | $1! = 1$ |
| 5 | `./permutations xy` | **2** | $2! = 2$ |
| 6 | `./permutations abc` | **6** | $3! = 6$ |
| 7 | `./permutations abcd` | **24** | $4! = 24$ |
| 8 | `./permutations abcde` | **120** | $5! = 120$ |

#### Kategori 3: Alfabetik Sıra Testleri

Çıktıyı `sort` ile sıralayıp orijinal çıktıyla karşılaştırır — eşitse alfabetik sırada demektir:

| # | Komut | Ne Kontrol Edilir |
|:-:|:------|:-----------------|
| 9 | `./permutations abc` | Çıktı `sort` ile aynı mı? |
| 10 | `./permutations abcd` | 24 satır alfabetik mi? |
| 11 | `./permutations cba` | Sırasız input — çıktı yine de alfabetik mi? |
| 12 | `./permutations bac` | Sırasız input — çıktı yine de alfabetik mi? |

> **Not**: Input `"cba"` verilse bile çıktı `abc, acb, bac, ...` sırasında olmalı.

#### Kategori 4: Tekrar Kontrolü

Aynı permütasyonun birden fazla yazdırılmadığı kontrol edilir:

| # | Komut | Ne Kontrol Edilir |
|:-:|:------|:-----------------|
| 13 | `./permutations abcd` | 24 satır, 24 benzersiz (tekrar yok) |

---

### Doğrulama Yöntemi

**Subject örnekleri:**
- Çıktı, beklenen string ile birebir karşılaştırılır (sıra dahil)

**Sayı testleri:**
- `wc -l` ile satır sayısı sayılır

**Sıra testleri:**
- Çıktı `sort` komutuyla sıralanır ve orijinalle karşılaştırılır
- Eşitlik = zaten sıralı

**Tekrar testi:**
- `sort -u | wc -l` ile benzersiz satır sayısı kontrol edilir

10 saniye timeout.

---

### Toplam Test Sayısı

| Kategori | Test Sayısı |
|:---------|:----------:|
| Subject örnekleri | 3 |
| Sayı kontrolü ($n!$) | 5 |
| Alfabetik sıra | 4 |
| Tekrar kontrolü | 1 |
| **Toplam** | **13** |

---

[⬆ permutations ana dizinine dön](../)

---

# 🇫🇷 Français

# permutations — Description du testeur

### Exécution

```bash
bash permutations_tester.sh
```

### Comment ça marche ?

Le testeur compile `solution/permutations.c` et applique 4 catégories de vérification différentes.

---

### Liste des tests

#### Catégorie 1 : Exemples du sujet

Comparaison directe avec les exemples officiels donnés dans le sujet :

| # | Commande | Sortie attendue | Description |
|:-:|:---------|:---------------|:-----------|
| 1 | `./permutations a` | `a` | Un seul caractère — 1 permutation |
| 2 | `./permutations ab` | `ab`<br>`ba` | 2 caractères — 2 permutations |
| 3 | `./permutations abc` | `abc`<br>`acb`<br>`bac`<br>`bca`<br>`cab`<br>`cba` | 3 caractères — 6 permutations, ordre alphabétique |

#### Catégorie 2 : Tests de nombre de permutations (vérification $n!$)

Le nombre de lignes en sortie est comparé à la valeur $n!$ attendue :

| # | Commande | Nombre de lignes attendu | Formule |
|:-:|:---------|:-----------------------:|:------:|
| 4 | `./permutations z` | **1** | $1! = 1$ |
| 5 | `./permutations xy` | **2** | $2! = 2$ |
| 6 | `./permutations abc` | **6** | $3! = 6$ |
| 7 | `./permutations abcd` | **24** | $4! = 24$ |
| 8 | `./permutations abcde` | **120** | $5! = 120$ |

#### Catégorie 3 : Tests d'ordre alphabétique

Trie la sortie avec `sort` et la compare à la sortie originale — si égal, c'est dans l'ordre alphabétique :

| # | Commande | Ce qui est vérifié |
|:-:|:---------|:------------------|
| 9 | `./permutations abc` | La sortie est-elle identique à `sort` ? |
| 10 | `./permutations abcd` | Les 24 lignes sont-elles alphabétiques ? |
| 11 | `./permutations cba` | Entrée non triée — la sortie est-elle quand même alphabétique ? |
| 12 | `./permutations bac` | Entrée non triée — la sortie est-elle quand même alphabétique ? |

> **Note** : Même si l'entrée est `"cba"`, la sortie doit être dans l'ordre `abc, acb, bac, ...`.

#### Catégorie 4 : Vérification des doublons

Vérifie qu'aucune permutation n'est affichée plus d'une fois :

| # | Commande | Ce qui est vérifié |
|:-:|:---------|:------------------|
| 13 | `./permutations abcd` | 24 lignes, 24 uniques (pas de doublons) |

---

### Méthode de vérification

**Exemples du sujet :**
- La sortie est comparée exactement avec la chaîne attendue (ordre inclus)

**Tests de nombre :**
- Le nombre de lignes est mesuré avec `wc -l`

**Tests d'ordre :**
- La sortie est triée avec la commande `sort` et comparée à l'originale
- Égalité = déjà trié

**Test de doublons :**
- Le nombre de lignes uniques est vérifié avec `sort -u | wc -l`

Timeout de 10 secondes.

---

### Nombre total de tests

| Catégorie | Nombre de tests |
|:----------|:--------------:|
| Exemples du sujet | 3 |
| Vérification du nombre ($n!$) | 5 |
| Ordre alphabétique | 4 |
| Vérification des doublons | 1 |
| **Total** | **13** |

---

[⬆ Retour à permutations](../)
