/* =========================================================
   01_departman_analizi.sql
   Departman bazlı çalışan sayısı, ortalama maaş ve
   bütçe kategorizasyonu analizleri
   ========================================================= */

-- 1. Her departmandaki çalışan sayısı ve ortalama maaş,
--    sadece 3'ten fazla çalışanı olan departmanlar,
--    ortalama maaşa göre bütçe etiketi ile birlikte.
SELECT DEPARTMENT_ID, COUNT(*), AVG(SALARY) AS ORT_MAAS,
    CASE
        WHEN AVG(SALARY) > 8000 THEN 'YUKSEK BUTCE'
        ELSE 'STANDART BUTCE'
    END AS ETIKET
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) > 3;

-- 2. Her departmandaki en yüksek maaşlı çalışan
--    Yöntem A: Alt sorgu (MAX) + inline view
SELECT A.FIRST_NAME, A.LAST_NAME, B.DEPARTMENT_NAME, A.SALARY
FROM EMPLOYEES A
JOIN DEPARTMENTS B ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
JOIN (
    SELECT DEPARTMENT_ID, MAX(SALARY) AS MAX_SALARY
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
) M ON A.DEPARTMENT_ID = M.DEPARTMENT_ID AND A.SALARY = M.MAX_SALARY
ORDER BY B.DEPARTMENT_NAME;

-- 2b. Aynı problem, Yöntem B: RANK() OVER (PARTITION BY ...)
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, SALARY
FROM (
    SELECT A.FIRST_NAME, A.LAST_NAME, A.SALARY, B.DEPARTMENT_NAME,
        RANK() OVER (PARTITION BY B.DEPARTMENT_NAME ORDER BY A.SALARY DESC) AS SIRA
    FROM EMPLOYEES A
    JOIN DEPARTMENTS B ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
)
WHERE SIRA = 1
ORDER BY DEPARTMENT_NAME;

-- 3. Pozisyon (JOB_ID) bazlı çalışan sayısı ve toplam maaş maliyeti,
--    3'ten fazla çalışanı olan pozisyonlar, çalışan sayısına göre azalan.
SELECT JOB_ID, SUM(SALARY), COUNT(*) AS TOTAL
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING COUNT(*) > 3
ORDER BY TOTAL DESC;

-- 4. Her departmanda maaşa göre ilk 2 sırada olan çalışanlar
--    (kalıcı VIEW olarak da kaydedilebilir, bkz. 05. dosya)
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_NAME
FROM (
    SELECT A.FIRST_NAME, A.LAST_NAME, A.SALARY, B.DEPARTMENT_NAME,
        RANK() OVER (PARTITION BY B.DEPARTMENT_NAME ORDER BY A.SALARY DESC) AS SIRA
    FROM EMPLOYEES A
    JOIN DEPARTMENTS B ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
)
WHERE SIRA IN (1, 2)
ORDER BY DEPARTMENT_NAME;
