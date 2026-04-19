<p align="center"><a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a></p>

---

# 🇬🇧 English

# broken_gnl — Tester Description

### How to Run

```bash
bash broken_gnl_tester.sh
```

### How Does It Work?

The tester tests both solutions in the `solution/sol_1/` and `solution/sol_2/` directories.
Each solution is compiled with **4 different BUFFER_SIZE** values and the same tests are repeated:

| BUFFER_SIZE | Purpose |
|:-----------:|:--------|
| `1` | Character-by-character reading — slowest but most stressful case |
| `42` | Medium buffer — typical usage |
| `1024` | Default header value — normal usage |
| `9999` | Very large buffer — can read the entire file at once |

---

### Test List

The following **9 tests** are run for each BUFFER_SIZE (2 solutions × 4 buffers = **72 tests** total):

#### Test 1: Single line
| | |
|:--|:--|
| **File content** | `Hello World\n` |
| **Expected output** | `Hello World` (including newline) |
| **What it tests** | Simple single-line file reading |

#### Test 2: Multiple lines
| | |
|:--|:--|
| **File content** | `Line 1\nLine 2\nLine 3\n` |
| **Expected output** | All 3 lines printed in order |
| **What it tests** | Reading multiple lines in the correct order |

#### Test 3: No trailing newline (EOF)
| | |
|:--|:--|
| **File content** | `No newline at end` (no `\n` at the end) |
| **Expected output** | `No newline at end` |
| **What it tests** | Correct return of the last line not ending with `\n` |

#### Test 4: Empty file
| | |
|:--|:--|
| **File content** | *(empty)* |
| **Expected output** | *(empty — no lines returned)* |
| **What it tests** | Returning `NULL` on empty file, no memory leaks |

#### Test 5: Long line (10000 chars)
| | |
|:--|:--|
| **File content** | 10000 `A` characters + `\n` |
| **Expected output** | 10000 `A` characters and newline |
| **What it tests** | Correct concatenation of lines much larger than BUFFER_SIZE |

#### Test 6: Multiple empty lines
| | |
|:--|:--|
| **File content** | `\n\n\n` (3 empty lines) |
| **Expected output** | 3 empty lines (each containing only `\n`) |
| **What it tests** | Correct handling of lines containing only `\n` |

#### Test 7: Mixed content
| | |
|:--|:--|
| **File content** | `Hello\n\nWorld\n\n42\n` |
| **Expected output** | `Hello`, empty line, `World`, empty line, `42` |
| **What it tests** | Mixed empty and non-empty lines |

#### Test 8: Single character lines
| | |
|:--|:--|
| **File content** | `a\nb\nc\n` |
| **Expected output** | `a`, `b`, `c` (each on a separate line) |
| **What it tests** | Buffer management with very short lines |

#### Test 9: Single newline
| | |
|:--|:--|
| **File content** | `\n` (a single newline) |
| **Expected output** | Single empty line |
| **What it tests** | Minimum-length valid line |

---

### Compilation

The tester compiles with the following command for each BUFFER_SIZE:

```bash
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=<n> main_test.c get_next_line.c -o gnl_test
```

If compilation fails, that BUFFER_SIZE group is counted as **FAIL**.

---

### Verification Method

For each test:
1. The test file is read with `cat` → **expected output**
2. The same file is read with `get_next_line` → **actual output**
3. They are compared — if equal **PASS**, otherwise **FAIL**
4. 5-second timeout — infinite loop protection

---

[⬆ Back to broken_gnl](../)

---

# 🇹🇷 Türkçe

# broken_gnl — Tester Açıklaması

### Çalıştırma

```bash
bash broken_gnl_tester.sh
```

### Nasıl Çalışır?

Tester, `solution/sol_1/` ve `solution/sol_2/` dizinlerindeki her iki çözümü de test eder.
Her çözüm **4 farklı BUFFER_SIZE** ile derlenir ve aynı testler tekrarlanır:

| BUFFER_SIZE | Amacı |
|:-----------:|:------|
| `1` | Karakter karakter okuma — en yavaş ama en stresli durum |
| `42` | Orta boy buffer — tipik kullanım |
| `1024` | Varsayılan header değeri — normal kullanım |
| `9999` | Çok büyük buffer — tüm dosyayı tek seferde okuyabilir |

---

### Test Listesi

Her BUFFER_SIZE için aşağıdaki **9 test** çalıştırılır (2 çözüm × 4 buffer = toplam **72 test**):

#### Test 1: Single line
| | |
|:--|:--|
| **Dosya içeriği** | `Hello World\n` |
| **Beklenen çıktı** | `Hello World` (newline dahil) |
| **Ne test eder** | Tek satırlık basit dosya okuma |

#### Test 2: Multiple lines
| | |
|:--|:--|
| **Dosya içeriği** | `Line 1\nLine 2\nLine 3\n` |
| **Beklenen çıktı** | 3 satırın tamamı sırayla yazdırılır |
| **Ne test eder** | Birden fazla satırı doğru sırada okuma |

#### Test 3: No trailing newline (EOF)
| | |
|:--|:--|
| **Dosya içeriği** | `No newline at end` (sonunda `\n` yok) |
| **Beklenen çıktı** | `No newline at end` |
| **Ne test eder** | `\n` ile bitmeyen son satırın doğru döndürülmesi |

#### Test 4: Empty file
| | |
|:--|:--|
| **Dosya içeriği** | *(boş)* |
| **Beklenen çıktı** | *(boş — hiçbir satır döndürülmez)* |
| **Ne test eder** | Boş dosyada `NULL` dönmesi, bellek sızıntısı olmaması |

#### Test 5: Long line (10000 chars)
| | |
|:--|:--|
| **Dosya içeriği** | 10000 adet `A` karakteri + `\n` |
| **Beklenen çıktı** | 10000 adet `A` ve newline |
| **Ne test eder** | BUFFER_SIZE'dan çok büyük satırların doğru birleştirilmesi |

#### Test 6: Multiple empty lines
| | |
|:--|:--|
| **Dosya içeriği** | `\n\n\n` (3 boş satır) |
| **Beklenen çıktı** | 3 adet boş satır (her biri sadece `\n`) |
| **Ne test eder** | Sadece `\n` içeren satırların doğru işlenmesi |

#### Test 7: Mixed content
| | |
|:--|:--|
| **Dosya içeriği** | `Hello\n\nWorld\n\n42\n` |
| **Beklenen çıktı** | `Hello`, boş satır, `World`, boş satır, `42` |
| **Ne test eder** | Boş ve dolu satırların karışık gelmesi |

#### Test 8: Single character lines
| | |
|:--|:--|
| **Dosya içeriği** | `a\nb\nc\n` |
| **Beklenen çıktı** | `a`, `b`, `c` (her biri ayrı satırda) |
| **Ne test eder** | Çok kısa satırların buffer yönetimi |

#### Test 9: Single newline
| | |
|:--|:--|
| **Dosya içeriği** | `\n` (tek bir newline) |
| **Beklenen çıktı** | Tek boş satır |
| **Ne test eder** | Minimum uzunlukta geçerli satır |

---

### Derleme

Tester, her BUFFER_SIZE için şu komutla derler:

```bash
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=<n> main_test.c get_next_line.c -o gnl_test
```

Derleme başarısız olursa o BUFFER_SIZE grubu **FAIL** sayılır.

---

### Doğrulama Yöntemi

Her test için:
1. Test dosyası `cat` ile okunur → **beklenen çıktı**
2. Aynı dosya `get_next_line` ile okunur → **gerçek çıktı**
3. İkisi karşılaştırılır — eşitse **PASS**, değilse **FAIL**
4. 5 saniye timeout — sonsuz döngü koruması

---

[⬆ broken_gnl ana dizinine dön](../)

---

# 🇫🇷 Français

# broken_gnl — Description du testeur

### Exécution

```bash
bash broken_gnl_tester.sh
```

### Comment ça marche ?

Le testeur teste les deux solutions dans les répertoires `solution/sol_1/` et `solution/sol_2/`.
Chaque solution est compilée avec **4 valeurs BUFFER_SIZE différentes** et les mêmes tests sont répétés :

| BUFFER_SIZE | Objectif |
|:-----------:|:---------|
| `1` | Lecture caractère par caractère — le plus lent mais le cas le plus stressant |
| `42` | Buffer moyen — utilisation typique |
| `1024` | Valeur par défaut du header — utilisation normale |
| `9999` | Très grand buffer — peut lire tout le fichier en une fois |

---

### Liste des tests

Les **9 tests** suivants sont exécutés pour chaque BUFFER_SIZE (2 solutions × 4 buffers = **72 tests** au total) :

#### Test 1 : Single line
| | |
|:--|:--|
| **Contenu du fichier** | `Hello World\n` |
| **Sortie attendue** | `Hello World` (newline inclus) |
| **Ce que ça teste** | Lecture simple d'un fichier d'une seule ligne |

#### Test 2 : Multiple lines
| | |
|:--|:--|
| **Contenu du fichier** | `Line 1\nLine 2\nLine 3\n` |
| **Sortie attendue** | Les 3 lignes affichées dans l'ordre |
| **Ce que ça teste** | Lecture de plusieurs lignes dans le bon ordre |

#### Test 3 : No trailing newline (EOF)
| | |
|:--|:--|
| **Contenu du fichier** | `No newline at end` (pas de `\n` à la fin) |
| **Sortie attendue** | `No newline at end` |
| **Ce que ça teste** | Retour correct de la dernière ligne ne se terminant pas par `\n` |

#### Test 4 : Empty file
| | |
|:--|:--|
| **Contenu du fichier** | *(vide)* |
| **Sortie attendue** | *(vide — aucune ligne retournée)* |
| **Ce que ça teste** | Retour de `NULL` sur un fichier vide, pas de fuite mémoire |

#### Test 5 : Long line (10000 chars)
| | |
|:--|:--|
| **Contenu du fichier** | 10000 caractères `A` + `\n` |
| **Sortie attendue** | 10000 caractères `A` et newline |
| **Ce que ça teste** | Concaténation correcte des lignes beaucoup plus grandes que BUFFER_SIZE |

#### Test 6 : Multiple empty lines
| | |
|:--|:--|
| **Contenu du fichier** | `\n\n\n` (3 lignes vides) |
| **Sortie attendue** | 3 lignes vides (chacune contenant uniquement `\n`) |
| **Ce que ça teste** | Traitement correct des lignes contenant uniquement `\n` |

#### Test 7 : Mixed content
| | |
|:--|:--|
| **Contenu du fichier** | `Hello\n\nWorld\n\n42\n` |
| **Sortie attendue** | `Hello`, ligne vide, `World`, ligne vide, `42` |
| **Ce que ça teste** | Mélange de lignes vides et non-vides |

#### Test 8 : Single character lines
| | |
|:--|:--|
| **Contenu du fichier** | `a\nb\nc\n` |
| **Sortie attendue** | `a`, `b`, `c` (chacun sur une ligne séparée) |
| **Ce que ça teste** | Gestion du buffer avec des lignes très courtes |

#### Test 9 : Single newline
| | |
|:--|:--|
| **Contenu du fichier** | `\n` (un seul newline) |
| **Sortie attendue** | Une seule ligne vide |
| **Ce que ça teste** | Ligne valide de longueur minimale |

---

### Compilation

Le testeur compile avec la commande suivante pour chaque BUFFER_SIZE :

```bash
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=<n> main_test.c get_next_line.c -o gnl_test
```

Si la compilation échoue, ce groupe BUFFER_SIZE est compté comme **FAIL**.

---

### Méthode de vérification

Pour chaque test :
1. Le fichier de test est lu avec `cat` → **sortie attendue**
2. Le même fichier est lu avec `get_next_line` → **sortie réelle**
3. Les deux sont comparées — si égales **PASS**, sinon **FAIL**
4. Timeout de 5 secondes — protection contre les boucles infinies

---

[⬆ Retour à broken_gnl](../)
