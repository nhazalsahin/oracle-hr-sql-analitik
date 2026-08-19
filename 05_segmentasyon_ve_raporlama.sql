/* =========================================================
   05_segmentasyon_ve_raporlama.sql
   UNION ile çoklu segment birleştirme ve
   kalıcı raporlama nesneleri (VIEW)
   ========================================================= */

-- 1. "Uzun süredir çalışanlar" segmenti:
--    15 yıldan fazla çalışmış OLAN veya maaşı 20000'den fazla OLAN
--    çalışanlar (UNION otomatik olarak tekrarları eler)
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12 > 15
UNION
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE SALARY > 20000;

-- 2. Her departmanda maaşa göre ilk 2 çalışanı kalıcı bir
--    rapor nesnesi (VIEW) olarak kaydetme
CREATE VIEW TOP2_MAASLAR AS
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_NAME
FROM (
    SELECT A.FIRST_NAME, A.LAST_NAME, A.SALARY, B.DEPARTMENT_NAME,
        RANK() OVER (PARTITION BY B.DEPARTMENT_NAME ORDER BY A.SALARY DESC) AS SIRA
    FROM EMPLOYEES A
    JOIN DEPARTMENTS B ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
)
WHERE SIRA IN (1, 2)
ORDER BY DEPARTMENT_NAME;

-- View'ı sorgulama örneği:
-- SELECT * FROM TOP2_MAASLAR;
