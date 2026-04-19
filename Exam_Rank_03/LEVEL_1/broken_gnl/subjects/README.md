<p align="center"><a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a></p>

---

# 🇬🇧 English

# broken_gnl — Subject Description

### What Does the Question Ask?

You are given a **broken** `get_next_line` function. Your task is to **fix** this function (and helper functions if necessary).

> Original broken file: [broken_GNL.c](broken_GNL.c)

---

### Concepts You Need to Know

#### 1. File Descriptor (fd)

A file descriptor is an integer that the operating system uses to keep track of open files.

| fd | Meaning |
|:--:|:--------|
| 0  | stdin (standard input) |
| 1  | stdout (standard output) |
| 2  | stderr (error output) |
| 3+ | Files opened with `open()` |

```c
int fd = open("dosya.txt", O_RDONLY); // fd genellikle 3 döner
```

#### 2. `read()` Function

```c
ssize_t read(int fd, void *buf, size_t count);
```

| Parameter | Description |
|:----------|:------------|
| `fd` | File descriptor to read from |
| `buf` | Buffer where read data will be written |
| `count` | Maximum number of bytes to read |
| **Return** | Number of bytes read, 0 = EOF, -1 = error |

#### 3. Static Variables

`static` variables retain their values between function calls. In GNL, they are used to store remaining data for the next call.

```c
char *get_next_line(int fd)
{
    static char buffer[BUFFER_SIZE + 1] = ""; // değerini korur
    // ...
}
```

#### 4. BUFFER_SIZE

Defined at compile time with the `-D BUFFER_SIZE=xx` flag. Determines how many bytes will be read in each `read()` call.

```bash
cc -D BUFFER_SIZE=42 get_next_line.c main.c
```

#### 5. Memory Management

- Every returned line must be allocated with `malloc` and freeable by the caller
- When EOF is reached, no `malloc` memory should remain except the returned line
- On error, it must return `NULL` with no memory leaks

---

### Function Roles

| Function | What It Does | Why It's Needed |
|:---------|:-------------|:----------------|
| `ft_strchr` | Searches for a specific character in a string | Checks whether `\n` exists in the buffer |
| `ft_strlen` | Calculates string length | For memory copy and allocation sizes |
| `ft_memcpy` | Copies n bytes in memory | To merge buffer data |
| `ft_memmove` | Safely copies overlapping memory regions | To remove the read portion from the buffer |
| `str_append_mem` | Appends n bytes to an existing string (realloc logic) | To concatenate lines read in chunks |
| `get_next_line` | Reads and returns one line from fd | Main function |

---

### Allowed Functions

```
read, free, malloc
```

---

### Possible Bugs

Typical bugs you may encounter during the exam:

- `ft_strchr`: Missing NULL check, comparison error with `\0`
- `ft_memcpy`: Index start or direction error (end-to-start vs start-to-end)
- `ft_strlen`: Missing NULL pointer check
- `ft_memmove`: Wrong direction check (overlap case)
- `get_next_line`: Missing EOF check, buffer clearing error, memory leak

> **Tip**: When reading the broken code, test each function individually. Write a simple `main()` to find out which function is behaving incorrectly.

---

[⬆ Back to broken_gnl](../) · [⬆ Level 1](../../)

---

# 🇹🇷 Türkçe

# broken_gnl — Subject Açıklaması

### Soru Ne İstiyor?

Sana **bozuk** bir `get_next_line` fonksiyonu veriliyor. Görevin bu fonksiyonu (ve gerekirse yardımcı fonksiyonları) **tamir etmek**.

> Orijinal bozuk dosya: [broken_GNL.c](broken_GNL.c)

---

### Bilmen Gereken Kavramlar

#### 1. File Descriptor (fd)

File descriptor, işletim sisteminin açık dosyaları takip etmek için kullandığı bir tamsayıdır.

| fd | Anlamı |
|:--:|:-------|
| 0  | stdin (standart giriş) |
| 1  | stdout (standart çıkış) |
| 2  | stderr (hata çıkışı) |
| 3+ | `open()` ile açılan dosyalar |

```c
int fd = open("dosya.txt", O_RDONLY); // fd genellikle 3 döner
```

#### 2. `read()` Fonksiyonu

```c
ssize_t read(int fd, void *buf, size_t count);
```

| Parametre | Açıklama |
|:----------|:---------|
| `fd` | Okunacak dosya tanımlayıcısı |
| `buf` | Okunan verinin yazılacağı buffer |
| `count` | Maximum okunacak byte sayısı |
| **Dönüş** | Okunan byte sayısı, 0 = EOF, -1 = hata |

#### 3. Static Variables

`static` değişkenler fonksiyon çağrıları arasında değerlerini korur. GNL'de bir sonraki çağrıda kalan veriyi saklamak için kullanılır.

```c
char *get_next_line(int fd)
{
    static char buffer[BUFFER_SIZE + 1] = ""; // değerini korur
    // ...
}
```

#### 4. BUFFER_SIZE

Derleme sırasında `-D BUFFER_SIZE=xx` flag'i ile belirlenir. `read()` çağrısında kaç byte okunacağını belirler.

```bash
cc -D BUFFER_SIZE=42 get_next_line.c main.c
```

#### 5. Bellek Yönetimi

- Döndürülen her satır `malloc` ile ayrılmalı ve çağıran tarafından `free` edilebilir olmalı
- EOF'a ulaşıldığında, döndürülen satır dışında hiçbir `malloc` belleği kalmamalı
- Hata durumunda `NULL` dönmeli ve bellek sızıntısı olmamalı

---

### Fonksiyonların İşlevleri

| Fonksiyon | Ne Yapar | Neden Gerekli |
|:----------|:---------|:--------------|
| `ft_strchr` | Bir karakter dizisinde belirli bir karakter arar | Buffer'da `\n` olup olmadığını kontrol eder |
| `ft_strlen` | String uzunluğu hesaplar | Bellek kopyalama ve ayırma boyutları için |
| `ft_memcpy` | Bellekte n byte kopyalar | Buffer verilerini birleştirmek için |
| `ft_memmove` | Örtüşen bellek bölgelerini güvenli kopyalar | Buffer'dan okunan kısmı silmek için |
| `str_append_mem` | Mevcut string'e n byte ekler (realloc mantığı) | Parça parça okunan satırları birleştirmek için |
| `get_next_line` | fd'den bir satır okur ve döndürür | Ana fonksiyon |

---

### İzin Verilen Fonksiyonlar

```
read, free, malloc
```

---

### Olası Hatalar (Bozuk Olan Yerler)

Sınav sırasında karşılaşabileceğin tipik hatalar:

- `ft_strchr`: NULL kontrolü eksik, `\0` ile karşılaştırma hatası
- `ft_memcpy`: Index başlangıcı veya yön hatası (sondan başa vs baştan sona)
- `ft_strlen`: NULL pointer kontrolü eksik
- `ft_memmove`: Yön kontrolü yanlış (overlap durumu)
- `get_next_line`: EOF kontrolü eksik, buffer temizleme hatası, bellek sızıntısı

> **İpucu**: Bozuk kodu okurken her fonksiyonu tek tek test et. Basit bir `main()` yazarak hangi fonksiyonun yanlış çalıştığını bul.

---

[⬆ broken_gnl ana dizinine dön](../) · [⬆ Level 1](../../)

---

# 🇫🇷 Français

# broken_gnl — Description du sujet

### Que demande la question ?

On vous donne une fonction `get_next_line` **cassée**. Votre tâche est de **réparer** cette fonction (et les fonctions auxiliaires si nécessaire).

> Fichier cassé original : [broken_GNL.c](broken_GNL.c)

---

### Concepts à connaître

#### 1. File Descriptor (fd)

Un file descriptor est un entier que le système d'exploitation utilise pour suivre les fichiers ouverts.

| fd | Signification |
|:--:|:--------------|
| 0  | stdin (entrée standard) |
| 1  | stdout (sortie standard) |
| 2  | stderr (sortie d'erreur) |
| 3+ | Fichiers ouverts avec `open()` |

```c
int fd = open("dosya.txt", O_RDONLY); // fd genellikle 3 döner
```

#### 2. Fonction `read()`

```c
ssize_t read(int fd, void *buf, size_t count);
```

| Paramètre | Description |
|:----------|:------------|
| `fd` | Descripteur de fichier à lire |
| `buf` | Buffer où les données lues seront écrites |
| `count` | Nombre maximum d'octets à lire |
| **Retour** | Nombre d'octets lus, 0 = EOF, -1 = erreur |

#### 3. Variables statiques

Les variables `static` conservent leurs valeurs entre les appels de fonction. Dans GNL, elles sont utilisées pour stocker les données restantes pour le prochain appel.

```c
char *get_next_line(int fd)
{
    static char buffer[BUFFER_SIZE + 1] = ""; // değerini korur
    // ...
}
```

#### 4. BUFFER_SIZE

Défini à la compilation avec le flag `-D BUFFER_SIZE=xx`. Détermine combien d'octets seront lus à chaque appel de `read()`.

```bash
cc -D BUFFER_SIZE=42 get_next_line.c main.c
```

#### 5. Gestion de la mémoire

- Chaque ligne retournée doit être allouée avec `malloc` et libérable par l'appelant
- Lorsque EOF est atteint, aucune mémoire `malloc` ne doit rester sauf la ligne retournée
- En cas d'erreur, la fonction doit retourner `NULL` sans fuite de mémoire

---

### Rôles des fonctions

| Fonction | Ce qu'elle fait | Pourquoi elle est nécessaire |
|:---------|:----------------|:-----------------------------|
| `ft_strchr` | Recherche un caractère spécifique dans une chaîne | Vérifie si `\n` existe dans le buffer |
| `ft_strlen` | Calcule la longueur d'une chaîne | Pour les tailles de copie et d'allocation mémoire |
| `ft_memcpy` | Copie n octets en mémoire | Pour fusionner les données du buffer |
| `ft_memmove` | Copie en toute sécurité des régions mémoire qui se chevauchent | Pour supprimer la partie lue du buffer |
| `str_append_mem` | Ajoute n octets à une chaîne existante (logique realloc) | Pour concaténer les lignes lues par morceaux |
| `get_next_line` | Lit et retourne une ligne depuis fd | Fonction principale |

---

### Fonctions autorisées

```
read, free, malloc
```

---

### Bugs possibles

Bugs typiques que vous pourriez rencontrer pendant l'examen :

- `ft_strchr` : Vérification NULL manquante, erreur de comparaison avec `\0`
- `ft_memcpy` : Erreur d'index de départ ou de direction (fin vers début vs début vers fin)
- `ft_strlen` : Vérification du pointeur NULL manquante
- `ft_memmove` : Vérification de direction incorrecte (cas de chevauchement)
- `get_next_line` : Vérification EOF manquante, erreur de nettoyage du buffer, fuite de mémoire

> **Conseil** : En lisant le code cassé, testez chaque fonction individuellement. Écrivez un simple `main()` pour trouver quelle fonction se comporte incorrectement.

---

[⬆ Retour à broken_gnl](../) · [⬆ Level 1](../../)
