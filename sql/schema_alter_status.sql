USE sistema_bancario;

DROP PROCEDURE IF EXISTS alter_status_conta;
DELIMITER $$

CREATE PROCEDURE alter_status_conta (
    IN c_cod INT UNSIGNED
)
BEGIN
    DECLARE status_atual ENUM('ativa', 'inativa');
    DECLARE status_novo ENUM('ativa', 'inativa');

    SELECT status INTO status_atual
    FROM Contas
    WHERE id = c_cod;

    IF status_atual = 'ativa' THEN
            SET status_novo = 'inativa';
        ELSEIF status_atual = 'inativa' THEN
            SET status_novo = 'ativa';
    END IF;

    UPDATE Contas
    SET status = status_novo
    WHERE id = c_cod;

    SELECT CONCAT('Status da Conta ', conta_id_param, ' alterado de ', status_atual, ' para ', novo_status, '.') AS Mensagem;
END $$

DELIMITER ;