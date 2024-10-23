CREATE DATABASE login;

USE login;

CREATE TABLE `usuarios` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    
    `correo` varchar(100) not NULL,
    `password` varchar(255) not NULL,
    
    `created_at` timestamp not NULL default current_timestamp,
    `updated_at` timestamp not NULL default current_timestamp,

    PRIMARY KEY (id)
)

default CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;




-- Insertar 
USE login;

INSERT INTO `usuarios` (correo, password) VALUES
("seba@seba.cl", "123456");
