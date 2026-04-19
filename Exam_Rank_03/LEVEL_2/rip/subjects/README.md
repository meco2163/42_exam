> 📁 **Files:** [subject_en.txt](subject_en.txt) · [subject_tr.txt](subject_tr.txt) · [subject_fr.txt](subject_fr.txt)

# rip — Subject Açıklaması

## Soru Ne İstiyor?

Sadece parantezlerden oluşan bir string ver. Eğer parantezler **dengesiz** ise, dengelemek için **minimum sayıda** parantez sil (boşlukla değiştir). Tüm olası çözümleri yazdır.

```bash
./rip '())'
#  ()     ← son ')' silindi
# ( )     ← ortadaki ')' silindi... değil, ortadaki '(' silindi
```

---

## Dengeli Parantez Nedir?

Her `(` için karşılık gelen bir `)` olmalı ve sıralama doğru olmalı.

| String | Dengeli mi? | Açıklama |
|:-------|:----------:|:---------|
| `()` | ✓ | Temel denge |
| `(())` | ✓ | İç içe |
| `()()` | ✓ | Yan yana |
| `(()` | ✗ | Fazladan `(` |
| `())` | ✗ | Fazladan `)` |
| `)(` | ✗ | Yanlış sıra |
| ` ` (boş) | ✓ | Boş string dengeli sayılır |

### Denge Kontrolü Algoritması

```
opened = 0, closed = 0
Her karakter için:
  '(' → opened++
  ')' → opened > 0 ? opened-- : closed++

Dengesiz = opened + closed
```

- `opened`: eşleşmemiş `(` sayısı
- `closed`: eşleşmemiş `)` sayısı
- Toplam = minimum kaç parantez silinmeli

---

## Bilmen Gereken Kavramlar

### 1. Backtracking

Her parantez pozisyonu için iki seçenek:
- **Koru** — bu parantezi yerinde bırak
- **Sil** — bu parantezi boşlukla değiştir

```
"())" → minimum 1 silme gerekli
    ├── pos 0 '(' sil → " ))" → hala 1 dengesiz → devam...
    ├── pos 1 ')' sil → "( )" → dengeli! → ÇÖZÜM
    └── pos 2 ')' sil → "() " → dengeli! → ÇÖZÜM
```

### 2. Pruning (Budama)

Gereksiz dalları erken kes:

```
Kural: mevcut dengesizlik > kalan silme hakkı → bu dalı kes
```

Eğer şu anki string'in dengesizlik sayısı, kalan silme hakkından fazlaysa, bu yoldan çözüm bulunamaz.

### 3. Duplicate (Tekrar) Kontrolü

Aynı string'i birden fazla yoldan elde edebilirsin. Tekrarları engellemek için daha önce görülen stringleri sakla:

```
"())" → pos 1 sil: "( )" → ÇÖZÜM
     → farklı yoldan tekrar "( )" → TEKRAR → atla
```

### 4. "Silme" = Boşlukla Değiştirme

Karakter gerçekten silinmez, **boşluk karakteri** ile değiştirilir. String uzunluğu değişmez.

```
"(()(" → 2 silme → "( ) " (uzunluk hala 4)
```

---

## İzin Verilen Fonksiyonlar

| Fonksiyon | Nerede Kullanılır |
|:----------|:-----------------|
| `puts` | Çıktı yazdırma |
| `write` | Alternatif çıktı |

> Sadece `puts` ve `write`! `malloc` yok — yaratıcı çözüm gerekli.

---

## Çıktı Formatı

- Her çözüm ayrı satırda
- Silinen parantezler boşluk ile gösterilir
- Satır sırası önemli değil
- Tekrar eden çözüm olmamalı

---

## Zorluk Analizi

Bu problem Level 2'nin **en zor** sorusudur:

| Zorluk Faktörü | Açıklama |
|:----------------|:---------|
| Backtracking | Her pozisyon için dallanma |
| Pruning | Erken kesme olmadan çok yavaş |
| Memoization | Tekrarları engellemek şart |
| No malloc | Yaratıcı bellek çözümü gerekli |
| String manipülasyonu | Yerinde değiştirme ve geri alma |

---

## İpuçları

1. **`paranthesis()` fonksiyonu**: String'in kaç dengesiz parantezi olduğunu say — hem kontrol hem budama için kullan
2. **Global array ile memoization**: `malloc` izni olmadığından, görülen stringleri global dizide sakla
3. **Yerinde silme**: `s[i] = ' '` yap, recursive çağrı sonrası `s[i] = temp` geri koy
4. **`must_fix`**: Başlangıçtaki toplam dengesizlik = silinmesi gereken minimum parantez sayısı

---

[⬆ rip ana dizinine dön](../) · [⬆ Level 2](../../)
