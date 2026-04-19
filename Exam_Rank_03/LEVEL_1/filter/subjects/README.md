<p align="center">
  <a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a>
</p>

---

# 🇬🇧 English

## filter — Subject Description

### What Does the Question Ask?

Write a program that replaces every occurrence of a specific word in text read from `stdin` with `*` characters of the same length.

```bash
echo "Hello World Hello" | ./filter Hello
# Output: ***** World *****
```

> The program should behave like `sed 's/word/****/g'`.

---

### Concepts You Need to Know

#### 1. Reading from stdin

The program reads from **standard input** (stdin, fd=0) instead of a file. Data is received via pipe (`|`) or redirection (`<`).

```c
int ret = read(0, buffer, 1023); // 0 = stdin
```

> **Note**: `read` may return a different amount of data on each call. The buffer size is randomly changed during testing.

#### 2. String Matching (Pattern Matching)

Searching for a substring within a string:

```c
// Search for "cde" in "abcdefg"
// Found at position 2 → write '*' from that position
```

The allowed function `memmem` can be used for this:

```c
#define _GNU_SOURCE
#include <string.h>

void *memmem(const void *haystack, size_t haystacklen,
             const void *needle, size_t needlelen);
```

Alternatively, comparison can be done with `ft_strncmp` without using `memmem`.

#### 3. Buffer Management

`read` may return different sizes of data each time. This is an important detail:

```
read call 1: "abc"
read call 2: "defabc"
read call 3: "xyz"
```

The word may span buffer boundaries! (like `"ab" | "cdef"`)

#### 4. Error Handling

| Case | Behavior |
|:-----|:---------|
| No argument | `return 1` |
| Empty argument (`""`) | `return 1` |
| More than one argument | `return 1` |
| `read` error | Write "Error: " + error message to stderr, `return 1` |
| `malloc` error | Write "Error: " + error message to stderr, `return 1` |

---

### Allowed Functions

| Function | Where Used |
|:---------|:----------|
| `read` | Reading data from stdin |
| `write` | Writing output to stdout |
| `strlen` | Calculating string length |
| `memmem` | Searching for a substring within a buffer |
| `memmove` | Safely copying buffer contents |
| `malloc` / `calloc` / `realloc` / `free` | Dynamic memory management |
| `printf` / `fprintf` | Formatted output |
| `perror` | Printing error messages |

---

### Example Usage

```bash
# Basic usage
echo 'abcdefaaaabcdeabcabcdabc' | ./filter abc | cat -e
# Output: ***defaaa***de******d***$

# Overlapping pattern
echo 'ababcabababc' | ./filter ababc | cat -e
# Output: *****ab*****$

# Comparison with filter.sh
echo 'test' | ./filter test    # → ****
echo 'test' | bash filter.sh test  # → same result
```

---

### Tips

1. **Write the simple version first**: Write a version that works without buffer issues
2. **`memmove` + `memmem`** combination makes your job much easier
3. **Edge case**: The argument itself can be an empty string → check for it
4. **`perror` usage**: Requires `#include <errno.h>`

---

[⬆ Back to filter](../) · [⬆ Level 1](../../)

---

# 🇹🇷 Türkçe

## filter — Subject Açıklaması

### Soru Ne İstiyor?

`stdin`'den okunan metindeki belirli bir kelimenin her geçtiği yeri aynı uzunlukta `*` karakterleri ile değiştiren bir program yaz.

```bash
echo "Hello World Hello" | ./filter Hello
# Çıktı: ***** World *****
```

> Programın `sed 's/kelime/****/g'` komutuyla aynı davranışı göstermeli.

---

### Bilmen Gereken Kavramlar

#### 1. stdin'den Okuma

Program dosya yerine **standart girişten** (stdin, fd=0) okur. Pipe (`|`) veya yönlendirme (`<`) ile veri alır.

```c
int ret = read(0, buffer, 1023); // 0 = stdin
```

> **Dikkat**: `read` her çağrıda farklı miktarda veri döndürebilir. Buffer boyutu test sırasında rastgele değiştirilir.

#### 2. String Eşleştirme (Pattern Matching)

Bir string içinde alt string aramak:

```c
// "abcdefg" içinde "cde" ara
// Pozisyon 2'de bulunur → o pozisyondan itibaren '*' yaz
```

İzin verilen fonksiyonlardan `memmem` bu iş için kullanılabilir:

```c
#define _GNU_SOURCE
#include <string.h>

void *memmem(const void *haystack, size_t haystacklen,
             const void *needle, size_t needlelen);
```

Ancak `memmem` kullanmadan da `ft_strncmp` ile karşılaştırma yapılabilir.

#### 3. Buffer Yönetimi

`read` her seferinde farklı boyutta veri döndürebilir. Bu önemli bir detay:

```
read çağrısı 1: "abc"
read çağrısı 2: "defabc"
read çağrısı 3: "xyz"
```

Kelime buffer sınırlarına denk gelebilir! (`"ab" | "cdef"` gibi)

#### 4. Hata Yönetimi

| Durum | Davranış |
|:------|:---------|
| Argüman yok | `return 1` |
| Boş argüman (`""`) | `return 1` |
| Birden fazla argüman | `return 1` |
| `read` hatası | stderr'e "Error: " + hata mesajı yaz, `return 1` |
| `malloc` hatası | stderr'e "Error: " + hata mesajı yaz, `return 1` |

---

### İzin Verilen Fonksiyonlar

| Fonksiyon | Nerede Kullanılır |
|:----------|:-----------------|
| `read` | stdin'den veri okuma |
| `write` | stdout'a çıktı yazma |
| `strlen` | String uzunluğu hesaplama |
| `memmem` | Bir buffer içinde alt string arama |
| `memmove` | Buffer içeriğini güvenli kopyalama |
| `malloc` / `calloc` / `realloc` / `free` | Dinamik bellek yönetimi |
| `printf` / `fprintf` | Formatlı çıktı |
| `perror` | Hata mesajı yazdırma |

---

### Örnek Çalışma

```bash
# Temel kullanım
echo 'abcdefaaaabcdeabcabcdabc' | ./filter abc | cat -e
# Çıktı: ***defaaa***de******d***$

# Örtüşen pattern
echo 'ababcabababc' | ./filter ababc | cat -e
# Çıktı: *****ab*****$

# filter.sh ile karşılaştırma
echo 'test' | ./filter test    # → ****
echo 'test' | bash filter.sh test  # → aynı sonuç
```

---

### İpuçları

1. **Önce basit hali yaz**: Buffer sorunu olmadan çalışan bir versiyon yaz
2. **`memmove` + `memmem`** kombinasyonu işini çok kolaylaştırır
3. **Edge case**: Argümanın kendisi boş string olabilir → kontrol et
4. **`perror` kullanımı**: `#include <errno.h>` gerektirir

---

[⬆ filter ana dizinine dön](../) · [⬆ Level 1](../../)

---

# 🇫🇷 Français

## filter — Description du sujet

### Que demande la question ?

Écrire un programme qui remplace chaque occurrence d'un mot spécifique dans le texte lu depuis `stdin` par des caractères `*` de même longueur.

```bash
echo "Hello World Hello" | ./filter Hello
# Sortie: ***** World *****
```

> Le programme doit se comporter comme `sed 's/mot/****/g'`.

---

### Concepts à connaître

#### 1. Lecture depuis stdin

Le programme lit depuis **l'entrée standard** (stdin, fd=0) au lieu d'un fichier. Les données sont reçues via un pipe (`|`) ou une redirection (`<`).

```c
int ret = read(0, buffer, 1023); // 0 = stdin
```

> **Attention** : `read` peut renvoyer une quantité différente de données à chaque appel. La taille du buffer est modifiée aléatoirement pendant les tests.

#### 2. Correspondance de chaînes (Pattern Matching)

Rechercher une sous-chaîne dans une chaîne :

```c
// Chercher "cde" dans "abcdefg"
// Trouvé à la position 2 → écrire '*' à partir de cette position
```

La fonction autorisée `memmem` peut être utilisée pour cela :

```c
#define _GNU_SOURCE
#include <string.h>

void *memmem(const void *haystack, size_t haystacklen,
             const void *needle, size_t needlelen);
```

Alternativement, la comparaison peut être faite avec `ft_strncmp` sans utiliser `memmem`.

#### 3. Gestion du buffer

`read` peut renvoyer des tailles de données différentes à chaque fois. C'est un détail important :

```
read appel 1: "abc"
read appel 2: "defabc"
read appel 3: "xyz"
```

Le mot peut chevaucher les limites du buffer ! (comme `"ab" | "cdef"`)

#### 4. Gestion des erreurs

| Cas | Comportement |
|:----|:-------------|
| Pas d'argument | `return 1` |
| Argument vide (`""`) | `return 1` |
| Plus d'un argument | `return 1` |
| Erreur `read` | Écrire "Error: " + message d'erreur sur stderr, `return 1` |
| Erreur `malloc` | Écrire "Error: " + message d'erreur sur stderr, `return 1` |

---

### Fonctions autorisées

| Fonction | Utilisation |
|:---------|:-----------|
| `read` | Lecture des données depuis stdin |
| `write` | Écriture de la sortie sur stdout |
| `strlen` | Calcul de la longueur d'une chaîne |
| `memmem` | Recherche d'une sous-chaîne dans un buffer |
| `memmove` | Copie sécurisée du contenu d'un buffer |
| `malloc` / `calloc` / `realloc` / `free` | Gestion dynamique de la mémoire |
| `printf` / `fprintf` | Sortie formatée |
| `perror` | Affichage des messages d'erreur |

---

### Exemple d'utilisation

```bash
# Utilisation de base
echo 'abcdefaaaabcdeabcabcdabc' | ./filter abc | cat -e
# Sortie: ***defaaa***de******d***$

# Pattern chevauchant
echo 'ababcabababc' | ./filter ababc | cat -e
# Sortie: *****ab*****$

# Comparaison avec filter.sh
echo 'test' | ./filter test    # → ****
echo 'test' | bash filter.sh test  # → même résultat
```

---

### Conseils

1. **Écrivez d'abord la version simple** : Écrivez une version qui fonctionne sans problèmes de buffer
2. **La combinaison `memmove` + `memmem`** facilite beaucoup le travail
3. **Cas limite** : L'argument lui-même peut être une chaîne vide → vérifiez-le
4. **Utilisation de `perror`** : Nécessite `#include <errno.h>`

---

[⬆ Retour à filter](../) · [⬆ Level 1](../../)
