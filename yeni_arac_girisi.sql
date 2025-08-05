-- yeni_arac_girisi.sql

SET SERVEROUTPUT ON;
SET VERIFY OFF;

PROMPT ''
PROMPT 'YENİ ARAÇ GİRİŞİ'
PROMPT ''

-- Mevcut markaları listele
PROMPT 'STOKTA BULUNAN MARKALAR:'
SELECT MARKA_ID, MARKA_AD
FROM SUBE1_DB_USER.MARKA_TANIMLARI;

-- Marka ve model bilgilerini al
ACCEPT p_marka_id NUMBER PROMPT 'Eklemek istediğiniz aracın Marka IDsi: '

PROMPT '--------------------------------------'
PROMPT 'Seçtiğiniz markaya ait modeller:'
SELECT MODEL_ID, MODEL_AD
FROM SUBE1_DB_USER.MODEL_TANIMLARI
WHERE MARKA_ID = &p_marka_id;

-- Diğer tüm araç bilgilerini al
ACCEPT p_model_id        NUMBER     PROMPT 'Eklemek istediğiniz aracın Model IDsi: '
ACCEPT p_uretim_yili     NUMBER     PROMPT 'Üretim Yılı: '
ACCEPT p_kasa_tipi       CHAR       PROMPT 'Kasa Tipi (Sedan/Hatchback/SUV): '
ACCEPT p_motor_hacmi     NUMBER     PROMPT 'Motor Hacmi (CC): '
ACCEPT p_beygir_gucu     NUMBER     PROMPT 'Beygir Gücü: '
ACCEPT p_tork            NUMBER     PROMPT 'Tork: '
ACCEPT p_vites_tipi      CHAR       PROMPT 'Vites Tipi (Otomatik/Manuel): '
ACCEPT p_yakit_tipi      CHAR       PROMPT 'Yakıt Tipi (Benzin/Dizel/Hibrit): '
ACCEPT p_renk            CHAR       PROMPT 'Renk: '
ACCEPT p_satis_fiyati    NUMBER     PROMPT 'Satış Fiyatı: '
ACCEPT p_sube_id         NUMBER     PROMPT 'Şube ID: '

-- Prosedürü çağır
DECLARE
    v_marka_id      NUMBER        := &p_marka_id;
    v_model_id      NUMBER        := &p_model_id;
    v_uretim_yili   NUMBER        := &p_uretim_yili;
    v_kasa_tipi     VARCHAR2(50)  := '&p_kasa_tipi';
    v_motor_hacmi   NUMBER        := &p_motor_hacmi;
    v_beygir_gucu   NUMBER        := &p_beygir_gucu;
    v_tork          NUMBER        := &p_tork;
    v_vites_tipi    VARCHAR2(50)  := '&p_vites_tipi';
    v_yakit_tipi    VARCHAR2(50)  := '&p_yakit_tipi';
    v_renk          VARCHAR2(50)  := '&p_renk';
    v_satis_fiyati  NUMBER        := &p_satis_fiyati;
    v_sube_id       NUMBER        := &p_sube_id;
BEGIN
    SUBE1_DB_USER.P_YENI_ARAC_GIRISI(
        p_marka_id      => v_marka_id,
        p_model_id      => v_model_id,
        p_uretim_yili   => v_uretim_yili,
        p_kasa_tipi     => v_kasa_tipi,
        p_motor_hacmi   => v_motor_hacmi,
        p_beygir_gucu   => v_beygir_gucu,
        p_tork          => v_tork,
        p_vites_tipi    => v_vites_tipi,
        p_yakit_tipi    => v_yakit_tipi,
        p_renk          => v_renk,
        p_satis_fiyati  => v_satis_fiyati,
        p_sube_id       => v_sube_id
    );
END;
/
