-- -------------------------------- --
-- Banco de dados 'blogMihaelis' --
-- -------------------------------- --

-- Apaga o banco de dados caso ele já exista. --
-- PERIGO! Não fçaa isso em modo de produção (i. e., quando o site estiver na internet) --

DROP DATABASE IF EXISTS blogMihaelis;

-- Cria o banco de dados novamente --
-- PERIGO! Não faça isso em modo de produção --
CREATE DATABASE blogMihaelis
    
    -- Usando o conjunto de caracteres UTF-8 --
    CHARACTER SET utf8mb4

    -- Buscas em UFT-8 e case insensitive --
    COLLATE utf8mb4_general_ci;

    -- Seleciona o banco de dados para os próximos comandos --
    USE blogMihaelis;

    -- Cria a tabela 'staff' --
    CREATE TABLE staff (
        sta_id INT PRIMARY KEY AUTO_INCREMENT,
        sta_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        sta_name VARCHAR(127) NOT NULL,
        sta_email VARCHAR(255) NOT NULL,
        sta_password VARCHAR(63) NOT NULL,
        sta_birth DATE NOT NULL,
        sta_description VARCHAR(255),
        sta_type ENUM('moderator', 'author', 'admin') DEFAULT 'moderator',
        sta_status ENUM('on', 'off', 'del') DEFAULT 'on'
    );

    CREATE TABLE article (
        art_id INT PRIMARY KEY AUTO_INCREMENT,
        art_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        art_title VARCHAR(127) NOT NULL,
        art_resume VARCHAR(255) NOT NULL,
        art_thumbnail VARCHAR(255) NOT NULL,
        art_content TEXT NOT NULL,
        art_view INT DEFAULT 0,
        art_author INT,
        art_status ENUM('on', 'off', 'del') DEFAULT 'on',
        -- Chave estrangeira para 'staff' 
        FOREIGN KEY (art_author) REFERENCES staff (sta_id)
    );

    CREATE TABLE comment (
        com_id INT PRIMARY KEY AUTO_INCREMENT,
        com_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        com_article INT NOT NULL,
        com_author_name VARCHAR(127) NOT NULL,
        com_author_email VARCHAR(255) NOT NULL,
        com_comment TEXT NOT NULL,
        com_status ENUM('on', 'off', 'del') DEFAULT 'on',
        -- Chave estrangeira para 'article'
        FOREIGN KEY (com_article) REFERENCES article (art_id)
    );

    -- Cria a tabela 'contact'
    CREATE TABLE contact (
        id INT PRIMARY KEY AUTO_INCREMENT,
        date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        name VARCHAR(127) NOT NULL,
        email VARCHAR(255) NOT NULL,
        subject VARCHAR(255) NOT NULL,
        message TEXT,
        status ENUM('received', 'responded', 'deleted') DEFAULT 'received'
    );