DELIMITER $
CREATE FUNCTION validar_CPF(CPF CHAR(11)) RETURNS INT deterministic
BEGIN
    DECLARE SOMA INT;
    DECLARE INDICE INT;
    DECLARE DIGITO_1 INT;
    DECLARE DIGITO_2 INT;
    DECLARE NR_DOCUMENTO_AUX VARCHAR(11);
   
 DECLARE DIGITO_1_CPF CHAR(2);
    DECLARE DIGITO_2_CPF CHAR(2);
   
    SET NR_DOCUMENTO_AUX = TRIM(CPF);
    IF (NR_DOCUMENTO_AUX IN ('00000000000', '11111111111', '22222222222', '33333333333', '44444444444', '55555555555', '66666666666', '77777777777', '88888888888', '99999999999', '12345678909')) THEN
        RETURN 0;
    END IF;
   
    IF (LENGTH(NR_DOCUMENTO_AUX) <> 11) THEN
        RETURN 0;
    ELSE 
 
   SET DIGITO_1_CPF = SUBSTRING(NR_DOCUMENTO_AUX,LENGTH(NR_DOCUMENTO_AUX)-1,1);
   SET DIGITO_2_CPF = SUBSTRING(NR_DOCUMENTO_AUX,LENGTH(NR_DOCUMENTO_AUX),1);
        SET SOMA = 0;
        SET INDICE = 1;
        WHILE (INDICE <= 9) DO          
            SET Soma = Soma + CAST(SUBSTRING(NR_DOCUMENTO_AUX,INDICE,1) AS UNSIGNED) * (11 - INDICE);             
            SET INDICE = INDICE + 1;      
         END WHILE;      
         SET DIGITO_1 = 11 - (SOMA % 11);      
         IF (DIGITO_1 > 9) THEN
            SET DIGITO_1 = 0;
         END IF;
      
        SET SOMA = 0;
        SET INDICE = 1;
        WHILE (INDICE <= 10) DO
             SET Soma = Soma + CAST(SUBSTRING(NR_DOCUMENTO_AUX,INDICE,1) AS UNSIGNED) * (12 - INDICE);              
             SET INDICE = INDICE + 1;
        END WHILE;
        SET DIGITO_2 = 11 - (SOMA % 11);
        IF DIGITO_2 > 9 THEN
            SET DIGITO_2 = 0;
        END IF;
      
        IF (DIGITO_1 = DIGITO_1_CPF) AND (DIGITO_2 = DIGITO_2_CPF) THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
 END IF;
END;
$

select CPF from CPF where validar_CPF(CPF) = 1

INSERT INTO CPF (CPF) VALUES ('67666767564');
INSERT INTO CPF (CPF) VALUES ('34535675776');
INSERT INTO CPF (CPF) VALUES ('78973353445');
INSERT INTO CPF (CPF) VALUES ('23424211334');
INSERT INTO CPF (CPF) VALUES ('67868768764');
INSERT INTO CPF (CPF) VALUES ('21313131456');