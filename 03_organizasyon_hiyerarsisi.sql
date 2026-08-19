/* =========================================================
   03_organizasyon_hiyerarsisi.sql
   Self Join ile yönetici-çalışan ilişkileri
   ========================================================= */

-- 1. Her çalışanın adı, maaşı ve yöneticisinin adı, maaşı
--    (EMPLOYEES tablosunu iki farklı rolle - çalışan/yönetici - JOIN etme)
SELECT A.FIRST_NAME, A.LAST_NAME, A.SALARY,
       B.FIRST_NAME AS YONETICI_AD, B.LAST_NAME AS YONETICI_SOYAD, B.SALARY AS YONETICI_MAAS
FROM EMPLOYEES A
JOIN EMPLOYEES B ON A.MANAGER_ID = B.EMPLOYEE_ID;

-- 2. Yöneticisinden daha fazla kazanan çalışanlar
SELECT A.FIRST_NAME, A.LAST_NAME, A.SALARY,
       B.FIRST_NAME AS YONETICI_AD, B.LAST_NAME AS YONETICI_SOYAD, B.SALARY AS YONETICI_MAAS
FROM EMPLOYEES A
JOIN EMPLOYEES B ON A.MANAGER_ID = B.EMPLOYEE_ID
WHERE A.SALARY > B.SALARY;

-- 3. Maaşı 15000'den yüksek olan çalışanlar ve yöneticileri
SELECT A.FIRST_NAME, A.LAST_NAME, A.SALARY,
       B.FIRST_NAME AS MANAGER_AD, B.LAST_NAME AS MANAGER_SOYAD
FROM EMPLOYEES A
JOIN EMPLOYEES B ON A.MANAGER_ID = B.EMPLOYEE_ID
WHERE A.SALARY > 15000;
