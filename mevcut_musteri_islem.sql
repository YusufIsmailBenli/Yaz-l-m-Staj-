-- mevcut_musteri_islem.sql

PROMPT ' '
PROMPT '--------------------------------------'
PROMPT '         MEVCUT MÜŞTERİ İŞLEMİ        '
PROMPT '--------------------------------------'

-- Mevcut müşterileri listele
PROMPT ' '
PROMPT ''
PROMPT 'MEVCUT MÜŞTERİLER:'
PROMPT ''

COLUMN MUSTERI_ID FORMAT 9999
COLUMN AD         FORMAT A15
COLUMN SOYAD      FORMAT A15
COLUMN EPOSTA     FORMAT A25

SELECT
    MUSTERI_ID,
    AD,
    SOYAD,
    EPOSTA
FROM
    SUBE1_DB_USER.MUSTERILER
ORDER BY
    MUSTERI_ID;

PROMPT ''

-- Kullanıcıdan müşteri ID'si alınır
ACCEPT p_mevcut_musteri_id_input NUMBER PROMPT 'Müşteri ID: '

-- Değişkenlere değer ataması
BEGIN
    :p_mevcut_musteri_id_var     := &p_mevcut_musteri_id_input;
    :p_musteri_ad_var            := NULL;
    :p_musteri_soyad_var         := NULL;
    :p_musteri_telefon_var       := NULL;
    :p_musteri_eposta_var        := NULL;
    :p_musteri_adres_var         := NULL;
    :p_musteri_tc_kimlik_no_var  := NULL;
END;
/

-- Müşteri bilgileri girildikten sonra satış detay scriptini çağır
@satis_detay_al.sql
