-- Creazione del database (opzionale)
CREATE DATABASE IF NOT EXISTS big_data_project;
USE big_data_project;

-- Creazione della tabella `employees`
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    position VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL
);

-- Creazione di una funzione per generare dati casuali
DELIMITER //

CREATE PROCEDURE GenerateEmployees(IN total_records INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < total_records DO
        INSERT INTO employees (first_name, last_name, date_of_birth, position, salary, hire_date)
        VALUES (
            CONCAT('FirstName_', i), -- Nome casuale
            CONCAT('LastName_', i),  -- Cognome casuale
            DATE_ADD('1960-01-01', INTERVAL FLOOR(RAND() * 20000) DAY), -- Data di nascita casuale
            ELT(FLOOR(1 + (RAND() * 5)), 'Software Engineer', 'Data Analyst', 'Project Manager', 'Quality Assurance', 'UX Designer'), -- Posizione casuale
            ROUND(50000 + RAND() * 50000, 2), -- Salario casuale tra 50.000 e 100.000
            DATE_ADD('2000-01-01', INTERVAL FLOOR(RAND() * 8000) DAY) -- Data di assunzione casuale
        );
        SET i = i + 1;
    END WHILE;
END;
//

DELIMITER ;

-- Generazione di 1.000 dipendenti
CALL GenerateEmployees(1000);

