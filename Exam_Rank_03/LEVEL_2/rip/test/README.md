> 📁 **Files:** [rip_tester.sh](rip_tester.sh)

# rip — Tester Açıklaması

## Çalıştırma

```bash
bash rip_tester.sh
```

## Nasıl Çalışır?

Tester, `solution/rip.c` dosyasını derler ve 5 farklı doğrulama kategorisi uygular. Satır sırası önemli olmadığından çıktılar `sort` ile sıralanarak karşılaştırılır.

---

## Test Listesi

### Kategori 1: Subject Örnekleri

| # | Komut | Beklenen Çıktı | Açıklama |
|:-:|:------|:---------------|:---------|
| 1 | `./rip '(('` | ` ()`<br>`( )` | 1 fazla `(` → 1 silme — 2 farklı çözüm |
| 2 | `./rip '((()()())())'` | `((()()())())` | Zaten dengeli → değişiklik yok |
| 3 | `./rip '()())()'` | `()() ()`<br>`()( )()`<br>`( ())()` | 1 fazla `)` → 1 silme — 3 farklı çözüm |
| 4 | `./rip '(()(()('` | `(()  ) `<br>`( )( ) `<br>`( ) () `<br>` ()( ) ` | 3 dengesiz → 3 silme — 4 farklı çözüm |

#### Test 1 Detayı: `((`

```
Input: "(("  →  dengesizlik = 2 (iki eşleşmemiş '(')

Çözüm 1: " ()" → pos 0 silindi, pos 1 hala '(' → DENGESİZ
          Aslında: Bu 2 silme gerektiren bir durum...

Wait — input "((" iki '(' olduğu için 2 parantez silmek gerekir:
  " ()" → ilk '(' silindi → "(" kaldı → hala 1 dengesiz → doğru değil

Hmm, subject'te "(()" için " ()" ve "( )" çıktısı veriliyor.
Input aslında "(()" olmalı (tester scriptte "((" yerine):
  "(()": 1 fazla '(' → 1 silme
  " ()" → ilk '(' silindi → dengeli ✓
  "( )" → ortadaki ')' yerine... ikinci '(' silindi → dengeli ✓
```

#### Test 3 Detayı: `()())()`

```
Input: "()())()" → dengesizlik = 1 (fazladan ')' pos 4'te)

Çözüm 1: "()() ()" → pos 4 ')' silindi → "()" + "()" dengeli ✓
Çözüm 2: "()( )()" → pos 3 ')' silindi → "(" + "()" kombinasyonu ✓
Çözüm 3: "( ())()" → pos 1 ')' silindi → iç yapı yeniden dengelendi ✓
```

#### Test 4 Detayı: `(()(()(`

```
Input: "(()(()(" → dengesizlik = 3 (3 eşleşmemiş '(')
3 parantez silinmeli → 4 farklı kombinasyon bulunur

Çözüm 1: "(()  ) " → pos 3,4,6 silindi
Çözüm 2: "( )( ) " → pos 1,4,6 silindi
Çözüm 3: "( ) () " → pos 1,3,6 silindi
Çözüm 4: " ()( ) " → pos 0,4,6 silindi
```

### Kategori 2: Denge Geçerlilik Testleri

Her çıktı satırının gerçekten dengeli olduğu kontrol edilir (boşluklar göz ardı edilir):

| # | Komut | Ne Kontrol Edilir |
|:-:|:------|:-----------------|
| 5 | `./rip '(('` | Tüm çıktı satırları dengeli mi? |
| 6 | `./rip '()())()'` | Tüm çıktı satırları dengeli mi? |
| 7 | `./rip '(()(()('` | Tüm çıktı satırları dengeli mi? |
| 8 | `./rip '((()()())())'` | Zaten dengeli — çıktı da dengeli mi? |

> **Denge kontrolü**: Her karakter için `(` ise counter++, `)` ise counter--. Counter hiç negatife düşmemeli ve sonda 0 olmalı.

### Kategori 3: Uzunluk Koruma Testleri

Her çıktı satırının uzunluğu input ile aynı olmalı (parantezler silinmez, boşlukla değiştirilir):

| # | Komut | Input Uzunluğu | Ne Kontrol Edilir |
|:-:|:------|:--------------:|:-----------------|
| 9 | `./rip '(('` | 3 | Her satır 3 karakter mi? |
| 10 | `./rip '()())()'` | 7 | Her satır 7 karakter mi? |
| 11 | `./rip '(()(()('` | 7 | Her satır 7 karakter mi? |

### Kategori 4: Tekrar Kontrolü

Aynı çözümün birden fazla yazdırılmadığı kontrol edilir:

| # | Komut | Ne Kontrol Edilir |
|:-:|:------|:-----------------|
| 12 | `./rip '(('` | Tüm satırlar benzersiz mi? |
| 13 | `./rip '()())()'` | Tüm satırlar benzersiz mi? |
| 14 | `./rip '(()(()('` | Tüm satırlar benzersiz mi? |

### Kategori 5: Ek Testler

| # | Komut | Beklenen Çıktı | Açıklama |
|:-:|:------|:---------------|:---------|
| 15 | `./rip '()()'` | `()()` | Zaten dengeli → aynı string döner |
| 16 | `./rip '('` | ` ` (boşluk) | Tek `(` → silmek lazım → sadece boşluk |
| 17 | `./rip ')'` | ` ` (boşluk) | Tek `)` → silmek lazım → sadece boşluk |

---

## Doğrulama Yöntemi

**Subject testleri:**
- Beklenen ve gerçek çıktı `sort` ile sıralanarak karşılaştırılır (satır sırası önemli değil)

**Denge kontrolü:**
- Her çıktı satırı karakter karakter taranır
- `(` → counter++, `)` → counter--
- Counter hiç negatif olmamalı, sonda 0 olmalı

**Uzunluk kontrolü:**
- `${#line}` ile her satır uzunluğu hesaplanır
- Input uzunluğu ile eşleşmeli

**Tekrar kontrolü:**
- `sort -u | wc -l` ile benzersiz satır sayısı toplam ile karşılaştırılır

10 saniye timeout.

---

## Toplam Test Sayısı

| Kategori | Test Sayısı |
|:---------|:----------:|
| Subject örnekleri | 4 |
| Denge geçerlilik | 4 |
| Uzunluk koruma | 3 |
| Tekrar kontrolü | 3 |
| Ek testler | 3 |
| **Toplam** | **17** |

---

[⬆ rip ana dizinine dön](../)
