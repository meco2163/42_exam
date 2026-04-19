<p align="center">
  <a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a>
</p>

---

# 🇬🇧 English

## filter — Solution Architecture

### General Approach

The solution consists of two main parts:

1. **`filter(input, arg)`** — Replaces patterns in the string with `*`
2. **`main()`** — Reads from stdin and sends to the `filter` function

---

### Flow Diagram

```
main()
  │
  ├── ac != 2 or av[1] empty? → return 1
  │
  └── while (read(0, std_input, 1023) > 0)
       │
       ├── std_input[ret] = '\0'    ← null-terminate
       │
       ├── result = filter(std_input, av[1])
       │    │
       │    ├── create a copy of input (with memmove)
       │    │
       │    └── check at each position:
       │         │
       │         ├── input[i] == arg[0]?   (first character match)
       │         │    └── ft_strncmp(&input[i], arg, len_arg)?
       │         │         │
       │         │         ├── YES → write '*' for len_arg chars, i += len_arg
       │         │         └── NO  → i++
       │         │
       │         └── Otherwise → i++
       │
       ├── write(1, result, ft_strlen(result))
       │
       └── free(result)
```

---

### Function Details

#### `ft_strlen(char *str)`

Standard `strlen` implementation. Counts until `\0` at the end of the string.

#### `ft_strncmp(char *dst, char *src, size_t len)`

> **Note**: This differs from the standard `strncmp` — it returns **1** on equality (boolean logic).

```c
// Standard strncmp: returns 0 on equality
// This version:     returns 1 on equality (true)
```

#### `filter(char *input, char *arg)`

The actual work happens here:

```
input = "abcXXabcYY"
arg   = "abc"

Step 1: result = "abcXXabcYY"  (copy)
Step 2: i=0  → 'a' == 'a' AND "abc" == "abc" ✓ → "***XXabcYY", i=3
Step 3: i=3  → 'X' != 'a' → i=4
Step 4: i=4  → 'X' != 'a' → i=5
Step 5: i=5  → 'a' == 'a' AND "abc" == "abc" ✓ → "***XX***YY", i=8
Step 6: i=8  → 'Y' != 'a' → i=9
Step 7: i=9  → 'Y' != 'a' → i=10 → done

Result: "***XX***YY"
```

#### Why Do We Write on `result`?

- `input` could be directly `av[1]` — modifying it is dangerous
- It's safe to make a copy with `memmove` and write `*` on the copy

---

### Important Notes

- The solution uses manual comparison (`ft_strncmp`) instead of `memmem`
- The buffer boundary problem is not fully addressed in this solution — in the exam environment, the entire input is usually small enough to be read at once
- The `printf("%d", ret)` line is for debugging purposes and should be removed in the exam solution

---

[⬆ Back to filter](../) · [⬆ Level 1](../../)

---

# 🇹🇷 Türkçe

## filter — Çözüm Mimarisi

### Genel Yaklaşım

Çözüm iki ana parçadan oluşur:

1. **`filter(input, arg)`** — String içindeki pattern'leri `*` ile değiştirir
2. **`main()`** — stdin'den okur ve `filter` fonksiyonuna gönderir

---

### Akış Diyagramı

```
main()
  │
  ├── ac != 2 veya av[1] boş? → return 1
  │
  └── while (read(0, std_input, 1023) > 0)
       │
       ├── std_input[ret] = '\0'    ← null-terminate
       │
       ├── result = filter(std_input, av[1])
       │    │
       │    ├── input'un kopyasını oluştur (memmove ile)
       │    │
       │    └── her pozisyonda kontrol:
       │         │
       │         ├── input[i] == arg[0]?   (ilk karakter eşleşmesi)
       │         │    └── ft_strncmp(&input[i], arg, len_arg)?
       │         │         │
       │         │         ├── EVET → len_arg kadar '*' yaz, i += len_arg
       │         │         └── HAYIR → i++
       │         │
       │         └── Değilse → i++
       │
       ├── write(1, result, ft_strlen(result))
       │
       └── free(result)
```

---

### Fonksiyon Detayları

#### `ft_strlen(char *str)`

Standart `strlen` implementasyonu. String sonundaki `\0`'a kadar sayar.

#### `ft_strncmp(char *dst, char *src, size_t len)`

> **Not**: Bu standart `strncmp`'den farklıdır — eşitlik durumunda **1** döner (boolean mantığı).

```c
// Standart strncmp: eşitse 0 döner
// Bu versiyon:      eşitse 1 döner (true)
```

#### `filter(char *input, char *arg)`

Asıl iş burada yapılır:

```
input = "abcXXabcYY"
arg   = "abc"

Adım 1: result = "abcXXabcYY"  (kopyası)
Adım 2: i=0  → 'a' == 'a' VE "abc" == "abc" ✓ → "***XXabcYY", i=3
Adım 3: i=3  → 'X' != 'a' → i=4
Adım 4: i=4  → 'X' != 'a' → i=5
Adım 5: i=5  → 'a' == 'a' VE "abc" == "abc" ✓ → "***XX***YY", i=8
Adım 6: i=8  → 'Y' != 'a' → i=9
Adım 7: i=9  → 'Y' != 'a' → i=10 → bitti

Sonuç: "***XX***YY"
```

#### Neden `result` Üzerinde Yazıyoruz?

- `input` doğrudan `av[1]` olabilir — değiştirmek tehlikeli
- `memmove` ile kopya alıp, kopya üzerinde `*` yazmak güvenli

---

### Önemli Notlar

- Çözümde `memmem` yerine manual karşılaştırma (`ft_strncmp`) kullanılmış
- Buffer sınır problemi bu çözümde tam olarak ele alınmamış — sınav ortamında genellikle tüm input tek seferde okunabilir boyuttadır
- `printf("%d", ret)` satırı debug amaçlıdır, sınav çözümünde kaldırılmalı

---

[⬆ filter ana dizinine dön](../) · [⬆ Level 1](../../)

---

# 🇫🇷 Français

## filter — Architecture de la solution

### Approche générale

La solution se compose de deux parties principales :

1. **`filter(input, arg)`** — Remplace les patterns dans la chaîne par des `*`
2. **`main()`** — Lit depuis stdin et envoie à la fonction `filter`

---

### Diagramme de flux

```
main()
  │
  ├── ac != 2 ou av[1] vide? → return 1
  │
  └── while (read(0, std_input, 1023) > 0)
       │
       ├── std_input[ret] = '\0'    ← null-terminate
       │
       ├── result = filter(std_input, av[1])
       │    │
       │    ├── créer une copie de input (avec memmove)
       │    │
       │    └── vérifier à chaque position :
       │         │
       │         ├── input[i] == arg[0]?   (correspondance du premier caractère)
       │         │    └── ft_strncmp(&input[i], arg, len_arg)?
       │         │         │
       │         │         ├── OUI → écrire '*' pour len_arg caractères, i += len_arg
       │         │         └── NON → i++
       │         │
       │         └── Sinon → i++
       │
       ├── write(1, result, ft_strlen(result))
       │
       └── free(result)
```

---

### Détails des fonctions

#### `ft_strlen(char *str)`

Implémentation standard de `strlen`. Compte jusqu'au `\0` à la fin de la chaîne.

#### `ft_strncmp(char *dst, char *src, size_t len)`

> **Note** : Ceci diffère du `strncmp` standard — il renvoie **1** en cas d'égalité (logique booléenne).

```c
// strncmp standard : renvoie 0 en cas d'égalité
// Cette version :    renvoie 1 en cas d'égalité (true)
```

#### `filter(char *input, char *arg)`

Le travail réel se fait ici :

```
input = "abcXXabcYY"
arg   = "abc"

Étape 1 : result = "abcXXabcYY"  (copie)
Étape 2 : i=0  → 'a' == 'a' ET "abc" == "abc" ✓ → "***XXabcYY", i=3
Étape 3 : i=3  → 'X' != 'a' → i=4
Étape 4 : i=4  → 'X' != 'a' → i=5
Étape 5 : i=5  → 'a' == 'a' ET "abc" == "abc" ✓ → "***XX***YY", i=8
Étape 6 : i=8  → 'Y' != 'a' → i=9
Étape 7 : i=9  → 'Y' != 'a' → i=10 → terminé

Résultat : "***XX***YY"
```

#### Pourquoi écrire sur `result` ?

- `input` pourrait être directement `av[1]` — le modifier est dangereux
- Il est sûr de faire une copie avec `memmove` et d'écrire `*` sur la copie

---

### Notes importantes

- La solution utilise une comparaison manuelle (`ft_strncmp`) au lieu de `memmem`
- Le problème de limite de buffer n'est pas entièrement traité dans cette solution — dans l'environnement d'examen, l'ensemble de l'input est généralement assez petit pour être lu en une seule fois
- La ligne `printf("%d", ret)` est à des fins de débogage et doit être supprimée dans la solution d'examen

---

[⬆ Retour à filter](../) · [⬆ Level 1](../../)
