# Oracle SQL ile İK Veri Analizi Projesi

Oracle'ın resmi **HR (Human Resources) örnek şeması** (107 çalışan, 27 departman, 19 pozisyon) üzerinde, gerçek şirketlerde İK/finans ekiplerinin ihtiyaç duyduğu türden analitik raporlar hazırlamak amacıyla geliştirdiğim SQL sorgu koleksiyonu.

## Kullanılan Ortam
- **Veritabanı:** Oracle Database 21c Express Edition (XE)
- **Veri Seti:** Oracle Human Resources (HR) Sample Schema — [oracle-samples/db-sample-schemas](https://github.com/oracle-samples/db-sample-schemas)
- **Araçlar:** SQL*Plus

## Kullanılan SQL Teknikleri
- INNER / LEFT / RIGHT JOIN, Self Join, çoklu tablo JOIN'leri
- GROUP BY, HAVING, agregasyon fonksiyonları (COUNT, SUM, AVG, MAX)
- Alt sorgular (subquery), inline view, nested subquery
- Window (analitik) fonksiyonlar — RANK() OVER, AVG() OVER (PARTITION BY ...)
- CASE WHEN ile koşullu kategorizasyon
- UNION ile çoklu segment birleştirme
- NULL yönetimi (NVL)
- View oluşturma
- Tarih fonksiyonları (SYSDATE, MONTHS_BETWEEN)

## Dosya Yapısı

| Dosya | İçerik |
|---|---|
| `01_departman_analizi.sql` | Departman bazlı çalışan sayısı, ortalama maaş, bütçe kategorizasyonu, en yüksek maaşlı çalışanı bulma (3 farklı yöntemle) |
| `02_maas_esitligi_ve_dagilim.sql` | Maaş adaleti analizi — pozisyon ortalamasından sapma, departman içi maaş sıralaması, yüzdelik dilim segmentasyonu |
| `03_organizasyon_hiyerarsisi.sql` | Self Join ile yönetici-çalışan ilişkileri, yöneticisinden fazla kazananları tespit etme |
| `04_veri_kalitesi_kontrolleri.sql` | Hiç çalışanı olmayan departmanları bulma (LEFT JOIN + IS NULL), NULL değer yönetimi (NVL) |
| `05_segmentasyon_ve_raporlama.sql` | Kıdem/maaş kriterlerine göre segmentasyon (UNION), genel ortalamanın üzerinde kazananlar, kalıcı View oluşturma |

## Öne Çıkan Bulgular (Örnek)
- Şirket genelinde 107 çalışanın ~%47'si genel maaş ortalamasının üzerinde kazanıyor.
- En kalabalık pozisyon Satış Temsilciliği (30 kişi), toplam maaş maliyeti $250,500.
- 16 departmanın hiç atanmış çalışanı bulunmuyor — veri/organizasyon tutarlılığı açısından incelenmesi gereken bir alan.

## Neden Bu Proje?
Bu çalışma, staj sürecimde SQL öğrenimimi pekiştirmek ve gerçek dünya İK/finans senaryolarına (bütçe analizi, maaş adaleti, organizasyon yapısı) SQL ile nasıl çözüm üretileceğini uygulamalı olarak deneyimlemek amacıyla hazırlanmıştır.
