-- Versión nueva construida bien desde el principio

-- 1. Crear la base de datos
CREATE DATABASE IF NOT EXISTS login
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 2. Seleccionar la base de datos
USE login;

-- 3. Crear la tabla 'roles'
CREATE TABLE IF NOT EXISTS `roles` (
    `id_rol` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `descripcion` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB;

-- 4. Crear la tabla 'usuarios'
CREATE TABLE IF NOT EXISTS `usuarios` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `correo` VARCHAR(100) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `id_rol` INT(10) UNSIGNED NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_usuarios_roles`
        FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5. Insertar datos en la tabla 'roles'
INSERT INTO `roles` (`descripcion`) VALUES
('admin'),
('usuario');

-- 6. Insertar datos en la tabla 'usuarios'
INSERT INTO `usuarios` (`correo`, `password`, `id_rol`) VALUES
('seba@seba.cl', '123456', 1),
('maca@maca.cl', 'qwerty', 2);

-- 7. Verificar las llaves foráneas y relaciones
SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    CONSTRAINT_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = 'login' 
    AND TABLE_NAME = 'usuarios'
    AND REFERENCED_TABLE_NAME IS NOT NULL;



-------------------------------------------------------------

-- Versión anterior cuando la construí parte por parte


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



-- Alterar la tabla, le agregamos una columna
ALTER TABLE `usuarios`
ADD COLUMN `id_rol` INT(11) NOT NULL;



CREATE TABLE `roles` (
    `id_rol` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    
    `descripcion` varchar(255) not NULL,
    
    `created_at` timestamp not NULL default current_timestamp,
    `updated_at` timestamp not NULL default current_timestamp,

    PRIMARY KEY (id_rol)
)
default CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;


-- Establecer id_rol como una llave foránea que referencia a id_rol de la tabla roles
ALTER TABLE `usuarios`
ADD CONSTRAINT `fk_usuarios_roles`
FOREIGN KEY (`id_rol`) REFERENCES `roles`(`id_rol`);


-- Modifica las características de una columna
ALTER TABLE `usuarios`
MODIFY `id_rol` INT(10) UNSIGNED NOT NULL;



-- Quede en que tengo que añadir roles al parecer y ahí mismo va al video

INSERT INTO `roles` (id_rol, descripcion) VALUES
("1", "admin"),
("2", "usuario");


SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    CONSTRAINT_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = 'login' 
    AND TABLE_NAME = 'usuarios'
    AND REFERENCED_TABLE_NAME IS NOT NULL;


ALTER TABLE `usuarios`
ADD CONSTRAINT `fk_usuarios_roles`
FOREIGN KEY (`id_rol`) REFERENCES `roles`(`id_rol`);