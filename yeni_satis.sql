-- yeni_satis.sql

SET SERVEROUTPUT ON;
SET VERIFY OFF;

PROMPT ''
PROMPT 'YENİ SATIŞ İŞLEMİ'
PROMPT ''

-- Tüm değişkenleri ana script'te tanımlıyoruz.
VAR p_mevcut_musteri_id_var     NUMBER;
VAR p_musteri_ad_var            VARCHAR2(50);
VAR p_musteri_soyad_var         VARCHAR2(50);
VAR p_musteri_telefon_var       VARCHAR2(20);
VAR p_musteri_eposta_var        VARCHAR2(100);
VAR p_musteri_adres_var         VARCHAR2(200);
VAR p_musteri_tc_kimlik_no_var  VARCHAR2(11);

-- Kullanıcıdan yeni müşteri mi mevcut müşteri mi seçimi alınır
ACCEPT musteri_secim CHAR PROMPT 'Yeni müşteri mi? (Y/N): '

PROMPT ' '
PROMPT '--------------------------------------'
PROMPT '           İŞLEM BAŞLIYOR...          '
PROMPT '--------------------------------------'

-- Seçime göre ilgili script dosyasını belirleyip çalıştır
COLUMN SCRIPT_TO_RUN NEW_VALUE script_to_run NOPRINT

SELECT CASE UPPER('&musteri_secim')
           WHEN 'Y' THEN 'yeni_musteri_islem.sql'
           WHEN 'N' THEN 'mevcut_musteri_islem.sql'
           ELSE 'hata.sql'
       END AS SCRIPT_TO_RUN
FROM DUAL;

@&script_to_run
