<p align="center"><a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a></p>

---

# 🇬🇧 English

# broken_gnl — Solution Architecture

This directory contains two different solution approaches for the broken GNL.

---

### Sol 1 — Detailed Solution

📁 [sol_1/](sol_1/)

#### Architecture

```
get_next_line(fd)
    │
    ├── static buffer b[BUFFER_SIZE + 1]  ← çağrılar arası veri saklar
    │
    └── while (1) döngüsü
         │
         ├── ft_strchr(b, '\n') → '\n' bulundu mu?
         │    │
         │    ├── EVET → str_append_mem ile '\n' dahil kopyala
         │    │          ft_memmove ile buffer'ı kaydır → return ret
         │    │
         │    └── HAYIR ↓
         │
         ├── str_append_str(ret, b) → buffer'ı ret'e ekle
         │
         ├── read(fd, b, BUFFER_SIZE) → yeni veri oku
         │    │
         │    ├── <= 0 → EOF veya hata
         │    │    └── ret doluysa return ret, yoksa return NULL
         │    │
         │    └── > 0 → b[read_ret] = '\0', döngüye devam
         │
         └── tekrar başa dön
```

#### Helper Functions

| Function | Role |
|:---------|:-----|
| `ft_strchr(s, c)` | Searches for character `c` in `s`, returns pointer if found |
| `ft_memcpy(dest, src, n)` | Copies `n` bytes from `src` to `dest` |
| `ft_strlen(s)` | NULL-safe string length |
| `str_append_mem(s1, s2, size2)` | Appends `size2` bytes from `s2` to `*s1` (realloc logic) |
| `str_append_str(s1, s2)` | String version of `str_append_mem` |
| `ft_memmove(dest, src, n)` | Overlap-safe memory copy |

#### Flow Example

File content: `"Merhaba\nDünya\n"`, `BUFFER_SIZE=10`

```
1. read → b = "Merhaba\nDü"
2. ft_strchr → '\n' pozisyon 7'de bulundu
3. str_append_mem → ret = "Merhaba\n"
4. ft_memmove → b = "Dü"         (kalan veri korunur)
5. return "Merhaba\n"

Sonraki çağrı:
1. b = "Dü" (static'ten kalan)
2. ft_strchr → '\n' yok
3. str_append_str → ret = "Dü"
4. read → b = "nya\n"
5. ft_strchr → '\n' pozisyon 3'te bulundu
6. str_append_mem → ret = "Dünya\n"
7. return "Dünya\n"
```

#### Memory Safety

- Returns `NULL` on every `malloc` failure
- `str_append_mem` frees old `*s1`
- Buffer is cleared on EOF (`b[0] = '\0'`)
- `(free(ret), NULL)` pattern for single-line cleanup

---

### Sol 2 — Minimal Solution

📁 [sol_2/](sol_2/)

#### Architecture

```
get_next_line(fd)
    │
    ├── static buf[BUFFER_SIZE], ret, pos  ← hepsi static
    │
    └── malloc(10000) → sabit boyut (sınav ortamı için yeterli)
         │
         └── while (1)
              ├── pos >= ret? → read() çağır
              │    └── ret <= 0? → break
              │
              ├── len[i++] = buf[pos++]
              │
              └── len[i-1] == '\n'? → break
```

#### Differences

| Feature | Sol 1 | Sol 2 |
|:--------|:------|:------|
| Memory allocation | Dynamic (grows as needed) | Fixed 10000 bytes |
| Buffer management | Shifting with `ft_memmove` | Tracking with `pos` index |
| Safety | Full memory control | Minimal (exam-focused) |
| Code length | ~120 lines | ~25 lines |
| Approach | Production-ready | Speed-coding |

#### When to Use Which?

- **Sol 1**: If you want to understand the concepts and write safe code
- **Sol 2**: If you want to write fast during the exam (as long as lines don't exceed 10000 characters)

---

[⬆ Back to broken_gnl](../) · [⬆ Level 1](../../)

---

# 🇹🇷 Türkçe

# broken_gnl — Çözüm Mimarisi

Bu dizinde bozuk GNL için iki farklı çözüm yaklaşımı bulunmaktadır.

---

### Sol 1 — Detaylı Çözüm

📁 [sol_1/](sol_1/)

#### Mimari

```
get_next_line(fd)
    │
    ├── static buffer b[BUFFER_SIZE + 1]  ← çağrılar arası veri saklar
    │
    └── while (1) döngüsü
         │
         ├── ft_strchr(b, '\n') → '\n' bulundu mu?
         │    │
         │    ├── EVET → str_append_mem ile '\n' dahil kopyala
         │    │          ft_memmove ile buffer'ı kaydır → return ret
         │    │
         │    └── HAYIR ↓
         │
         ├── str_append_str(ret, b) → buffer'ı ret'e ekle
         │
         ├── read(fd, b, BUFFER_SIZE) → yeni veri oku
         │    │
         │    ├── <= 0 → EOF veya hata
         │    │    └── ret doluysa return ret, yoksa return NULL
         │    │
         │    └── > 0 → b[read_ret] = '\0', döngüye devam
         │
         └── tekrar başa dön
```

#### Yardımcı Fonksiyonlar

| Fonksiyon | Görevi |
|:----------|:-------|
| `ft_strchr(s, c)` | `s` içinde `c` karakterini arar, bulursa pointer döner |
| `ft_memcpy(dest, src, n)` | `src`'den `dest`'e `n` byte kopyalar |
| `ft_strlen(s)` | NULL-safe string uzunluğu |
| `str_append_mem(s1, s2, size2)` | `*s1`'e `s2`'den `size2` byte ekler (realloc mantığı) |
| `str_append_str(s1, s2)` | `str_append_mem`'in string versiyonu |
| `ft_memmove(dest, src, n)` | Overlap-safe bellek kopyalama |

#### Akış Örneği

Dosya içeriği: `"Merhaba\nDünya\n"`, `BUFFER_SIZE=10`

```
1. read → b = "Merhaba\nDü"
2. ft_strchr → '\n' pozisyon 7'de bulundu
3. str_append_mem → ret = "Merhaba\n"
4. ft_memmove → b = "Dü"         (kalan veri korunur)
5. return "Merhaba\n"

Sonraki çağrı:
1. b = "Dü" (static'ten kalan)
2. ft_strchr → '\n' yok
3. str_append_str → ret = "Dü"
4. read → b = "nya\n"
5. ft_strchr → '\n' pozisyon 3'te bulundu
6. str_append_mem → ret = "Dünya\n"
7. return "Dünya\n"
```

#### Bellek Güvenliği

- Her `malloc` başarısızlığında `NULL` dönüşü
- `str_append_mem` eski `*s1`'i `free` eder
- EOF'ta buffer temizlenir (`b[0] = '\0'`)
- `(free(ret), NULL)` pattern'i ile tek satırda temizlik

---

### Sol 2 — Minimal Çözüm

📁 [sol_2/](sol_2/)

#### Mimari

```
get_next_line(fd)
    │
    ├── static buf[BUFFER_SIZE], ret, pos  ← hepsi static
    │
    └── malloc(10000) → sabit boyut (sınav ortamı için yeterli)
         │
         └── while (1)
              ├── pos >= ret? → read() çağır
              │    └── ret <= 0? → break
              │
              ├── len[i++] = buf[pos++]
              │
              └── len[i-1] == '\n'? → break
```

#### Farklar

| Özellik | Sol 1 | Sol 2 |
|:--------|:------|:------|
| Bellek ayırma | Dinamik (gerektikçe büyür) | Sabit 10000 byte |
| Buffer yönetimi | `ft_memmove` ile kaydırma | `pos` index ile takip |
| Güvenlik | Tam bellek kontrolü | Minimal (sınav odaklı) |
| Kod uzunluğu | ~120 satır | ~25 satır |
| Yaklaşım | Production-ready | Speed-coding |

#### Ne Zaman Hangisini Kullan?

- **Sol 1**: Kavramları anlamak ve güvenli kod yazmak istiyorsan
- **Sol 2**: Sınav sırasında hızlı yazmak istiyorsan (satır 10000 karakteri geçmeyecekse)

---

[⬆ broken_gnl ana dizinine dön](../) · [⬆ Level 1](../../)

---

# 🇫🇷 Français

# broken_gnl — Architecture de la solution

Ce répertoire contient deux approches de solution différentes pour le GNL cassé.

---

### Sol 1 — Solution détaillée

📁 [sol_1/](sol_1/)

#### Architecture

```
get_next_line(fd)
    │
    ├── static buffer b[BUFFER_SIZE + 1]  ← çağrılar arası veri saklar
    │
    └── while (1) döngüsü
         │
         ├── ft_strchr(b, '\n') → '\n' bulundu mu?
         │    │
         │    ├── EVET → str_append_mem ile '\n' dahil kopyala
         │    │          ft_memmove ile buffer'ı kaydır → return ret
         │    │
         │    └── HAYIR ↓
         │
         ├── str_append_str(ret, b) → buffer'ı ret'e ekle
         │
         ├── read(fd, b, BUFFER_SIZE) → yeni veri oku
         │    │
         │    ├── <= 0 → EOF veya hata
         │    │    └── ret doluysa return ret, yoksa return NULL
         │    │
         │    └── > 0 → b[read_ret] = '\0', döngüye devam
         │
         └── tekrar başa dön
```

#### Fonctions auxiliaires

| Fonction | Rôle |
|:---------|:-----|
| `ft_strchr(s, c)` | Recherche le caractère `c` dans `s`, retourne un pointeur si trouvé |
| `ft_memcpy(dest, src, n)` | Copie `n` octets de `src` vers `dest` |
| `ft_strlen(s)` | Longueur de chaîne NULL-safe |
| `str_append_mem(s1, s2, size2)` | Ajoute `size2` octets de `s2` à `*s1` (logique realloc) |
| `str_append_str(s1, s2)` | Version chaîne de `str_append_mem` |
| `ft_memmove(dest, src, n)` | Copie mémoire sûre en cas de chevauchement |

#### Exemple de flux

Contenu du fichier : `"Merhaba\nDünya\n"`, `BUFFER_SIZE=10`

```
1. read → b = "Merhaba\nDü"
2. ft_strchr → '\n' pozisyon 7'de bulundu
3. str_append_mem → ret = "Merhaba\n"
4. ft_memmove → b = "Dü"         (kalan veri korunur)
5. return "Merhaba\n"

Sonraki çağrı:
1. b = "Dü" (static'ten kalan)
2. ft_strchr → '\n' yok
3. str_append_str → ret = "Dü"
4. read → b = "nya\n"
5. ft_strchr → '\n' pozisyon 3'te bulundu
6. str_append_mem → ret = "Dünya\n"
7. return "Dünya\n"
```

#### Sécurité mémoire

- Retourne `NULL` à chaque échec de `malloc`
- `str_append_mem` libère l'ancien `*s1`
- Le buffer est vidé à EOF (`b[0] = '\0'`)
- Pattern `(free(ret), NULL)` pour un nettoyage en une ligne

---

### Sol 2 — Solution minimale

📁 [sol_2/](sol_2/)

#### Architecture

```
get_next_line(fd)
    │
    ├── static buf[BUFFER_SIZE], ret, pos  ← hepsi static
    │
    └── malloc(10000) → sabit boyut (sınav ortamı için yeterli)
         │
         └── while (1)
              ├── pos >= ret? → read() çağır
              │    └── ret <= 0? → break
              │
              ├── len[i++] = buf[pos++]
              │
              └── len[i-1] == '\n'? → break
```

#### Différences

| Caractéristique | Sol 1 | Sol 2 |
|:----------------|:------|:------|
| Allocation mémoire | Dynamique (grandit selon les besoins) | Fixe 10000 octets |
| Gestion du buffer | Décalage avec `ft_memmove` | Suivi avec l'index `pos` |
| Sécurité | Contrôle mémoire complet | Minimal (orienté examen) |
| Longueur du code | ~120 lignes | ~25 lignes |
| Approche | Prêt pour la production | Code rapide |

#### Quand utiliser lequel ?

- **Sol 1** : Si vous voulez comprendre les concepts et écrire du code sûr
- **Sol 2** : Si vous voulez écrire rapidement pendant l'examen (tant que les lignes ne dépassent pas 10000 caractères)

---

[⬆ Retour à broken_gnl](../) · [⬆ Level 1](../../)
