> 📁 **Files:** [filter_tester.sh](filter_tester.sh)

<p align="center">
  <a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a>
</p>

---

# 🇬🇧 English

## filter — Tester Description

### How to Run

```bash
bash filter_tester.sh
```

### How Does It Work?

The tester compiles `solution/filter.c` with `-Wall -Wextra -Werror` flags and runs 3 categories of tests.

---

### Test List

#### Category 1: Subject Examples

Official examples given in the subject:

| # | Input | Argument | Expected Output | Description |
|:-:|:------|:---------|:---------------|:---------|
| 1 | `abcdefaaaabcdeabcabcdabc` | `abc` | `***defaaa***de******d***` | Multiple matches at different positions |
| 2 | `ababcabababc` | `ababc` | `*****ab*****` | Overlapping pattern — first match takes priority |

#### Category 2: Basic Tests

| # | Input | Argument | Expected Output | Description |
|:-:|:------|:---------|:---------------|:---------|
| 3 | `hello world` | `world` | `hello *****` | Simple match at the end |
| 4 | `hello world` | `xyz` | `hello world` | No match → no change |
| 5 | `abc` | `abc` | `***` | Entire string matches |
| 6 | `abcabc` | `a` | `*bc*bc` | Single character match |
| 7 | `abcdef` | `abc` | `***def` | Match at the beginning |
| 8 | `defabc` | `abc` | `def***` | Match at the end |

#### Category 3: Edge Cases

| # | Input | Argument | Expected Output | Description |
|:-:|:------|:---------|:---------------|:---------|
| 9 | `aaa` | `aa` | `**a` | Overlapping pattern — first match from left to right |
| 10 | *(empty)* | `abc` | *(empty)* | Empty input |
| 11 | `a` | `a` | `*` | Single character, exact match |
| 12 | `ab` | `abcdef` | `ab` | Pattern longer than input → no match |
| 13 | `abcabcabc` | `abc` | `*********` | 3 consecutive matches |

#### Category 4: Error Handling (Exit Code)

| # | Arguments | Expected Exit Code | Description |
|:-:|:----------|:------------------:|:---------|
| 14 | *(no argument)* | `1` | Called without arguments |
| 15 | `""` (empty string) | `1` | Empty argument |
| 16 | `"abc" "def"` (2 arguments) | `1` | More than one argument |

---

### Verification Method

**Output tests:**
1. Input is piped to the filter program: `echo "input" | ./filter "arg"`
2. Actual output is compared with expected output via string comparison
3. 5-second timeout

**Exit code tests:**
1. Program is called with invalid arguments
2. Return code (`$?`) is checked — must be `1`

---

### Total Test Count

| Category | Test Count |
|:---------|:----------:|
| Subject examples | 2 |
| Basic tests | 6 |
| Edge cases | 5 |
| Error handling | 3 |
| **Total** | **16** |

---

[⬆ Back to filter](../)

---

# 🇹🇷 Türkçe

## filter — Tester Açıklaması

### Çalıştırma

```bash
bash filter_tester.sh
```

### Nasıl Çalışır?

Tester, `solution/filter.c` dosyasını `-Wall -Wextra -Werror` flag'leri ile derler ve 3 kategori test çalıştırır.

---

### Test Listesi

#### Kategori 1: Subject Örnekleri

Subject'te verilen resmi örnekler:

| # | Input | Argüman | Beklenen Çıktı | Açıklama |
|:-:|:------|:--------|:---------------|:---------|
| 1 | `abcdefaaaabcdeabcabcdabc` | `abc` | `***defaaa***de******d***` | Birden fazla eşleşme, farklı pozisyonlarda |
| 2 | `ababcabababc` | `ababc` | `*****ab*****` | Örtüşen pattern — ilk eşleşme öncelikli |

#### Kategori 2: Temel Testler

| # | Input | Argüman | Beklenen Çıktı | Açıklama |
|:-:|:------|:--------|:---------------|:---------|
| 3 | `hello world` | `world` | `hello *****` | Sonda basit eşleşme |
| 4 | `hello world` | `xyz` | `hello world` | Hiç eşleşme yok → değişiklik yok |
| 5 | `abc` | `abc` | `***` | Tüm string eşleşme |
| 6 | `abcabc` | `a` | `*bc*bc` | Tek karakter eşleşme |
| 7 | `abcdef` | `abc` | `***def` | Başta eşleşme |
| 8 | `defabc` | `abc` | `def***` | Sonda eşleşme |

#### Kategori 3: Edge Case'ler

| # | Input | Argüman | Beklenen Çıktı | Açıklama |
|:-:|:------|:--------|:---------------|:---------|
| 9 | `aaa` | `aa` | `**a` | Örtüşen pattern — soldan sağa ilk eşleşme alınır |
| 10 | *(boş)* | `abc` | *(boş)* | Boş input |
| 11 | `a` | `a` | `*` | Tek karakter, tam eşleşme |
| 12 | `ab` | `abcdef` | `ab` | Pattern input'tan uzun → eşleşme yok |
| 13 | `abcabcabc` | `abc` | `*********` | Arka arkaya 3 eşleşme |

#### Kategori 4: Hata Yönetimi (Exit Code)

| # | Argümanlar | Beklenen Exit Code | Açıklama |
|:-:|:-----------|:------------------:|:---------|
| 14 | *(argüman yok)* | `1` | Argümansız çağrı |
| 15 | `""` (boş string) | `1` | Boş argüman |
| 16 | `"abc" "def"` (2 argüman) | `1` | Birden fazla argüman |

---

### Doğrulama Yöntemi

**Çıktı testleri:**
1. Input, pipe ile filter programına gönderilir: `echo "input" | ./filter "arg"`
2. Gerçek çıktı ile beklenen çıktı string karşılaştırması yapılır
3. 5 saniye timeout

**Exit code testleri:**
1. Program hatalı argümanlarla çağrılır
2. Dönüş kodu (`$?`) kontrol edilir — `1` olmalı

---

### Toplam Test Sayısı

| Kategori | Test Sayısı |
|:---------|:----------:|
| Subject örnekleri | 2 |
| Temel testler | 6 |
| Edge case'ler | 5 |
| Hata yönetimi | 3 |
| **Toplam** | **16** |

---

[⬆ filter ana dizinine dön](../)

---

# 🇫🇷 Français

## filter — Description du testeur

### Exécution

```bash
bash filter_tester.sh
```

### Comment ça marche ?

Le testeur compile `solution/filter.c` avec les flags `-Wall -Wextra -Werror` et exécute 3 catégories de tests.

---

### Liste des tests

#### Catégorie 1 : Exemples du sujet

Exemples officiels donnés dans le sujet :

| # | Input | Argument | Sortie attendue | Description |
|:-:|:------|:---------|:---------------|:---------|
| 1 | `abcdefaaaabcdeabcabcdabc` | `abc` | `***defaaa***de******d***` | Correspondances multiples à différentes positions |
| 2 | `ababcabababc` | `ababc` | `*****ab*****` | Pattern chevauchant — la première correspondance est prioritaire |

#### Catégorie 2 : Tests de base

| # | Input | Argument | Sortie attendue | Description |
|:-:|:------|:---------|:---------------|:---------|
| 3 | `hello world` | `world` | `hello *****` | Correspondance simple à la fin |
| 4 | `hello world` | `xyz` | `hello world` | Aucune correspondance → pas de changement |
| 5 | `abc` | `abc` | `***` | La chaîne entière correspond |
| 6 | `abcabc` | `a` | `*bc*bc` | Correspondance d'un seul caractère |
| 7 | `abcdef` | `abc` | `***def` | Correspondance au début |
| 8 | `defabc` | `abc` | `def***` | Correspondance à la fin |

#### Catégorie 3 : Cas limites

| # | Input | Argument | Sortie attendue | Description |
|:-:|:------|:---------|:---------------|:---------|
| 9 | `aaa` | `aa` | `**a` | Pattern chevauchant — première correspondance de gauche à droite |
| 10 | *(vide)* | `abc` | *(vide)* | Input vide |
| 11 | `a` | `a` | `*` | Un seul caractère, correspondance exacte |
| 12 | `ab` | `abcdef` | `ab` | Pattern plus long que l'input → pas de correspondance |
| 13 | `abcabcabc` | `abc` | `*********` | 3 correspondances consécutives |

#### Catégorie 4 : Gestion des erreurs (Exit Code)

| # | Arguments | Exit Code attendu | Description |
|:-:|:----------|:------------------:|:---------|
| 14 | *(pas d'argument)* | `1` | Appel sans arguments |
| 15 | `""` (chaîne vide) | `1` | Argument vide |
| 16 | `"abc" "def"` (2 arguments) | `1` | Plus d'un argument |

---

### Méthode de vérification

**Tests de sortie :**
1. L'input est envoyé via pipe au programme filter : `echo "input" | ./filter "arg"`
2. La sortie réelle est comparée à la sortie attendue par comparaison de chaînes
3. Timeout de 5 secondes

**Tests de code de sortie :**
1. Le programme est appelé avec des arguments invalides
2. Le code de retour (`$?`) est vérifié — doit être `1`

---

### Nombre total de tests

| Catégorie | Nombre de tests |
|:----------|:----------:|
| Exemples du sujet | 2 |
| Tests de base | 6 |
| Cas limites | 5 |
| Gestion des erreurs | 3 |
| **Total** | **16** |

---

[⬆ Retour à filter](../)
