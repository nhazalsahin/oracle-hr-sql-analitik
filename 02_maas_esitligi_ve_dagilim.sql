/* =========================================================
   02_maas_esitligi_ve_dagilim.sql
   Maaş adaleti, pozisyon ortalamasından sapma ve
   yüzdelik dilim segmentasyonu
   ========================================================= */

-- 1. Her çalışanın, kendi pozisyonundaki (JOB_ID) ortalama maaştan
--    ne kadar farklı kazandığı — satır kaybı olmadan (Window Fonksiyon)
SELECT JOB_ID, FIRST_NAME, LAST_NAME, SALARY,
    AVG(SALARY) OVER (PARTITION BY JOB_ID) AS POZISYON_ORTALAMASI,
    SALARY - AVG(SALARY) OVER (PARTITION BY JOB_ID) AS FARK
FROM EMPLOYEES;

-- 2. Her çalışanı, kendi departmanındaki en yüksek maaşın %75'ini
--    geçip geçmediğine göre "Ust Dilim" / "Standart" olarak etiketleme
SELECT A.FIRST_NAME, A.LAST_NAME, B.DEPARTMENT_NAME, A.SALARY,
    CASE
        WHEN A.SALARY > M.MAX_SALARY * 0.75 THEN 'UST DILIM'
        ELSE 'STANDART'
    END AS DILIM
FROM EMPLOYEES A
JOIN DEPARTMENTS B ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
JOIN (
    SELECT DEPARTMENT_ID, MAX(SALARY) AS MAX_SALARY
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
) M ON A.DEPARTMENT_ID = M.DEPARTMENT_ID;

-- 3. Genel şirket ortalamasının üzerinde kazanan çalışanlar
--    (Nested Subquery — tek değerli alt sorgu)
SELECT A.FIRST_NAME, A.LAST_NAME, A.SALARY, B.DEPARTMENT_NAME
FROM EMPLOYEES A
JOIN DEPARTMENTS B ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHERE A.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

-- 4. Maaşa göre kategori (Üst / Orta / Giriş Düzey) ve
--    her kategorideki kişi sayısı
SELECT
    CASE
        WHEN SALARY > 15000 THEN 'UST DUZEY'
        WHEN SALARY >= 7000 THEN 'ORTA DUZEY'
        ELSE 'GIRIS SEVIYESI'
    END AS MAAS_SEVIYESI,
    COUNT(*) AS KISI_SAYISI
FROM EMPLOYEES
GROUP BY
    CASE
        WHEN SALARY > 15000 THEN 'UST DUZEY'
        WHEN SALARY >= 7000 THEN 'ORTA DUZEY'
        ELSE 'GIRIS SEVIYESI'
    END
ORDER BY KISI_SAYISI DESC;
