------------------------------ ClientesPF ------------------------------
----- Cadastrar -----
USE sistema_bancario;
DROP PROCEDURE IF EXISTS clientePF_cadastrar;
DELIMITER $$

CREATE PROCEDURE clientePF_cadastrar (
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cpf VARCHAR(14),
    IN p_data_nascimento DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO Clientes (nome, email, telefone, endereco, username, password)
    VALUES (p_nome, p_email, p_telefone, p_endereco, p_username, p_password);

    SET @last_id = LAST_INSERT_ID();

    INSERT INTO Clientes_PF (cliente_id, cpf, data_nascimento)
    VALUES (@last_id, p_cpf, p_data_nascimento);

    COMMIT;
END $$

DELIMITER ;

----- Alterar -----
USE sistema_bancario;
DROP PROCEDURE IF EXISTS clientesPF_alterar;
DELIMITER $$
CREATE PROCEDURE clientePF_alterar (
    IN p_cliente_id INT,
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cpf VARCHAR(14),
    IN p_data_nascimento DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE Clientes
        SET nome = p_nome,
            email = p_email,
            telefone = p_telefone,
            endereco = p_endereco,
            username = p_username,
            password = p_password,
    WHERE cliente_id = p_cliente_id;

    UPDATE Clientes_PF
        SET cpf = p_cpf,
            data_nascimento = p_data_nascimento
    WHERE cliente_id = p_cliente_id;

    COMMIT;
END $$

DELIMITER ;

----- Consultar -----

--- Por nome ----
USE sistema_bancario;
DROP PROCEDURE IF EXISTS consultarPorNome;

CREATE PROCEDURE IF NOT EXISTS consultarClientePorNome (
    IN p_nome VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

SELECT *
FROM Clientes
    INNER JOIN Clientes_PF
        ON Clientes.id = Clientes_PF.cliente_id
WHERE Clientes.nome = p_nome;
    COMMIT;
END $$

DELIMITER ;

--- Por CPF ----
USE sistema_bancario;
DROP PROCEDURE IF EXISTS consultarPJPorCPF;

CREATE PROCEDURE IF NOT EXISTS consultarPJPorCPF (
    IN p_cpf VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

SELECT *
FROM Clientes_PF
WHERE Clientes_PF.cpf = p_cpf;
    COMMIT;
END $$

DELIMITER ;

--- Por email ---
USE sistema_bancario;
DROP PROCEDURE IF EXISTS consultarPFPorEmail;

CREATE PROCEDURE IF NOT EXISTS consultarPFPorEmail (
    IN p_email VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

SELECT *
FROM Clientes
    INNER JOIN Clientes_PF
        ON Clientes.id = Clientes_PF.cliente_id
WHERE Clientes.email = p_email;
    COMMIT;
END $$

DELIMITER ;

--- Por ID ---
USE sistema_bancario;
DROP PROCEDURE IF EXISTS consultarPFPorId;

CREATE PROCEDURE IF NOT EXISTS consultarPFPorId (
    IN p_id VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

SELECT *
FROM Clientes
    INNER JOIN Clientes_PF
        ON Clientes.id = Clientes_PF.cliente_id
WHERE Clientes.id = p_id;
    COMMIT;
END $$

DELIMITER ;

------------------------------ ClientesPJ ------------------------------
----- Cadastrar -----
USE sistema_bancario;

DROP PROCEDURE IF EXISTS clientePJ_cadastrar;
DELIMITER $$

CREATE PROCEDURE clientePJ_cadastrar (
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cpf VARCHAR(14),
    IN p_data_nascimento DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO Clientes (nome, email, telefone, endereco, username, password)
    VALUES (p_nome, p_email, p_telefone, p_endereco, p_username, p_password);

    SET @last_id = LAST_INSERT_ID();

    INSERT INTO Clientes_PJ (cliente_id, cnpj, razao_social)
    VALUES (@last_id, p_cnpj, p_razao_social);

    COMMIT;
END $$

DELIMITER ;

----- Alterar -----
DROP PROCEDURE IF EXISTS clientesPJ_alterar;
DELIMITER $$
CREATE PROCEDURE clientePJ_alterar (
    IN p_cliente_id INT,
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cnpj VARCHAR(14),
    IN p_razao_social VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE Clientes
        SET nome = p_nome,
            email = p_email,
            telefone = p_telefone,
            endereco = p_endereco,
            username = p_username,
            password = p_password,
    WHERE cliente_id = p_cliente_id;

    UPDATE Clientes_PJ
        SET cnpj = p_cnpj,
            razao_social = p_razao_social
    WHERE cliente_id = p_cliente_id;
    COMMIT;
END $$

DELIMITER ;

----- Consultar -----
--- Por razão social ---
USE sistema_bancario;
DROP PROCEDURE IF EXISTS consultarPorRazaoSocial;

CREATE PROCEDURE IF NOT EXISTS consultarPorRazaoSocial (
    IN p_razao_social VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

SELECT *
FROM Clientes
    INNER JOIN Clientes_PJ
        ON Clientes.id = Clientes_PJ.cliente_id
WHERE Clientes.nome = p_razao_social;
    COMMIT;
END $$

DELIMITER ;

--- Por CNPJ ----
USE sistema_bancario;
DROP PROCEDURE IF EXISTS consultarPorCNPJ;

CREATE PROCEDURE IF NOT EXISTS consultarPorCNPJ (
    IN p_cnpj VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

SELECT *
FROM Clientes_PJ
WHERE Clientes_PJ.cnpj = p_cnpj;
    COMMIT;
END $$

DELIMITER ;

--- Por email ---
USE sistema_bancario;
DROP PROCEDURE IF EXISTS consultarPJPorEmail;

CREATE PROCEDURE IF NOT EXISTS consultarPJPorEmail (
    IN p_email VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

SELECT *
FROM Clientes
    INNER JOIN Clientes_PJ
        ON Clientes.id = Clientes_PF.cliente_id
WHERE Clientes.email = p_email;
    COMMIT;
END $$

DELIMITER ;

--- Por ID ---
USE sistema_bancario;
DROP PROCEDURE IF EXISTS consultarPJPorId;

CREATE PROCEDURE IF NOT EXISTS consultarPJPorId (
    IN p_id VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

SELECT *
FROM Clientes
    INNER JOIN Clientes_PJ
        ON Clientes.id = Clientes_PJ.cliente_id
WHERE Clientes.id = p_id;
    COMMIT;
END $$

DELIMITER ;

------------------------------ Contas ------------------------------
----- Cadastrar -----
USE sistema_bancario;
DROP PROCEDURE IF EXISTS contas_cadastrar;
DELIMITER $$

CREATE PROCEDURE contas_cadastrar (
    IN p_cliente_id INT,
    IN p_tipo_conta ENUM('corrente', 'poupanca'),
    IN p_saldo DECIMAL(15,2),
    IN p_limite DECIMAL(15,2),
    IN p_status ENUM('ativa', 'inativa')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO Contas (cliente_id, tipo_conta, saldo, limite, status)
    VALUES (p_cliente_id, p_tipo_conta, p_saldo, p_limite, p_status);

    COMMIT;
END $$

DELIMITER ;

----- Alterar -----
USE sistema_bancario;
DROP PROCEDURE IF EXISTS conta_alterar;
DELIMITER $$
CREATE PROCEDURE conta_alterar (
    IN p_id INT,
    IN p_tipo_conta ENUM('corrente', 'poupanca'),
    IN p_saldo DECIMAL(15,2),
    IN p_limite DECIMAL(15,2),
    IN p_status ENUM('ativa', 'inativa')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE Contas
        SET tipo_conta = p_tipo_conta,
            saldo = p_saldo,
            limite = p_limite,
            status = p_status,
    WHERE id = p_id;

    COMMIT;
END $$

--- "Deletar" ---
USE sistema_bancario;
DROP PROCEDURE IF EXISTS conta_deletar;
DELIMITER $$
CREATE PROCEDURE conta_deletar (
    IN p_id INT,
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF (Contas.status == 'ativa')
    BEGIN
        UPDATE Contas
            SET status = 'inativa'
    END
    ELSE
    BEGIN
        UPDATE Contas
            SET status = 'ativa'
    END

    COMMIT;
END $$

DELIMITER ;

--- Por ID ---
USE sistema_bancario;
DROP PROCEDURE IF EXISTS consultarContaPorId;

CREATE PROCEDURE IF NOT EXISTS consultarContaPorId (
    IN p_id VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

SELECT *
FROM Contas
WHERE Contas.id = p_id;
    COMMIT;
END $$

DELIMITER ;

--- Por cliente ---
USE sistema_bancario;
DROP PROCEDURE IF EXISTS consultarPorCliente;

CREATE PROCEDURE IF NOT EXISTS consultarPorCliente (
    IN p_cliente_id
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

SELECT *
FROM Contas
    INNER JOIN Clientes
        ON Contas.cliente_id = Clientes.id
WHERE Contas.id = Clientes.id;
    COMMIT;
END $$

DELIMITER ;

------------------------------ Transações ------------------------------
----- Depositar -----
USE sistema_bancario;
DROP PROCEDURE IF EXISTS depositar;

CREATE PROCEDURE IF NOT EXISTS depositar (
    IN p_conta_id,
    IN p_data_transacao,
    IN p_tipo,
    IN p_valor,
    IN p_descricao
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

SELECT *
FROM Contas
    INNER JOIN Clientes
        ON Contas.cliente_id = Clientes.id
WHERE Contas.id = Clientes.id;
    COMMIT;
END $$

DELIMITER ;