/* =========================================================
   04_veri_kalitesi_kontrolleri.sql
   Eksik veri tespiti (LEFT JOIN + IS NULL) ve
   NULL değer yönetimi (NVL)
   ========================================================= */

-- 1. Hiç çalışanı olmayan departmanlar
--    (basit versiyon)
SELECT B.DEPARTMENT_NAME
FROM DEPARTMENTS B
LEFT JOIN EMPLOYEES A ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHERE A.EMPLOYEE_ID IS NULL;

-- 1b. Aynı sorgu, çalışan sayısıyla birlikte (GROUP BY + HAVING versiyonu)
--     Not: COUNT(*) değil COUNT(A.EMPLOYEE_ID) kullanılmalı,
--     çünkü COUNT(*) eşleşmeyen satırlarda bile 1 sayar.
SELECT B.DEPARTMENT_NAME, COUNT(A.EMPLOYEE_ID) AS CALISAN_SAYISI
FROM DEPARTMENTS B
LEFT JOIN EMPLOYEES A ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP BY B.DEPARTMENT_NAME
HAVING COUNT(A.EMPLOYEE_ID) = 0;

-- 2. NULL commission_pct değerlerini 0 olarak gösterme
SELECT FIRST_NAME, LAST_NAME, SALARY, NVL(COMMISSION_PCT, 0) AS KOMISYON
FROM EMPLOYEES;
