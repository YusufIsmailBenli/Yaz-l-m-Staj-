-- satis_detay_al.sql

PROMPT ' '
PROMPT '--------------------------------------'
PROMPT '           SATIŞ DETAYLARI            '
PROMPT '--------------------------------------'

-- Stoktaki araçları göster
PROMPT ' '
PROMPT ''
PROMPT 'STOKTA BULUNAN ARAÇLAR:'
PROMPT ''

COLUMN ARAC_ID           FORMAT 9999
COLUMN MARKA_AD          FORMAT A15
COLUMN MODEL_AD          FORMAT A20
COLUMN VIN               FORMAT A20
COLUMN URETIM_YILI       FORMAT 9999
COLUMN KASA_TIPI         FORMAT A15
COLUMN MOTOR_HACMI_CC    FORMAT 9999     HEADING 'MOTOR HACMI (CC)'
COLUMN BEYGIR_GUCU       FORMAT 999       HEADING 'BEYGIR GUCU'
COLUMN TORK              FORMAT 9999.00   HEADING 'TORK'
COLUMN VITES_TIPI        FORMAT A15       HEADING 'VITES TIPI'
COLUMN YAKIT_TIPI        FORMAT A15       HEADING 'YAKIT TIPI'
COLUMN RENK              FORMAT A15       HEADING 'RENK'
COLUMN SATIS_FIYATI      FORMAT 999,999,999.00

SELECT
    a.ARAC_ID,
    mt.MARKA_AD,
    t.MODEL_AD,
    a.VIN,
    a.URETIM_YILI,
    a.KASA_TIPI,
    a.MOTOR_HACMI_CC,
    a.BEYGIR_GUCU,
    a.TORK,
    a.VITES_TIPI,
    a.YAKIT_TIPI,
    a.RENK,
    a.SATIS_FIYATI
FROM
    SUBE1_DB_USER.ARACLAR a
JOIN
    SUBE1_DB_USER.MODEL_TANIMLARI t ON a.MODEL_ID = t.MODEL_ID
JOIN
    SUBE1_DB_USER.MARKA_TANIMLARI mt ON t.MARKA_ID = mt.MARKA_ID
WHERE
    a.DURUM = 'STOKTA'
ORDER BY
    a.ARAC_ID;

PROMPT ''

ACCEPT p_arac_id_input      NUMBER PROMPT 'Satışı yapılacak aracın IDsi: '
ACCEPT p_sube_id_input      NUMBER PROMPT 'Satışın yapıldığı şube IDsi: '

-- Seçilen şubedeki çalışanları listele
PROMPT ' '
PROMPT ''
PROMPT 'BU ŞUBEDEKİ ÇALIŞANLAR:'
PROMPT ''

COLUMN CALISAN_ID FORMAT 9999
COLUMN AD         FORMAT A15
COLUMN SOYAD      FORMAT A15
COLUMN UNVAN      FORMAT A20

SELECT
    CALISAN_ID,
    AD,
    SOYAD,
    UNVAN
FROM
    SUBE1_DB_USER.CALISANLAR
WHERE
    SUBE_ID = &p_sube_id_input
ORDER BY
    CALISAN_ID;

PROMPT ''

ACCEPT p_calisan_id_input          NUMBER PROMPT 'Satışı yapan çalışanın IDsi: '

-- Seçilen aracın peşin satış fiyatını al
VAR arac_fiyat_var NUMBER;

BEGIN
    SELECT SATIS_FIYATI
    INTO :arac_fiyat_var
    FROM SUBE1_DB_USER.ARACLAR
    WHERE ARAC_ID = &p_arac_id_input;
END;
/

-- Ödeme yöntemi alınır
ACCEPT p_odeme_yontemi_input CHAR PROMPT 'Ödeme Yöntemi (Nakit/Kredi Kartı/Havale): '

-- Vade farkı oranlarını göster
PROMPT ' '
PROMPT ''
PROMPT 'TAKSİT SEÇENEKLERİ VE VADE FARKLARI:'
PROMPT ''

COLUMN TAKSIT_SAYISI      FORMAT 999          HEADING 'TAKSİT SAYISI'
COLUMN VADE_FARKI_ORANI   FORMAT 999.00       HEADING 'VADE FARKI ORANI'
COLUMN HESAPLANAN_FIYAT   FORMAT 999,999,999.00 HEADING 'HESAPLANAN FİYAT'

SELECT
    TAKSIT_SAYISI,
    VADE_FARKI_ORANI,
    (:arac_fiyat_var * VADE_FARKI_ORANI) AS HESAPLANAN_FIYAT
FROM
    VADE_ORANLARI
ORDER BY
    TAKSIT_SAYISI;

PROMPT ''

ACCEPT p_taksit_sayisi_input        NUMBER PROMPT 'Kaç taksit yapılacak? (Vade Oranları tablosundan seçin): '
ACCEPT p_garanti_suresi_yil_input   NUMBER PROMPT 'Garanti Süresi (Yıl): '
PROMPT 'Satış Tarihi (DD-MON-YYYY formatında girin, örn: 31-TEM-2025):'
ACCEPT p_satis_tarihi_input         CHAR   PROMPT 'Satış Tarihi: '

-- Satış prosedürünü çağır
BEGIN
    SUBE1_DB_USER.P_YENI_SATIS_ISLEMI(
        p_mevcut_musteri_id     => :p_mevcut_musteri_id_var,
        p_musteri_ad            => :p_musteri_ad_var,
        p_musteri_soyad         => :p_musteri_soyad_var,
        p_musteri_telefon       => :p_musteri_telefon_var,
        p_musteri_eposta        => :p_musteri_eposta_var,
        p_musteri_adres         => :p_musteri_adres_var,
        p_musteri_tc_kimlik_no  => :p_musteri_tc_kimlik_no_var,
        p_arac_id               => &p_arac_id_input,
        p_calisan_id            => &p_calisan_id_input,
        p_sube_id               => &p_sube_id_input,
        p_odeme_yontemi         => '&p_odeme_yontemi_input',
        p_taksit_sayisi         => &p_taksit_sayisi_input,
        p_garanti_suresi_yil    => &p_garanti_suresi_yil_input,
        p_satis_tarihi          => TO_DATE('&p_satis_tarihi_input', 'DD-MON-YYYY')
    );
END;
/

PROMPT ' '
PROMPT 'Satış işlemi başarıyla tamamlandı. Satış kaydı oluşturuldu.'
PROMPT ' '

SET VERIFY ON;
