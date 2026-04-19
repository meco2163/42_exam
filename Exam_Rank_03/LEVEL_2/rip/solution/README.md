# rip — Çözüm Mimarisi

## Genel Yaklaşım

**Backtracking + Memoization + Pruning** üçlü kombinasyonu:

1. Minimum kaç parantez silinmeli? (`must_fix`)
2. Her parantez pozisyonunu silmeyi dene, recursive ilerle
3. Dengeli bir string elde edince yazdır
4. Daha önce denenmiş stringleri atla (memoization)
5. Gereksiz dalları kes (pruning)

---

## Veri Yapıları

```c
char valid_string[100000][256]; // görülen stringleri sakla (memoization)
int  valid_counter = 0;         // kaç tane saklandı
```

> `malloc` izni olmadığından **global array** ile memoization yapılıyor. Bu, sınav ortamı için yeterli boyuttadır.

---

## Akış Diyagramı

```
main("())")
  │
  ├── must_fix = paranthesis("())") = 1  (1 fazladan ')')
  │
  └── rip("())", must_fix=1, n_fix=0, pos=0)
       │
       ├── n_fix > must_fix? → HAYIR (0 > 1 değil)
       ├── paranthesis("())") > must_fix - n_fix? → HAYIR (1 > 1 değil)
       ├── n_fix == must_fix VE paranthesis==0? → HAYIR
       ├── is_valid("())")? → HAYIR (ilk kez görülüyor)
       ├── set_valid("())") → kaydet
       │
       └── for i = pos to end
            │
            ├── i=0: '(' parantez mi? EVET
            │   s[0] = ' ' → " ))"
            │   rip(" ))", 1, 1, 1)
            │   │ n_fix == must_fix → paranthesis(" ))") = 1 ≠ 0 → yazdırma
            │   s[0] = '(' geri koy
            │
            ├── i=1: ')' parantez mi? EVET
            │   s[1] = ' ' → "( )"
            │   rip("( )", 1, 1, 2)
            │   │ n_fix == must_fix → paranthesis("( )") = 0 → YAZDIR: "( )"
            │   s[1] = ')' geri koy
            │
            └── i=2: ')' parantez mi? EVET
                s[2] = ' ' → "() "
                rip("() ", 1, 1, 3)
                │ n_fix == must_fix → paranthesis("() ") = 0 → YAZDIR: "() "
                s[2] = ')' geri koy
```

---

## Fonksiyon Detayları

### `paranthesis(char *s)` — Dengesizlik Sayacı

```c
int paranthesis(char *s)
{
    int opened = 0, closed = 0;
    for each char:
        '(' → opened++
        ')' → opened > 0 ? opened-- : closed++
    return opened + closed;
}
```

| String | opened | closed | Sonuç |
|:-------|:------:|:------:|:-----:|
| `"()"` | 0 | 0 | **0** (dengeli) |
| `"())"` | 0 | 1 | **1** |
| `"(()"` | 1 | 0 | **1** |
| `"(()("` | 2 | 0 | **2** |
| `")("` | 1 | 1 | **2** |

### `is_valid(char *s)` — Tekrar Kontrolü

Daha önce bu string'i denedik mi?

```c
for (int i = 0; i < valid_counter; i++)
    if (ft_strcmp(valid_string[i], s) == 0)
        return 1;  // tekrar
return 0;  // yeni
```

### `set_valid(char *s)` — String'i Kaydet

```c
ft_strcpy(valid_string[valid_counter], s);
valid_counter++;
```

### `rip(char *s, int must_fix, int n_fix, int pos)` — Ana Recursive Fonksiyon

```c
void rip(char *s, int must_fix, int n_fix, int pos)
{
    // 1. Budama: çok fazla silme yapıldı mı?
    if (n_fix > must_fix)
        return;

    // 2. Budama: kalan silme hakkıyla düzeltilebilir mi?
    if (paranthesis(s) > must_fix - n_fix)
        return;

    // 3. Çözüm bulundu mu?
    if (n_fix == must_fix && !paranthesis(s))
    {
        puts(s);
        return;
    }

    // 4. Tekrar mı?
    if (is_valid(s))
        return;
    set_valid(s);

    // 5. Her parantez pozisyonunu silmeyi dene
    for (int i = pos; i < strlen(s); i++)
    {
        if (s[i] == '(' || s[i] == ')')
        {
            char temp = s[i];
            s[i] = ' ';                        // sil
            rip(s, must_fix, n_fix + 1, i + 1); // recursive
            s[i] = temp;                        // geri koy
        }
    }
}
```

---

## Pruning (Budama) Detayı

İki budama kuralı performansı büyük ölçüde artırır:

### Kural 1: `n_fix > must_fix`

Gereğinden fazla silme yapıldıysa, bu daldan çözüm çıkmaz.

### Kural 2: `paranthesis(s) > must_fix - n_fix`

Mevcut dengesizlik, kalan silme hakkından **fazlaysa**, bu string düzeltilemez.

```
Örnek: must_fix=1, n_fix=0
String: "))))" → paranthesis = 4
4 > 1-0 → TRUE → BU DALI KES (zaman kazan)
```

---

## Neden Memoization Gerekli?

Aynı string'e farklı silme yollarından ulaşılabilir:

```
"(())"
├── pos 0 sil, pos 1 sil → "  ))"
└── pos 1 sil, pos 0 sil → "  ))"  ← AYNI STRING
```

`is_valid` + `set_valid` ile tekrarlar engellenir.

---

## Karmaşıklık

- **Zaman**: $O(2^n)$ en kötü durumda — budama ile pratikte çok daha hızlı
- **Alan**: $O(n \times m)$ — `valid_string` dizisi ($m$ = benzersiz string sayısı)

---

## Yerinde Değiştirme Tekniği

```c
char temp = s[i];   // orijinal karakteri sakla
s[i] = ' ';         // "sil" (boşlukla değiştir)
rip(...);            // recursive çağrı
s[i] = temp;         // geri koy (backtrack)
```

Bu teknik `malloc` gerektirmez — string yerinde modifiye edilip geri alınır.

---

[⬆ rip ana dizinine dön](../) · [⬆ Level 2](../../)
