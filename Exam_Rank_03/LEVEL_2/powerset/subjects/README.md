# powerset — Subject

<p align="center"><a href="#-english">English</a> · <a href="#-türkçe">Türkçe</a> · <a href="#-français">Français</a></p>

---

# 🇬🇧 English

### Subject Description

Given a target number `n` and a set of integers, print all subsets whose sum equals `n`.

```bash
./powerset 5 1 2 3 4 5
# 1 4
# 2 3
# 5
```

---

### What is the Subset Sum Problem?

Which **subsets** of a given set have a sum equal to a specific target number?

This is a classic **NP-Complete** problem in computer science. For small sizes, a recursive solution is sufficient.

#### Example

Set: `{1, 2, 3, 4, 5}`, Target: `5`

| Subset | Sum | Match |
|:-------|:---:|:-----:|
| {1, 4} | 5 | ✓ |
| {2, 3} | 5 | ✓ |
| {5} | 5 | ✓ |
| {1, 2, 3} | 6 | ✗ |
| {1, 2} | 3 | ✗ |
| {} | 0 | ✗ |

---

### Concepts You Need to Know

#### 1. Include / Exclude Technique

There are two choices for each element:
- **Include**: Add this element to the subset
- **Exclude**: Skip this element

This binary choice forms a **binary tree**:

```
                    {1,2,3}, target=3
                   /                \
            include 1             exclude 1
           sum=1                  sum=0
          /      \              /       \
     include 2  exclude 2  include 2  exclude 2
     sum=3     sum=1       sum=2      sum=0
      |   |     |   |       |   |      |   |
     i3  e3    i3  e3      i3  e3     i3  e3
```

#### 2. Ordering Rule

Elements within a subset must **preserve their original order in the set**:

```
Set: {5, 2, 1, 8, 4, 3}
Valid:   "5 2 1"  (original order)
Invalid: "1 2 5"  (order changed)
```

#### 3. Empty Subset

If target = 0, the empty subset is a valid solution (`\n` is printed):

```bash
./powerset 0 1 -1
# ← empty line (the empty set sums to 0)
# 1 -1
```

#### 4. Negative Numbers

The set may contain negative numbers:
- `{1, -1}` → sum = 0
- This affects sum calculations

---

### Allowed Functions

| Function | Where It's Used |
|:---------|:----------------|
| `atoi` | Converting arguments to integers |
| `printf` / `fprintf` | Printing output |
| `write` | Alternative output |
| `malloc` / `calloc` / `realloc` / `free` | Memory management |
| `stdout` | Output stream |

---

### Output Format

- Each subset on a separate line
- Elements separated by spaces
- No trailing space after the last element
- Empty subset = empty line
- Line order does not matter

---

### Tips

1. **Include/Exclude pattern** — two recursive calls for each element
2. **`player[]` array** — track selected elements
3. **Early pruning**: stop if the sum exceeds the target (be careful with negative numbers!)
4. `ac - 2` → number of elements in the set (first argument is the target, set starts from the second argument)

---

[⬆ Back to powerset](../) · [⬆ Level 2](../../)

---

# 🇹🇷 Türkçe

### Subject Açıklaması

Bir hedef sayı `n` ve bir tamsayı kümesi verilir. Toplamı `n` olan tüm alt kümeleri yazdır.

```bash
./powerset 5 1 2 3 4 5
# 1 4
# 2 3
# 5
```

---

### Subset Sum Problemi Nedir?

Verilen bir kümenin **alt kümelerinden** hangilerinin toplamı belirli bir hedef sayıya eşittir?

Bu problem, bilgisayar biliminde klasik bir **NP-Complete** problemdir. Küçük boyutlar için recursive çözüm yeterlidir.

#### Örnek

Küme: `{1, 2, 3, 4, 5}`, Hedef: `5`

| Alt Küme | Toplam | Eşleşme |
|:---------|:------:|:-------:|
| {1, 4} | 5 | ✓ |
| {2, 3} | 5 | ✓ |
| {5} | 5 | ✓ |
| {1, 2, 3} | 6 | ✗ |
| {1, 2} | 3 | ✗ |
| {} | 0 | ✗ |

---

### Bilmen Gereken Kavramlar

#### 1. Include / Exclude Tekniği

Her eleman için iki seçenek var:
- **Dahil et** (include): Bu elamanı alt kümeye ekle
- **Hariç tut** (exclude): Bu elemanı atla

Bu ikili seçim bir **binary tree** oluşturur:

```
                    {1,2,3}, hedef=3
                   /                \
            dahil 1               hariç 1
           sum=1                  sum=0
          /      \              /       \
     dahil 2   hariç 2    dahil 2    hariç 2
     sum=3     sum=1       sum=2      sum=0
      |   |     |   |       |   |      |   |
     d3  h3    d3  h3      d3  h3     d3  h3
```

#### 2. Sıralama Kuralı

Alt küme içindeki elemanlar, **orijinal kümedeki sırayı korumalı**:

```
Küme: {5, 2, 1, 8, 4, 3}
Geçerli: "5 2 1"  (orijinal sıra)
Geçersiz: "1 2 5" (sıra değişmiş)
```

#### 3. Boş Alt Küme

Hedef = 0 ise boş alt küme geçerli bir çözümdür (`\n` yazdırılır):

```bash
./powerset 0 1 -1
# ← boş satır (boş kümenin toplamı 0)
# 1 -1
```

#### 4. Negatif Sayılar

Küme negatif sayılar içerebilir:
- `{1, -1}` → toplam = 0
- Bu durum toplam hesaplamalarını etkiler

---

### İzin Verilen Fonksiyonlar

| Fonksiyon | Nerede Kullanılır |
|:----------|:-----------------|
| `atoi` | Argümanları integer'a çevirme |
| `printf` / `fprintf` | Çıktı yazdırma |
| `write` | Alternatif çıktı |
| `malloc` / `calloc` / `realloc` / `free` | Bellek yönetimi |
| `stdout` | Çıktı akışı |

---

### Çıktı Formatı

- Her alt küme ayrı satırda
- Elemanlar arası boşluk
- Son elemandan sonra boşluk yok
- Boş alt küme = boş satır
- Satır sırası önemli değil

---

### İpuçları

1. **Include/Exclude pattern** — her eleman için iki recursive çağrı
2. **`player[]` dizisi** — seçilen elemanları takip et
3. **Erken kesme (pruning)**: toplam hedefi geçtiyse devam etme (negatif sayılar varsa dikkat!)
4. `ac - 2` → kümedeki eleman sayısı (ilk argüman hedef, ikinci argümandan itibaren küme)

---

[⬆ powerset ana dizinine dön](../) · [⬆ Level 2](../../)

---

# 🇫🇷 Français

### Description du sujet

Étant donné un nombre cible `n` et un ensemble d'entiers, afficher tous les sous-ensembles dont la somme est égale à `n`.

```bash
./powerset 5 1 2 3 4 5
# 1 4
# 2 3
# 5
```

---

### Qu'est-ce que le problème de la somme de sous-ensembles ?

Quels **sous-ensembles** d'un ensemble donné ont une somme égale à un nombre cible spécifique ?

Ce problème est un problème classique **NP-Complet** en informatique. Pour les petites tailles, une solution récursive suffit.

#### Exemple

Ensemble : `{1, 2, 3, 4, 5}`, Cible : `5`

| Sous-ensemble | Somme | Correspondance |
|:--------------|:-----:|:--------------:|
| {1, 4} | 5 | ✓ |
| {2, 3} | 5 | ✓ |
| {5} | 5 | ✓ |
| {1, 2, 3} | 6 | ✗ |
| {1, 2} | 3 | ✗ |
| {} | 0 | ✗ |

---

### Concepts à connaître

#### 1. Technique Include / Exclude

Pour chaque élément, il y a deux choix :
- **Inclure** : Ajouter cet élément au sous-ensemble
- **Exclure** : Ignorer cet élément

Ce choix binaire forme un **arbre binaire** :

```
                    {1,2,3}, cible=3
                   /                \
            inclure 1             exclure 1
           sum=1                  sum=0
          /      \              /       \
     inclure 2  exclure 2  inclure 2  exclure 2
     sum=3     sum=1       sum=2      sum=0
      |   |     |   |       |   |      |   |
     i3  e3    i3  e3      i3  e3     i3  e3
```

#### 2. Règle d'ordonnancement

Les éléments d'un sous-ensemble doivent **conserver leur ordre d'origine dans l'ensemble** :

```
Ensemble : {5, 2, 1, 8, 4, 3}
Valide :   "5 2 1"  (ordre original)
Invalide : "1 2 5"  (ordre modifié)
```

#### 3. Sous-ensemble vide

Si cible = 0, le sous-ensemble vide est une solution valide (`\n` est affiché) :

```bash
./powerset 0 1 -1
# ← ligne vide (la somme de l'ensemble vide est 0)
# 1 -1
```

#### 4. Nombres négatifs

L'ensemble peut contenir des nombres négatifs :
- `{1, -1}` → somme = 0
- Cela affecte les calculs de somme

---

### Fonctions autorisées

| Fonction | Utilisation |
|:---------|:------------|
| `atoi` | Conversion des arguments en entiers |
| `printf` / `fprintf` | Affichage de la sortie |
| `write` | Sortie alternative |
| `malloc` / `calloc` / `realloc` / `free` | Gestion de la mémoire |
| `stdout` | Flux de sortie |

---

### Format de sortie

- Chaque sous-ensemble sur une ligne séparée
- Éléments séparés par des espaces
- Pas d'espace après le dernier élément
- Sous-ensemble vide = ligne vide
- L'ordre des lignes n'a pas d'importance

---

### Conseils

1. **Pattern Include/Exclude** — deux appels récursifs pour chaque élément
2. **Tableau `player[]`** — suivre les éléments sélectionnés
3. **Élagage précoce (pruning)** : arrêter si la somme dépasse la cible (attention aux nombres négatifs !)
4. `ac - 2` → nombre d'éléments dans l'ensemble (le premier argument est la cible, l'ensemble commence au deuxième argument)

---

[⬆ Retour à powerset](../) · [⬆ Level 2](../../)
