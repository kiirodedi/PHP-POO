USE sistema_bancario;

DROP PROCEDURE IF EXISTS clientePF_alterar;
DELIMITER $$

CREATE PROCEDURE clientePF_alterar (
    IN cliente_id
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    

    COMMIT;
END $$

DELIMITER ;
