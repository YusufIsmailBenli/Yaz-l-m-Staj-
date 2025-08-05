-- yeni_musteri_islem.sql

PROMPT ' '
PROMPT '--------------------------------------'
PROMPT '        YENİ MÜŞTERİ BİLGİLERİ        '
PROMPT '--------------------------------------'

ACCEPT p_musteri_ad_input           CHAR PROMPT 'Yeni müşteri Adı: '
ACCEPT p_musteri_soyad_input        CHAR PROMPT 'Yeni müşteri Soyadı: '
ACCEPT p_musteri_telefon_input      CHAR PROMPT 'Yeni müşteri Telefon: '
ACCEPT p_musteri_eposta_input       CHAR PROMPT 'Yeni müşteri E-posta: '
ACCEPT p_musteri_adres_input        CHAR PROMPT 'Yeni müşteri Adres: '
ACCEPT p_musteri_tc_kimlik_no_input CHAR PROMPT 'Yeni müşteri TC Kimlik No: '

-- Değişkenlere değer ataması
BEGIN
    :p_mevcut_musteri_id_var     := NULL;
    :p_musteri_ad_var            := '&p_musteri_ad_input';
    :p_musteri_soyad_var         := '&p_musteri_soyad_input';
    :p_musteri_telefon_var       := '&p_musteri_telefon_input';
    :p_musteri_eposta_var        := '&p_musteri_eposta_input';
    :p_musteri_adres_var         := '&p_musteri_adres_input';
    :p_musteri_tc_kimlik_no_var  := '&p_musteri_tc_kimlik_no_input';
END;
/

-- Müşteri bilgileri girildikten sonra satış detay scriptini çağır
@satis_detay_al.sql
