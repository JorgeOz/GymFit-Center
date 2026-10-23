-- -----------------------------------------------------
-- PROYECTO INTERMODULAR - RETO 1
-- Autores: Pau Mayordomo Real & Jorge Ortiz Vilaplana
-- Base de Datos: GymFit (Estructura + 20 Registros/Tabla)
-- -----------------------------------------------------

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- ESTRUCTURA DE TABLAS (DDL)
-- -----------------------------------------------------

DROP TABLE IF EXISTS `tarifas_actividades` ;
CREATE TABLE IF NOT EXISTS `tarifas_actividades` (
  `id_tarifa_actividad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `precio` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id_tarifa_actividad`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `tipos_actividades` ;
CREATE TABLE IF NOT EXISTS `tipos_actividades` (
  `id_tipo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_tipo`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `actividades` ;
CREATE TABLE IF NOT EXISTS `actividades` (
  `id_actividad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 1,
  `descripcion` VARCHAR(250) NULL DEFAULT NULL,
  `Tipo_Actividad_id_tipo` INT NOT NULL,
  `Tarifa_Actividad_id_tarifa_actividad` INT NOT NULL,
  PRIMARY KEY (`id_actividad`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC),
  INDEX `fk_Actividad_Tipo_Actividad1_idx` (`Tipo_Actividad_id_tipo` ASC),
  INDEX `fk_Actividad_Tarifa_Actividad1_idx` (`Tarifa_Actividad_id_tarifa_actividad` ASC),
  CONSTRAINT `fk_Actividad_Tarifa_Actividad1`
    FOREIGN KEY (`Tarifa_Actividad_id_tarifa_actividad`)
    REFERENCES `tarifas_actividades` (`id_tarifa_actividad`),
  CONSTRAINT `fk_Actividad_Tipo_Actividad1`
    FOREIGN KEY (`Tipo_Actividad_id_tipo`)
    REFERENCES `tipos_actividades` (`id_tipo`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `gimnasios` ;
CREATE TABLE IF NOT EXISTS `gimnasios` (
  `id_gimnasio` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `ciudad` VARCHAR(50) NOT NULL,
  `direccion` VARCHAR(150) NOT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_gimnasio`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `roles` ;
CREATE TABLE IF NOT EXISTS `roles` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `usuarios` ;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `direccion` VARCHAR(150) NOT NULL,
  `dni` VARCHAR(9) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 1,
  `url_imagen` VARCHAR(255) NULL DEFAULT NULL,
  `fecha_alta` DATETIME NULL DEFAULT NULL,
  `fecha_ultima_modificacion` DATETIME NULL DEFAULT NULL,
  `tipo` VARCHAR(20) NULL DEFAULT NULL,
  `token_recuperacion` VARCHAR(255) NULL DEFAULT NULL,
  `expiracion_token` DATETIME NULL DEFAULT NULL,
  `Rol_id_rol` INT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC),
  INDEX `fk_Usuario_Rol_idx` (`Rol_id_rol` ASC),
  CONSTRAINT `fk_Usuario_Rol`
    FOREIGN KEY (`Rol_id_rol`)
    REFERENCES `roles` (`id_rol`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `empleados` ;
CREATE TABLE IF NOT EXISTS `empleados` (
  `id_usuario` INT NOT NULL,
  `nuss` VARCHAR(12) NOT NULL,
  `cargo` VARCHAR(50) NOT NULL,
  `turno` VARCHAR(20) NOT NULL,
  `Gimnasio_id_gimnasio` INT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `nss_UNIQUE` (`nuss` ASC),
  INDEX `fk_Empleado_Gimnasio1_idx` (`Gimnasio_id_gimnasio` ASC),
  INDEX `fk_Empleado_Usuario1_idx` (`id_usuario` ASC),
  CONSTRAINT `fk_Empleado_Gimnasio1`
    FOREIGN KEY (`Gimnasio_id_gimnasio`)
    REFERENCES `gimnasios` (`id_gimnasio`),
  CONSTRAINT `fk_Empleado_Usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuarios` (`id_usuario`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `auditoria_empleados` ;
CREATE TABLE IF NOT EXISTS `auditoria_empleados` (
  `id_log` INT NOT NULL AUTO_INCREMENT,
  `accion` VARCHAR(50) NOT NULL,
  `tabla_afectada` VARCHAR(50) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  `Empleados_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_log`),
  INDEX `fk_Auditoria_Empleados_Empleados1_idx` (`Empleados_id_usuario` ASC),
  CONSTRAINT `fk_Auditoria_Empleados_Empleados1`
    FOREIGN KEY (`Empleados_id_usuario`)
    REFERENCES `empleados` (`id_usuario`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `clientes` ;
CREATE TABLE IF NOT EXISTS `clientes` (
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_Cliente_Usuario1_idx` (`id_usuario` ASC),
  CONSTRAINT `fk_Cliente_Usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuarios` (`id_usuario`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `pagos` ;
CREATE TABLE IF NOT EXISTS `pagos` (
  `id_pago` INT NOT NULL AUTO_INCREMENT,
  `importe` DECIMAL(6,2) NOT NULL,
  `concepto` VARCHAR(50) NOT NULL,
  `fecha` DATE NOT NULL,
  `metodo` VARCHAR(45) NOT NULL,
  `clientes_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_pago`),
  INDEX `fk_pagos_clientes1_idx` (`clientes_id_usuario` ASC),
  CONSTRAINT `fk_pagos_clientes1`
    FOREIGN KEY (`clientes_id_usuario`)
    REFERENCES `clientes` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `bizums` ;
CREATE TABLE IF NOT EXISTS `bizums` (
  `num_telefono` VARCHAR(15) NOT NULL,
  `Pagos_id_pago` INT NOT NULL,
  PRIMARY KEY (`Pagos_id_pago`),
  INDEX `fk_Bizums_Pagos1_idx` (`Pagos_id_pago` ASC),
  CONSTRAINT `fk_Bizums_Pagos1`
    FOREIGN KEY (`Pagos_id_pago`)
    REFERENCES `pagos` (`id_pago`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `tipos_bonos` ;
CREATE TABLE IF NOT EXISTS `tipos_bonos` (
  `id_tipo_bono` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `clases_totales` INT NOT NULL,
  `dias_validez` INT NOT NULL,
  `precio` DECIMAL(6,2) NOT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 1,
  `descripcion` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipo_bono`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `bonos_clientes` ;
CREATE TABLE IF NOT EXISTS `bonos_clientes` (
  `id_bono` INT NOT NULL AUTO_INCREMENT,
  `clases_consumidas` INT NOT NULL DEFAULT 0,
  `estado` VARCHAR(20) NOT NULL,
  `fecha_compra` DATETIME NOT NULL,
  `fecha_caducidad` DATETIME NOT NULL,
  `Clientes_id_usuario` INT NOT NULL,
  `Pagos_id_pago` INT NOT NULL,
  `Tipos_Bonos_id_tipo_bono` INT NOT NULL,
  PRIMARY KEY (`id_bono`),
  INDEX `fk_Bonos_Clientes_Clientes1_idx` (`Clientes_id_usuario` ASC),
  INDEX `fk_Bonos_Clientes_Pagos1_idx` (`Pagos_id_pago` ASC),
  INDEX `fk_Bonos_Clientes_Tipos_Bonos1_idx` (`Tipos_Bonos_id_tipo_bono` ASC),
  CONSTRAINT `fk_Bonos_Clientes_Clientes1`
    FOREIGN KEY (`Clientes_id_usuario`)
    REFERENCES `clientes` (`id_usuario`),
  CONSTRAINT `fk_Bonos_Clientes_Pagos1`
    FOREIGN KEY (`Pagos_id_pago`)
    REFERENCES `pagos` (`id_pago`),
  CONSTRAINT `fk_Bonos_Clientes_Tipos_Bonos1`
    FOREIGN KEY (`Tipos_Bonos_id_tipo_bono`)
    REFERENCES `tipos_bonos` (`id_tipo_bono`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `efectivos` ;
CREATE TABLE IF NOT EXISTS `efectivos` (
  `cambio` DECIMAL(6,2) NOT NULL,
  `Pago_id_pago` INT NOT NULL,
  PRIMARY KEY (`Pago_id_pago`),
  CONSTRAINT `fk_Efectivo_Pago1`
    FOREIGN KEY (`Pago_id_pago`)
    REFERENCES `pagos` (`id_pago`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `pedidos` ;
CREATE TABLE IF NOT EXISTS `pedidos` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(20) NOT NULL,
  `fecha_pedido` DATETIME NOT NULL,
  `total_pedido` DECIMAL(6,2) NOT NULL,
  `Clientes_id_usuario` INT NOT NULL,
  `Pagos_id_pago` INT NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_Pedidos_Clientes1_idx` (`Clientes_id_usuario` ASC),
  INDEX `fk_Pedidos_Pagos1_idx` (`Pagos_id_pago` ASC),
  CONSTRAINT `fk_Pedidos_Clientes1`
    FOREIGN KEY (`Clientes_id_usuario`)
    REFERENCES `clientes` (`id_usuario`),
  CONSTRAINT `fk_Pedidos_Pagos1`
    FOREIGN KEY (`Pagos_id_pago`)
    REFERENCES `pagos` (`id_pago`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `productos` ;
CREATE TABLE IF NOT EXISTS `productos` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `precio` DECIMAL(6,2) NOT NULL,
  `cantidad` INT NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  `url_imagen` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_producto`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `pedidos_productos` ;
CREATE TABLE IF NOT EXISTS `pedidos_productos` (
  `Pedido_id_pedido` INT NOT NULL,
  `Producto_id_producto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`Pedido_id_pedido`, `Producto_id_producto`),
  INDEX `fk_Pedido_has_Productos_Productos1_idx` (`Producto_id_producto` ASC),
  INDEX `fk_Pedido_has_Productos_Pedido1_idx` (`Pedido_id_pedido` ASC),
  CONSTRAINT `fk_Pedido_has_Productos_Pedido1`
    FOREIGN KEY (`Pedido_id_pedido`)
    REFERENCES `pedidos` (`id_pedido`),
  CONSTRAINT `fk_Pedido_has_Productos_Productos1`
    FOREIGN KEY (`Producto_id_producto`)
    REFERENCES `productos` (`id_producto`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `permisos` ;
CREATE TABLE IF NOT EXISTS `permisos` (
  `id_permiso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`id_permiso`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `salas` ;
CREATE TABLE IF NOT EXISTS `salas` (
  `id_sala` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `aforo` INT NOT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 1,
  `Gimnasio_id_gimnasio` INT NOT NULL,
  PRIMARY KEY (`id_sala`),
  INDEX `fk_Sala_Gimnasio1_idx` (`Gimnasio_id_gimnasio` ASC),
  CONSTRAINT `fk_Sala_Gimnasio1`
    FOREIGN KEY (`Gimnasio_id_gimnasio`)
    REFERENCES `gimnasios` (`id_gimnasio`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `sesiones` ;
CREATE TABLE IF NOT EXISTS `sesiones` (
  `id_sesion` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `duracion` INT NOT NULL,
  `plazas_totales` INT NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  `Actividad_id_actividad` INT NOT NULL,
  `Empleado_id_usuario` INT NOT NULL,
  `Sala_id_sala` INT NOT NULL,
  PRIMARY KEY (`id_sesion`),
  INDEX `fk_Sesion_Actividad1_idx` (`Actividad_id_actividad` ASC),
  INDEX `fk_Sesion_Empleado1_idx` (`Empleado_id_usuario` ASC),
  INDEX `fk_Sesion_Sala1_idx` (`Sala_id_sala` ASC),
  CONSTRAINT `fk_Sesion_Actividad1`
    FOREIGN KEY (`Actividad_id_actividad`)
    REFERENCES `actividades` (`id_actividad`),
  CONSTRAINT `fk_Sesion_Empleado1`
    FOREIGN KEY (`Empleado_id_usuario`)
    REFERENCES `empleados` (`id_usuario`),
  CONSTRAINT `fk_Sesion_Sala1`
    FOREIGN KEY (`Sala_id_sala`)
    REFERENCES `salas` (`id_sala`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `reservas` ;
CREATE TABLE IF NOT EXISTS `reservas` (
  `id_reserva` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  `Sesion_id_sesion` INT NOT NULL,
  `Cliente_id_usuario` INT NOT NULL,
  `Bonos_Clientes_id_bono` INT NULL DEFAULT NULL,
  `Pagos_id_pago` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_reserva`),
  INDEX `fk_Reserva_Sesion1_idx` (`Sesion_id_sesion` ASC),
  INDEX `fk_Reserva_Cliente1_idx` (`Cliente_id_usuario` ASC),
  INDEX `fk_Reservas_Bonos_Clientes1_idx` (`Bonos_Clientes_id_bono` ASC),
  INDEX `fk_Reservas_Pagos1_idx` (`Pagos_id_pago` ASC),
  CONSTRAINT `fk_Reserva_Cliente1`
    FOREIGN KEY (`Cliente_id_usuario`)
    REFERENCES `clientes` (`id_usuario`),
  CONSTRAINT `fk_Reserva_Sesion1`
    FOREIGN KEY (`Sesion_id_sesion`)
    REFERENCES `sesiones` (`id_sesion`),
  CONSTRAINT `fk_Reservas_Bonos_Clientes1`
    FOREIGN KEY (`Bonos_Clientes_id_bono`)
    REFERENCES `bonos_clientes` (`id_bono`),
  CONSTRAINT `fk_Reservas_Pagos1`
    FOREIGN KEY (`Pagos_id_pago`)
    REFERENCES `pagos` (`id_pago`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `roles_permisos` ;
CREATE TABLE IF NOT EXISTS `roles_permisos` (
  `Rol_id_rol` INT NOT NULL,
  `Permiso_id_permiso` INT NOT NULL,
  PRIMARY KEY (`Rol_id_rol`, `Permiso_id_permiso`),
  INDEX `fk_Rol_has_Permisos_Permisos1_idx` (`Permiso_id_permiso` ASC),
  INDEX `fk_Rol_has_Permisos_Rol1_idx` (`Rol_id_rol` ASC),
  CONSTRAINT `fk_Rol_has_Permisos_Permisos1`
    FOREIGN KEY (`Permiso_id_permiso`)
    REFERENCES `permisos` (`id_permiso`),
  CONSTRAINT `fk_Rol_has_Permisos_Rol1`
    FOREIGN KEY (`Rol_id_rol`)
    REFERENCES `roles` (`id_rol`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `tipos_suscripciones` ;
CREATE TABLE IF NOT EXISTS `tipos_suscripciones` (
  `id_tipo_suscripcion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `dias_validez` INT NOT NULL,
  `precio` DECIMAL(6,2) NOT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 1,
  `descripcion` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipo_suscripcion`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `suscripciones` ;
CREATE TABLE IF NOT EXISTS `suscripciones` (
  `id_suscripcion` INT NOT NULL AUTO_INCREMENT,
  `fecha_inicio` DATETIME NOT NULL,
  `fecha_fin` DATETIME NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  `Tipo_Suscripcion_id_tipo_suscripcion` INT NOT NULL,
  `Cliente_id_usuario` INT NOT NULL,
  `Pagos_id_pago` INT NOT NULL,
  PRIMARY KEY (`id_suscripcion`),
  INDEX `fk_Suscripcion_Tipo_Suscripcion1_idx` (`Tipo_Suscripcion_id_tipo_suscripcion` ASC),
  INDEX `fk_Suscripcion_Cliente1_idx` (`Cliente_id_usuario` ASC),
  INDEX `fk_Suscripciones_Pagos1_idx` (`Pagos_id_pago` ASC),
  CONSTRAINT `fk_Suscripcion_Cliente1`
    FOREIGN KEY (`Cliente_id_usuario`)
    REFERENCES `clientes` (`id_usuario`),
  CONSTRAINT `fk_Suscripcion_Tipo_Suscripcion1`
    FOREIGN KEY (`Tipo_Suscripcion_id_tipo_suscripcion`)
    REFERENCES `tipos_suscripciones` (`id_tipo_suscripcion`),
  CONSTRAINT `fk_Suscripciones_Pagos1`
    FOREIGN KEY (`Pagos_id_pago`)
    REFERENCES `pagos` (`id_pago`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `tarjetas` ;
CREATE TABLE IF NOT EXISTS `tarjetas` (
  `num_tarjeta` VARCHAR(20) NOT NULL,
  `Pago_id_pago` INT NOT NULL,
  PRIMARY KEY (`num_tarjeta`, `Pago_id_pago`),
  INDEX `fk_Tarjeta_Pago1_idx` (`Pago_id_pago` ASC),
  CONSTRAINT `fk_Tarjeta_Pago1`
    FOREIGN KEY (`Pago_id_pago`)
    REFERENCES `pagos` (`id_pago`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


DROP TABLE IF EXISTS `transferencias` ;
CREATE TABLE IF NOT EXISTS `transferencias` (
  `num_cuenta` VARCHAR(34) NOT NULL,
  `Pago_id_pago` INT NOT NULL,
  PRIMARY KEY (`num_cuenta`, `Pago_id_pago`),
  INDEX `fk_Transferencia_Pago1_idx` (`Pago_id_pago` ASC),
  CONSTRAINT `fk_Transferencia_Pago1`
    FOREIGN KEY (`Pago_id_pago`)
    REFERENCES `pagos` (`id_pago`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- INSERCIÓN DE DATOS (DML - 20 Filas por tabla)
-- -----------------------------------------------------

-- 1. ROLES, PERMISOS Y ROLES_PERMISOS
INSERT INTO `roles` (`id_rol`, `nombre`, `descripcion`) VALUES 
(1, 'Administrador', 'Control total del sistema y facturación'),
(2, 'Gerente', 'Gestión de un centro específico'),
(3, 'Recepcionista', 'Atención al cliente y cobros en mostrador'),
(4, 'Entrenador Personal', 'Clases 1 a 1 y asesoría'),
(5, 'Monitor Sala', 'Supervisión de sala de musculación'),
(6, 'Nutricionista', 'Planes de alimentación deportiva'),
(7, 'Fisioterapeuta', 'Rehabilitación y masajes'),
(8, 'Limpieza', 'Mantenimiento de instalaciones'),
(9, 'Seguridad', 'Control de accesos y aforos'),
(10, 'Marketing', 'Gestión de redes y campañas'),
(11, 'RRHH', 'Contratación y nóminas'),
(12, 'Contable', 'Gestión financiera'),
(13, 'Mantenimiento', 'Reparación de máquinas técnicas'),
(14, 'Director Deportivo', 'Planificación de rutinas y horarios'),
(15, 'Socorrista', 'Vigilancia en zona de aguas'),
(16, 'Médico', 'Revisiones y certificados deportivos'),
(17, 'Becario DAM', 'Soporte informático y BBDD'),
(18, 'Instructor Posing', 'Técnica de competición culturismo'),
(19, 'Community Manager', 'Atención en plataformas digitales'),
(20, 'Cliente', 'Usuario estándar de la aplicación');

INSERT INTO `permisos` (`id_permiso`, `nombre`, `descripcion`) VALUES 
(1, 'ALL_ACCESS', 'Acceso a todo el sistema'),
(2, 'GESTION_USUARIOS', 'Crear y editar usuarios'),
(3, 'COBRO_CUOTAS', 'Cobrar suscripciones y bonos'),
(4, 'VER_FINANZAS', 'Acceso a reportes económicos'),
(5, 'CREAR_SESION', 'Añadir clases al calendario'),
(6, 'EDITAR_RUTINAS', 'Modificar planes de entrenamiento'),
(7, 'ABRIR_CAJA', 'Inicio de turno en recepción'),
(8, 'CERRAR_CAJA', 'Cierre y cuadre diario'),
(9, 'RESERVAR_APP', 'Permiso para reservar clases (clientes)'),
(10, 'MODIFICAR_PERFIL', 'Permiso para editar datos propios'),
(11, 'VER_HISTORIAL_MEDICO', 'Acceso a lesiones de clientes'),
(12, 'ANULAR_RESERVA', 'Cancelar asistencia a sesión'),
(13, 'APLICAR_DESCUENTO', 'Añadir promociones en cobros'),
(14, 'BLOQUEAR_TORNO', 'Control físico de acceso al local'),
(15, 'VER_NOMINAS', 'Acceso a salarios y contratos'),
(16, 'ACCESO_LOGS', 'Revisar la tabla de auditoría'),
(17, 'COMPRAR_TIENDA', 'Comprar productos físicos'),
(18, 'CONTROL_STOCK', 'Modificar inventario'),
(19, 'ENVIAR_NEWSLETTER', 'Envío masivo de correos'),
(20, 'ASIGNAR_ROLES', 'Cambiar roles de empleados');

INSERT INTO `roles_permisos` (`Rol_id_rol`, `Permiso_id_permiso`) VALUES 
(1, 1), (1, 2), (1, 3), (1, 4), (1, 16),
(2, 2), (2, 5), (2, 7), (2, 8), (2, 18),
(3, 3), (3, 7), (3, 8), (3, 17), (4, 5),
(4, 6), (4, 11), (20, 9), (20, 10), (20, 12);


-- 2. GIMNASIOS Y SALAS
INSERT INTO `gimnasios` (`id_gimnasio`, `nombre`, `ciudad`, `direccion`, `activo`) VALUES 
(1, 'GymFit Paterna Principal', 'Paterna', 'Santa Rita, Av. Europa 22', 1),
(2, 'IES Henri Matisse Gym', 'Paterna', 'Instalaciones del instituto', 1),
(3, 'GymFit Center Sur', 'Valencia', 'Centro Comercial MN4', 1),
(4, 'Golds Gym Venice', 'Los Angeles', '320 Hampton Dr, Venice', 1),
(5, 'Metroflex Gym', 'Arlington', '201 E Division St', 1),
(6, 'Oxygen Gym', 'Kuwait', 'Jabriya, Kuwait City', 1),
(7, 'Powerhouse Gym', 'Tampa', '1000 W Kennedy Blvd', 1),
(8, 'Bev Francis Powerhouse', 'Syosset', '235 Robbins Ln', 1),
(9, 'Titan Fitness', 'Sydney', '1/29-31 ORiordan St', 1),
(10, 'Muscle Beach', 'Santa Monica', 'Ocean Front Walk', 1),
(11, 'Temple Gym', 'Birmingham', '11-12 Hurst St', 1),
(12, 'Westside Barbell', 'Columbus', 'Localizacion Secreta', 1),
(13, 'Iron Addicts Gym', 'Miami', '31 NE 17th St', 1),
(14, 'City Athletic Club', 'Las Vegas', '7980 W Sahara Ave', 1),
(15, 'Quads Gym', 'Chicago', '3727 N Broadway', 1),
(16, 'Alphalete Gym', 'Houston', '1302 Texas Pkwy', 1),
(17, 'Zoo Culture', 'Woodland Hills', '20725 Erwin St', 1),
(18, 'Binous Gym', 'Dubai', 'Al Quoz Industrial Area 3', 1),
(19, 'McFit Paterna', 'Paterna', 'Poligono Industrial', 1),
(20, 'Synergym Valencia', 'Valencia', 'Carrer Major 15', 1);

INSERT INTO `salas` (`id_sala`, `nombre`, `aforo`, `activo`, `Gimnasio_id_gimnasio`) VALUES 
(1, 'Musculación Principal', 150, 1, 1),
(2, 'Zona Peso Libre', 50, 1, 1),
(3, 'Sala Cardio', 60, 1, 1),
(4, 'Sala Crossfit', 40, 1, 1),
(5, 'Sala Spinning', 30, 1, 1),
(6, 'Sala Colectivas A', 40, 1, 1),
(7, 'Sala Colectivas B', 30, 1, 2),
(8, 'Tatami Artes Marciales', 25, 1, 2),
(9, 'Zona Estiramientos', 15, 1, 2),
(10, 'Piscina Climatizada', 50, 1, 3),
(11, 'Sala Posing', 10, 1, 3),
(12, 'Zona Halterofilia', 20, 1, 3),
(13, 'Pista Padel 1', 4, 1, 4),
(14, 'Pista Padel 2', 4, 1, 4),
(15, 'Sala Rehabilitación', 5, 1, 5),
(16, 'Despacho Nutrición', 3, 1, 5),
(17, 'Calistenia Outdoor', 30, 1, 6),
(18, 'Ring Boxeo', 10, 1, 6),
(19, 'Sauna', 8, 1, 7),
(20, 'Sala VIP PT', 5, 1, 7);


-- 3. ACTIVIDADES Y TARIFAS
INSERT INTO `tipos_actividades` (`id_tipo`, `nombre`) VALUES 
(1, 'Musculación Libre'), (2, 'Crossfit'), (3, 'Halterofilia'), (4, 'Powerlifting'),
(5, 'Yoga Vinyasa'), (6, 'Pilates Suelo'), (7, 'Zumba Fitness'), (8, 'Spinning'),
(9, 'Body Pump'), (10, 'Body Combat'), (11, 'Boxeo'), (12, 'Artes Marciales (MMA)'),
(13, 'Natación'), (14, 'Aquagym'), (15, 'Calistenia'), (16, 'Entrenamiento Funcional'),
(17, 'Estiramientos'), (18, 'Gimnasia Rítmica'), (19, 'Posing Competición'), (20, 'Rehabilitación');

INSERT INTO `tarifas_actividades` (`id_tarifa_actividad`, `nombre`, `precio`) VALUES 
(1, 'Tarifa Zero (Gratis)', 0.00), (2, 'Clase Suelta Básica', 5.00),
(3, 'Clase Suelta Premium', 8.50), (4, 'Clase VIP', 12.00),
(5, 'Bono 5 Básicas', 20.00), (6, 'Bono 10 Básicas', 35.00),
(7, 'Bono 20 Básicas', 60.00), (8, 'Bono 5 Premium', 35.00),
(9, 'Bono 10 Premium', 65.00), (10, 'Bono 20 Premium', 110.00),
(11, 'Sesión PT 1h', 30.00), (12, 'Bono 5 PT', 135.00),
(13, 'Bono 10 PT', 250.00), (14, 'Sesión Nutrición', 40.00),
(15, 'Sesión Fisioterapia', 45.00), (16, 'Masterclass Posing', 15.00),
(17, 'Suplemento Piscina', 20.00), (18, 'Suplemento Crossfit', 25.00),
(19, 'Pista Padel 1.5h', 12.00), (20, 'Bono 10 Padel', 100.00);

INSERT INTO `actividades` (`id_actividad`, `nombre`, `activo`, `descripcion`, `Tipo_Actividad_id_tipo`, `Tarifa_Actividad_id_tarifa_actividad`) VALUES 
(1, 'Iniciación Musculación', 1, 'Técnica básica', 1, 1),
(2, 'Zumba Party', 1, 'Baile latino', 7, 2),
(3, 'Spinning Montaña', 1, 'Simulación subidas', 8, 2),
(4, 'Crossfit WOD', 1, 'Entreno del día', 2, 3),
(5, 'Yoga Amanecer', 1, 'Empezar con energía', 5, 2),
(6, 'Pilates Core', 1, 'Fuerza abdominal', 6, 2),
(7, 'Body Pump Total', 1, 'Pesas con música', 9, 2),
(8, 'Body Combat Extreme', 1, 'Cardio marcial', 10, 2),
(9, 'Boxeo Technique', 1, 'Golpeo en saco', 11, 3),
(10, 'Masterclass Glúteos', 1, 'Tren inferior', 1, 16),
(11, 'AquaFitness', 1, 'Piscina sin impacto', 14, 2),
(12, 'TRX Suspensión', 1, 'Fuerza corporal', 16, 3),
(13, 'Movilidad Activa', 1, 'Recuperación', 17, 1),
(14, 'Calistenia Avanzada', 1, 'Trucos en barra', 15, 3),
(15, 'Clínic Powerlifting', 1, 'Mejora de básicos', 4, 4),
(16, 'MMA Sparring', 1, 'Combate controlado', 12, 3),
(17, 'Halterofilia Olímpica', 1, 'Técnica arrancada', 3, 3),
(18, 'Entrenamiento VIP', 1, 'Sesión 1 a 1', 1, 11),
(19, 'Asesoría Nutricional', 1, 'Dieta personalizada', 1, 14),
(20, 'Fisioterapia Descarga', 1, 'Masaje deportivo', 20, 15);


-- 4. USUARIOS (Administradores, Empleados y Clientes)
INSERT INTO `usuarios` (`id_usuario`, `nombre`, `apellidos`, `fecha_nacimiento`, `telefono`, `direccion`, `dni`, `email`, `password`, `activo`, `Rol_id_rol`) VALUES 
(1, 'Pau', 'Mayordomo Real', '2000-01-01', '600100100', 'Santa Rita, Paterna', '11111111A', 'pau@gymfit.com', 'hash123', 1, 1),
(2, 'Jorge', 'Ortiz Vilaplana', '2000-02-02', '600200200', 'Santa Rita, Paterna', '22222222B', 'jorge@gymfit.com', 'hash123', 1, 1),
(3, 'Chris', 'Bumstead', '1995-02-02', '600300300', 'Ottawa, Canada', '33333333C', 'cbum@gymfit.com', 'hash123', 1, 4),
(4, 'Ramon', 'Dino', '1995-02-09', '600400400', 'Acre, Brasil', '44444444D', 'ramon@gymfit.com', 'hash123', 1, 4),
(5, 'Urs', 'Kalecinski', '1998-04-30', '600500500', 'Stuttgart, Germany', '55555555E', 'urs@gymfit.com', 'hash123', 1, 4),
(6, 'Joan', 'Pradells', '1996-12-10', '600600600', 'Valencia, Spain', '66666666F', 'joan@gymfit.com', 'hash123', 1, 4),
(7, 'Noel', 'Deyzel', '1984-09-30', '600700700', 'Johannesburg, SA', '77777777G', 'noel@gymfit.com', 'hash123', 1, 4),
(8, 'Larry', 'Wheels', '1994-12-03', '600800800', 'Bronx, NY', '88888888H', 'larry@gymfit.com', 'hash123', 1, 4),
(9, 'Brian', 'Shaw', '1982-02-26', '600900900', 'Fort Lupton, CO', '99999999I', 'brian@gymfit.com', 'hash123', 1, 5),
(10, 'Hafthor', 'Bjornsson', '1988-11-26', '601000000', 'Reykjavik, Iceland', '10101010J', 'hafthor@gymfit.com', 'hash123', 1, 5),
(11, 'Eddie', 'Hall', '1988-01-15', '601100100', 'Staffordshire, UK', '12121212K', 'eddie@gymfit.com', 'hash123', 1, 5),
(12, 'Jay', 'Cutler', '1973-08-03', '601200200', 'Las Vegas, NV', '13131313L', 'jay@gymfit.com', 'hash123', 1, 14),
(13, 'Dorian', 'Yates', '1962-04-19', '601300300', 'Birmingham, UK', '14141414M', 'dorian@gymfit.com', 'hash123', 1, 14),
(14, 'Lee', 'Haney', '1959-11-11', '601400400', 'Atlanta, GA', '15151515N', 'lee@gymfit.com', 'hash123', 1, 2),
(15, 'Phil', 'Heath', '1979-12-18', '601500500', 'Seattle, WA', '16161616O', 'phil@gymfit.com', 'hash123', 1, 2),
(16, 'Franco', 'Columbu', '1941-08-07', '601600600', 'Sardinia, Italy', '17171717P', 'franco@gymfit.com', 'hash123', 1, 16),
(17, 'Dexter', 'Jackson', '1969-11-25', '601700700', 'Jacksonville, FL', '18181818Q', 'dexter@gymfit.com', 'hash123', 1, 3),
(18, 'Shawn', 'Rhoden', '1975-04-02', '601800800', 'Kingston, Jamaica', '19191919R', 'shawn@gymfit.com', 'hash123', 1, 3),
(19, 'Big', 'Ramy', '1984-09-16', '601900900', 'Baltim, Egypt', '20202020S', 'ramy@gymfit.com', 'hash123', 1, 3),
(20, 'Hadi', 'Choopan', '1987-09-26', '602000000', 'Fars, Iran', '21212121T', 'hadi@gymfit.com', 'hash123', 1, 13),
(21, 'Arnold', 'Schwarzenegger', '1947-07-30', '602100100', 'Gold Coast 1', '23232323U', 'arnold@cliente.com', 'hash123', 1, 20),
(22, 'Ronnie', 'Coleman', '1964-05-13', '602200200', 'Texas Avenue 2', '24242424V', 'ronnie@cliente.com', 'hash123', 1, 20),
(23, 'Flex', 'Wheeler', '1965-08-23', '602300300', 'Vegas Strip 3', '25252525W', 'flex@cliente.com', 'hash123', 1, 20),
(24, 'Kevin', 'Levrone', '1964-07-16', '602400400', 'Maryland Ave 4', '26262626X', 'kevin@cliente.com', 'hash123', 1, 20),
(25, 'Markus', 'Ruhl', '1972-02-22', '602500500', 'Germany St 5', '27272727Y', 'markus@cliente.com', 'hash123', 1, 20),
(26, 'Roelly', 'Winklaar', '1977-06-22', '602600600', 'Curacao 6', '28282828Z', 'roelly@cliente.com', 'hash123', 1, 20),
(27, 'Kai', 'Greene', '1975-07-12', '602700700', 'Brooklyn 7', '29292929A', 'kai@cliente.com', 'hash123', 1, 20),
(28, 'Samson', 'Dauda', '1992-03-11', '602800800', 'London Eye 8', '30303030B', 'samson@cliente.com', 'hash123', 1, 20),
(29, 'Hunter', 'Labrada', '1992-05-17', '602900900', 'Texas Pkwy 9', '31313131C', 'hunter@cliente.com', 'hash123', 1, 20),
(30, 'Nick', 'Walker', '1994-08-03', '603000000', 'New Jersey 10', '32323232D', 'nick@cliente.com', 'hash123', 1, 20),
(31, 'Derek', 'Lunsford', '1993-05-14', '603100100', 'Florida St 11', '34343434E', 'derek@cliente.com', 'hash123', 1, 20),
(32, 'Andrew', 'Jacked', '1985-01-01', '603200200', 'Dubai 12', '35353535F', 'andrew@cliente.com', 'hash123', 1, 20),
(33, 'Michal', 'Krizo', '1990-07-15', '603300300', 'Slovakia 13', '36363636G', 'michal@cliente.com', 'hash123', 1, 20),
(34, 'William', 'Bonac', '1982-05-18', '603400400', 'Netherlands 14', '37373737H', 'william@cliente.com', 'hash123', 1, 20),
(35, 'Iain', 'Valliere', '1990-11-27', '603500500', 'Canada 15', '38383838I', 'iain@cliente.com', 'hash123', 1, 20),
(36, 'Akim', 'Williams', '1984-06-19', '603600600', 'New York 16', '39393939J', 'akim@cliente.com', 'hash123', 1, 20),
(37, 'Charles', 'Griffen', '1982-02-22', '603700700', 'Minnesota 17', '40404040K', 'charles@cliente.com', 'hash123', 1, 20),
(38, 'Justin', 'Rodriguez', '1990-04-12', '603800800', 'New York 18', '41414141L', 'justin@cliente.com', 'hash123', 1, 20),
(39, 'Hassan', 'Mostafa', '1992-01-01', '603900900', 'Egypt 19', '42424242M', 'hassan@cliente.com', 'hash123', 1, 20),
(40, 'Sergio', 'Oliva Jr', '1984-10-20', '604000000', 'Chicago 20', '43434343N', 'sergio@cliente.com', 'hash123', 1, 20);

INSERT INTO `empleados` (`id_usuario`, `nuss`, `cargo`, `turno`, `Gimnasio_id_gimnasio`) VALUES 
(1, '111111111111', 'Administrador BD', 'Mañana', 1),
(2, '222222222222', 'CEO / Developer', 'Mañana', 1),
(3, '333333333333', 'Entrenador Élite', 'Tarde', 1),
(4, '444444444444', 'Monitor Posing', 'Partido', 1),
(5, '555555555555', 'Entrenador Personal', 'Mañana', 2),
(6, '666666666666', 'Monitor Sala', 'Tarde', 2),
(7, '777777777777', 'Nutricionista', 'Partido', 3),
(8, '888888888888', 'Entrenador Fuerza', 'Mañana', 3),
(9, '999999999999', 'Strongman Coach', 'Tarde', 4),
(10, '101010101010', 'Monitor Sala', 'Partido', 4),
(11, '111111111112', 'Coach Powerlifting', 'Mañana', 5),
(12, '121212121212', 'Director Deportivo', 'Mañana', 6),
(13, '131313131313', 'Director Técnico', 'Partido', 7),
(14, '141414141414', 'Gerente', 'Mañana', 8),
(15, '151515151515', 'Gerente', 'Tarde', 9),
(16, '161616161616', 'Médico Deportivo', 'Partido', 1),
(17, '171717171717', 'Recepcionista', 'Mañana', 1),
(18, '181818181818', 'Recepcionista', 'Tarde', 2),
(19, '191919191919', 'Recepcionista', 'Noche', 3),
(20, '202020202020', 'Mantenimiento', 'Mañana', 4);

INSERT INTO `clientes` (`id_usuario`) VALUES 
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30),
(31), (32), (33), (34), (35), (36), (37), (38), (39), (40);


-- 5. PAGOS Y FACTURACIÓN
INSERT INTO `pagos` (`id_pago`, `importe`, `concepto`, `fecha`, `metodo`, `clientes_id_usuario`) VALUES 
(1, 45.99, 'Mensualidad Estándar', '2026-03-01', 'Tarjeta', 21),
(2, 25.50, 'Bono 5 Clases', '2026-03-01', 'Tarjeta', 22),
(3, 30.00, 'Mensualidad Básica', '2026-03-02', 'Tarjeta', 23),
(4, 19.99, 'Compra Tienda', '2026-03-02', 'Tarjeta', 24),
(5, 44.00, 'Mensualidad VIP', '2026-03-03', 'Tarjeta', 25),
(6, 29.99, 'Mensualidad Estándar', '2026-01-01', 'Efectivo', 26),
(7, 39.99, 'Bono 10 Clases', '2026-01-15', 'Efectivo', 27),
(8, 59.99, 'Mensualidad Premium', '2026-02-01', 'Efectivo', 28),
(9, 99.99, 'Trimestral Básica', '2026-02-10', 'Efectivo', 29),
(10, 299.99, 'Anual VIP', '2026-01-01', 'Efectivo', 30),
(11, 8.50, 'Compra Tienda', '2026-02-28', 'Transferencia', 31),
(12, 5.00, 'Compra Tienda', '2026-02-28', 'Transferencia', 32),
(13, 8.50, 'Reserva Padel', '2026-03-01', 'Transferencia', 33),
(14, 12.00, 'Bono 5 Premium', '2026-03-02', 'Transferencia', 34),
(15, 5.00, 'Compra Tienda', '2026-03-01', 'Transferencia', 35),
(16, 35.00, 'Mensualidad Básica', '2026-01-01', 'Bizum', 36),
(17, 20.00, 'Bono 5 Clases', '2026-01-15', 'Bizum', 37),
(18, 65.00, 'Mensualidad Premium', '2026-02-01', 'Bizum', 38),
(19, 110.00, 'Bono 20 VIP', '2026-02-10', 'Bizum', 39),
(20, 5.00, 'Compra Tienda', '2026-03-01', 'Bizum', 40);

INSERT INTO `tarjetas` (`num_tarjeta`, `Pago_id_pago`) VALUES 
('****-1111', 1), ('****-1112', 2), ('****-1113', 3), ('****-1114', 4), ('****-1115', 5);

INSERT INTO `efectivos` (`cambio`, `Pago_id_pago`) VALUES 
(0.01, 6), (10.01, 7), (0.01, 8), (0.01, 9), (0.01, 10);

INSERT INTO `transferencias` (`num_cuenta`, `Pago_id_pago`) VALUES 
('ES9121001', 11), ('ES9121002', 12), ('ES9121003', 13), ('ES9121004', 14), ('ES9121005', 15);

INSERT INTO `bizums` (`num_telefono`, `Pagos_id_pago`) VALUES 
('600000036', 16), ('600000037', 17), ('600000038', 18), ('600000039', 19), ('600000040', 20);


-- 6. TIENDA (PRODUCTOS Y PEDIDOS)
INSERT INTO `productos` (`id_producto`, `precio`, `cantidad`, `descripcion`, `url_imagen`) VALUES 
(1, 45.99, 100, 'Whey Protein Optimum Nutrition', NULL),
(2, 25.50, 150, 'Creatina Monohidrato Creapure', NULL),
(3, 30.00, 80, 'Pre-entreno C4 Original', NULL),
(4, 19.99, 200, 'BCAA Xtend Sandia', NULL),
(5, 22.00, 50, 'Glutamina 300g', NULL),
(6, 2.50, 500, 'Barrita Proteica Barebells', NULL),
(7, 1.50, 600, 'Bebida Monster Zero', NULL),
(8, 8.99, 120, 'Shaker Oficial GymFit', NULL),
(9, 15.00, 90, 'Camiseta Tirantes Stringer', NULL),
(10, 45.00, 30, 'Cinturon Cuero RDX', NULL),
(11, 12.50, 100, 'Straps Peso Muerto', NULL),
(12, 65.00, 20, 'Rodilleras SBD Powerlifting', NULL),
(13, 18.00, 80, 'Muñequeras Inzer', NULL),
(14, 9.50, 150, 'Magnesio Liquido', NULL),
(15, 6.00, 300, 'Toalla Microfibra GymFit', NULL),
(16, 5.50, 200, 'Candado Taquilla', NULL),
(17, 14.99, 100, 'Multivitamínico Animal Pak', NULL),
(18, 19.90, 85, 'Omega 3 Aceite Pescado', NULL),
(19, 24.00, 60, 'Caseina Micelar Nocturna', NULL),
(20, 1.00, 1000, 'Botella Agua Mineral 1.5L', NULL);

INSERT INTO `pedidos` (`id_pedido`, `estado`, `fecha_pedido`, `total_pedido`, `Clientes_id_usuario`, `Pagos_id_pago`) VALUES 
(1, 'Entregado', '2026-03-01 10:15:00', 45.99, 21, 1),
(2, 'Entregado', '2026-03-01 11:30:00', 25.50, 22, 2),
(3, 'Pendiente', '2026-03-02 09:00:00', 30.00, 23, 3),
(4, 'Entregado', '2026-03-02 18:45:00', 19.99, 24, 4),
(5, 'Entregado', '2026-03-03 12:00:00', 44.00, 25, 5),
(6, 'Entregado', '2026-03-03 19:10:00', 29.99, 26, 6),
(7, 'Cancelado', '2026-03-04 08:30:00', 39.99, 27, 7),
(8, 'Entregado', '2026-03-04 20:00:00', 59.99, 28, 8),
(9, 'Entregado', '2026-03-05 14:20:00', 99.99, 29, 9),
(10, 'Pendiente', '2026-03-05 17:00:00', 299.99, 30, 10),
(11, 'Entregado', '2026-03-06 10:00:00', 8.50, 31, 11),
(12, 'Entregado', '2026-03-06 16:30:00', 5.00, 32, 12),
(13, 'Entregado', '2026-03-07 11:15:00', 8.50, 33, 13),
(14, 'Entregado', '2026-03-07 18:00:00', 12.00, 34, 14),
(15, 'Pendiente', '2026-03-08 09:45:00', 5.00, 35, 15),
(16, 'Entregado', '2026-03-08 21:30:00', 35.00, 36, 16),
(17, 'Entregado', '2026-03-09 13:00:00', 20.00, 37, 17),
(18, 'Entregado', '2026-03-09 19:20:00', 65.00, 38, 18),
(19, 'Entregado', '2026-03-10 10:00:00', 110.00, 39, 19),
(20, 'Entregado', '2026-03-10 15:45:00', 5.00, 40, 20);

INSERT INTO `pedidos_productos` (`Pedido_id_pedido`, `Producto_id_producto`, `cantidad`) VALUES 
(1, 1, 1), (2, 2, 1), (3, 3, 1), (4, 4, 1), (5, 5, 2),
(6, 6, 3), (7, 7, 1), (8, 8, 1), (9, 9, 2), (10, 10, 1),
(11, 11, 2), (12, 12, 1), (13, 13, 2), (14, 14, 2), (15, 15, 2),
(16, 16, 2), (17, 17, 1), (18, 18, 2), (19, 19, 1), (20, 20, 2);


-- 7. SUSCRIPCIONES Y BONOS (CATALOGO Y CLIENTE)
INSERT INTO `tipos_suscripciones` (`id_tipo_suscripcion`, `nombre`, `dias_validez`, `precio`, `activo`, `descripcion`) VALUES 
(1, 'Pase 1 Día', 1, 10.00, 1, 'Acceso 24h'),
(2, 'Pase Semanal', 7, 25.00, 1, '7 días consecutivos'),
(3, 'Mensual Básica', 30, 29.99, 1, 'Solo musculación'),
(4, 'Mensual Estándar', 30, 39.99, 1, 'Musculación + Clases'),
(5, 'Mensual Premium', 30, 59.99, 1, 'Total + Toalla y Parking'),
(6, 'Mensual VIP', 30, 99.99, 1, 'Premium + 2 Sesiones PT'),
(7, 'Trimestral Básica', 90, 85.00, 1, 'Ahorro 10%'),
(8, 'Trimestral Estándar', 90, 110.00, 1, 'Ahorro 10%'),
(9, 'Trimestral Premium', 90, 160.00, 1, 'Ahorro 10%'),
(10, 'Semestral Básica', 180, 150.00, 1, 'Ahorro 15%'),
(11, 'Semestral Estándar', 180, 200.00, 1, 'Ahorro 15%'),
(12, 'Semestral Premium', 180, 300.00, 1, 'Ahorro 15%'),
(13, 'Anual Básica', 365, 299.99, 1, 'Mejor precio anual'),
(14, 'Anual Estándar', 365, 399.99, 1, 'Pack popular'),
(15, 'Anual Premium', 365, 599.99, 1, 'Todo incluido 365 dias'),
(16, 'Estudiante', 30, 25.00, 1, 'Descuento Carnet Jove'),
(17, 'Familiar', 30, 80.00, 1, 'Hasta 4 miembros'),
(18, 'Matinal', 30, 19.99, 1, 'Acceso de 06:00 a 14:00'),
(19, 'Fin de Semana', 30, 15.00, 1, 'Viernes a Domingo'),
(20, 'Socio Fundador', 9999, 0.00, 1, 'Tarifa vitalicia');

INSERT INTO `suscripciones` (`id_suscripcion`, `fecha_inicio`, `fecha_fin`, `estado`, `Tipo_Suscripcion_id_tipo_suscripcion`, `Cliente_id_usuario`, `Pagos_id_pago`) VALUES 
(1, '2026-03-01 00:00:00', '2026-04-01 00:00:00', 'Activa', 4, 21, 1),
(2, '2026-03-01 00:00:00', '2026-03-08 00:00:00', 'Activa', 2, 22, 2),
(3, '2026-03-02 00:00:00', '2026-04-02 00:00:00', 'Activa', 3, 23, 3),
(4, '2026-03-02 00:00:00', '2026-04-02 00:00:00', 'Cancelada', 3, 24, 4),
(5, '2026-03-03 00:00:00', '2026-04-03 00:00:00', 'Activa', 6, 25, 5),
(6, '2026-01-01 00:00:00', '2026-02-01 00:00:00', 'Activa', 4, 26, 6),
(7, '2026-01-15 00:00:00', '2026-02-15 00:00:00', 'Caducada', 4, 27, 7),
(8, '2026-02-01 00:00:00', '2026-03-01 00:00:00', 'Activa', 5, 28, 8),
(9, '2026-02-10 00:00:00', '2026-05-10 00:00:00', 'Activa', 7, 29, 9),
(10, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 'Activa', 15, 30, 10),
(11, '2026-02-28 00:00:00', '2026-03-30 00:00:00', 'Activa', 4, 31, 11),
(12, '2026-02-28 00:00:00', '2026-03-30 00:00:00', 'Cancelada', 4, 32, 12),
(13, '2026-03-01 00:00:00', '2026-04-01 00:00:00', 'Activa', 5, 33, 13),
(14, '2026-03-02 00:00:00', '2026-04-02 00:00:00', 'Activa', 6, 34, 14),
(15, '2026-03-01 00:00:00', '2026-04-01 00:00:00', 'Activa', 4, 35, 15),
(16, '2026-01-01 00:00:00', '2026-02-01 00:00:00', 'Activa', 3, 36, 16),
(17, '2026-01-15 00:00:00', '2026-02-15 00:00:00', 'Activa', 4, 37, 17),
(18, '2026-02-01 00:00:00', '2026-03-01 00:00:00', 'Activa', 5, 38, 18),
(19, '2026-02-10 00:00:00', '2026-03-10 00:00:00', 'Activa', 6, 39, 19),
(20, '2026-03-01 00:00:00', '2026-04-01 00:00:00', 'Activa', 4, 40, 20);

INSERT INTO `tipos_bonos` (`id_tipo_bono`, `nombre`, `clases_totales`, `dias_validez`, `precio`, `activo`, `descripcion`) VALUES 
(1, 'Bono 5 Básicas', 5, 60, 20.00, 1, 'Clases estandar sin suplemento'),
(2, 'Bono 10 Básicas', 10, 90, 35.00, 1, 'Clases estandar sin suplemento'),
(3, 'Bono 20 Básicas', 20, 180, 60.00, 1, 'Clases estandar sin suplemento'),
(4, 'Bono 5 Premium', 5, 60, 35.00, 1, 'Incluye Crossfit y Halterofilia'),
(5, 'Bono 10 Premium', 10, 90, 65.00, 1, 'Incluye Crossfit y Halterofilia'),
(6, 'Bono 20 Premium', 20, 180, 110.00, 1, 'Incluye Crossfit y Halterofilia'),
(7, 'Bono 5 PT', 5, 90, 135.00, 1, 'Sesiones con Entrenador Personal'),
(8, 'Bono 10 PT', 10, 180, 250.00, 1, 'Sesiones con Entrenador Personal'),
(9, 'Bono 10 Padel', 10, 90, 100.00, 1, 'Reserva de pistas'),
(10, 'Bono 5 Nutrición', 5, 180, 180.00, 1, 'Revisiones mensuales dietéticas'),
(11, 'Bono 10 Fisioterapia', 10, 365, 400.00, 1, 'Descargas musculares completas'),
(12, 'Bono 5 Posing', 5, 90, 60.00, 1, 'Preparación puesta a punto'),
(13, 'Bono 20 Padel', 20, 180, 180.00, 1, 'Jugadores frecuentes'),
(14, 'Bono Mensual Open', 30, 30, 99.00, 1, '1 clase diaria garantizada'),
(15, 'Bono 5 Pilates', 5, 60, 25.00, 1, 'Rehabilitación postural'),
(16, 'Bono 10 Yoga', 10, 90, 45.00, 1, 'Vinyasa y relajacion'),
(17, 'Bono 20 Natación', 20, 180, 80.00, 1, 'Acceso libre piscina'),
(18, 'Bono 5 Boxeo', 5, 60, 30.00, 1, 'Sparring y saco'),
(19, 'Bono 10 MMA', 10, 90, 70.00, 1, 'Artes marciales mixtas'),
(20, 'Bono Elite 50', 50, 365, 400.00, 1, 'Todas las clases premium incluidas');

INSERT INTO `bonos_clientes` (`id_bono`, `clases_consumidas`, `estado`, `fecha_compra`, `fecha_caducidad`, `Clientes_id_usuario`, `Pagos_id_pago`, `Tipos_Bonos_id_tipo_bono`) VALUES 
(1, 2, 'Activo', '2026-03-01 00:00:00', '2026-04-30 00:00:00', 21, 1, 1),
(2, 1, 'Activo', '2026-03-01 00:00:00', '2026-05-30 00:00:00', 22, 2, 2),
(3, 20, 'Agotado', '2026-03-02 00:00:00', '2026-08-30 00:00:00', 23, 3, 3),
(4, 0, 'Activo', '2026-03-02 00:00:00', '2026-04-30 00:00:00', 24, 4, 4),
(5, 5, 'Activo', '2026-03-03 00:00:00', '2026-05-30 00:00:00', 25, 5, 5),
(6, 10, 'Activo', '2026-01-01 00:00:00', '2026-06-30 00:00:00', 26, 6, 6),
(7, 3, 'Activo', '2026-01-15 00:00:00', '2026-04-15 00:00:00', 27, 7, 7),
(8, 5, 'Activo', '2026-02-01 00:00:00', '2026-08-01 00:00:00', 28, 8, 8),
(9, 2, 'Activo', '2026-02-10 00:00:00', '2026-05-10 00:00:00', 29, 9, 9),
(10, 1, 'Activo', '2026-01-01 00:00:00', '2026-06-30 00:00:00', 30, 10, 10),
(11, 4, 'Activo', '2026-02-28 00:00:00', '2027-02-28 00:00:00', 31, 11, 11),
(12, 1, 'Activo', '2026-02-28 00:00:00', '2026-05-28 00:00:00', 32, 12, 12),
(13, 15, 'Activo', '2026-03-01 00:00:00', '2026-08-30 00:00:00', 33, 13, 13),
(14, 5, 'Activo', '2026-03-02 00:00:00', '2026-04-02 00:00:00', 34, 14, 14),
(15, 1, 'Activo', '2026-03-01 00:00:00', '2026-04-30 00:00:00', 35, 15, 15),
(16, 2, 'Activo', '2026-01-01 00:00:00', '2026-04-01 00:00:00', 36, 16, 16),
(17, 10, 'Activo', '2026-01-15 00:00:00', '2026-07-15 00:00:00', 37, 17, 17),
(18, 4, 'Activo', '2026-02-01 00:00:00', '2026-04-01 00:00:00', 38, 18, 18),
(19, 8, 'Activo', '2026-02-10 00:00:00', '2026-05-10 00:00:00', 39, 19, 19),
(20, 15, 'Activo', '2026-03-01 00:00:00', '2027-03-01 00:00:00', 40, 20, 20);


-- 8. SESIONES, RESERVAS Y AUDITORIA
INSERT INTO `sesiones` (`id_sesion`, `fecha`, `hora_inicio`, `hora_fin`, `duracion`, `plazas_totales`, `estado`, `Actividad_id_actividad`, `Empleado_id_usuario`, `Sala_id_sala`) VALUES 
(1, '2026-03-01', '09:00:00', '10:00:00', 60, 20, 'Completada', 1, 3, 1),
(2, '2026-03-01', '10:30:00', '11:30:00', 60, 15, 'Completada', 2, 4, 6),
(3, '2026-03-02', '12:00:00', '13:00:00', 60, 30, 'Programada', 3, 5, 5),
(4, '2026-03-05', '17:00:00', '18:00:00', 60, 40, 'Programada', 4, 8, 4),
(5, '2026-03-03', '08:00:00', '09:00:00', 60, 25, 'Completada', 5, 3, 7),
(6, '2026-03-06', '18:30:00', '19:30:00', 60, 20, 'Programada', 7, 4, 1),
(7, '2026-03-06', '19:00:00', '20:00:00', 60, 25, 'Programada', 8, 5, 8),
(8, '2026-03-04', '11:00:00', '12:00:00', 60, 10, 'Cancelada', 9, 8, 18),
(9, '2026-03-02', '14:00:00', '15:00:00', 60, 15, 'Completada', 10, 4, 2),
(10, '2026-03-07', '16:00:00', '16:45:00', 45, 50, 'Programada', 11, 5, 10),
(11, '2026-03-03', '09:30:00', '10:30:00', 60, 20, 'Completada', 12, 3, 17),
(12, '2026-03-08', '20:00:00', '21:00:00', 60, 10, 'Programada', 15, 8, 12),
(13, '2026-03-01', '07:00:00', '08:00:00', 60, 20, 'Completada', 17, 3, 12),
(14, '2026-03-04', '10:00:00', '11:00:00', 60, 5, 'Programada', 18, 4, 20),
(15, '2026-03-02', '13:00:00', '13:45:00', 45, 1, 'Completada', 19, 7, 16),
(16, '2026-03-09', '15:00:00', '16:00:00', 60, 1, 'Programada', 20, 8, 15),
(17, '2026-03-10', '18:00:00', '19:00:00', 60, 40, 'Programada', 2, 4, 6),
(18, '2026-03-10', '19:30:00', '20:30:00', 60, 40, 'Programada', 4, 5, 4),
(19, '2026-03-11', '21:00:00', '22:00:00', 60, 30, 'Programada', 3, 3, 5),
(20, '2026-03-01', '08:30:00', '09:30:00', 60, 25, 'Completada', 6, 4, 7);

INSERT INTO `reservas` (`id_reserva`, `fecha`, `estado`, `Sesion_id_sesion`, `Cliente_id_usuario`, `Bonos_Clientes_id_bono`, `Pagos_id_pago`) VALUES 
(1, '2026-02-28 10:00:00', 'Confirmada', 1, 21, 1, NULL),
(2, '2026-02-28 11:30:00', 'Confirmada', 2, 22, 2, NULL),
(3, '2026-03-01 09:00:00', 'Confirmada', 3, 23, NULL, NULL),
(4, '2026-03-02 16:00:00', 'Confirmada', 4, 24, 4, NULL),
(5, '2026-03-01 08:00:00', 'Asistida', 5, 25, 5, NULL),
(6, '2026-03-04 18:00:00', 'Confirmada', 6, 26, NULL, NULL),
(7, '2026-03-05 10:00:00', 'Confirmada', 7, 27, 7, NULL),
(8, '2026-03-02 11:00:00', 'Cancelada', 8, 28, 8, NULL),
(9, '2026-03-01 13:00:00', 'Asistida', 9, 29, 9, NULL),
(10, '2026-03-06 15:00:00', 'Confirmada', 10, 30, NULL, NULL),
(11, '2026-03-02 09:00:00', 'Asistida', 11, 31, 11, NULL),
(12, '2026-03-07 19:00:00', 'Confirmada', 12, 32, 12, NULL),
(13, '2026-02-28 07:00:00', 'Asistida', 13, 33, NULL, NULL),
(14, '2026-03-03 10:00:00', 'Confirmada', 14, 34, 14, NULL),
(15, '2026-03-01 12:00:00', 'Asistida', 15, 35, NULL, NULL),
(16, '2026-03-08 14:00:00', 'Confirmada', 16, 36, 16, NULL),
(17, '2026-03-09 17:00:00', 'Confirmada', 17, 37, 17, NULL),
(18, '2026-03-09 18:00:00', 'Confirmada', 18, 38, 18, NULL),
(19, '2026-03-10 20:00:00', 'Confirmada', 19, 39, 19, NULL),
(20, '2026-02-28 08:00:00', 'Asistida', 20, 40, 20, NULL);

INSERT INTO `auditoria_empleados` (`id_log`, `accion`, `tabla_afectada`, `fecha_hora`, `descripcion`, `Empleados_id_usuario`) VALUES 
(1, 'INSERT', 'Usuarios', '2026-03-01 08:00:00', 'Alta de cliente Arnold', 1),
(2, 'UPDATE', 'Clientes', '2026-03-01 09:15:00', 'Modificacion de direccion cliente Ronnie', 1),
(3, 'UPDATE', 'Usuarios', '2026-03-02 10:30:00', 'Baja temporal del cliente Markus', 2),
(4, 'INSERT', 'Sesiones', '2026-03-02 11:00:00', 'Añadida clase de Crossfit al horario', 14),
(5, 'UPDATE', 'Pedidos', '2026-03-03 12:45:00', 'Cambio de estado pedido 1 a Entregado', 17),
(6, 'UPDATE', 'Productos', '2026-03-03 13:00:00', 'Ajuste de stock Whey Protein', 20),
(7, 'INSERT', 'Auditoria', '2026-03-04 14:15:00', 'Revision manual de logs', 1),
(8, 'UPDATE', 'Usuarios', '2026-03-04 15:30:00', 'Baja temporal del cliente William', 2),
(9, 'UPDATE', 'Reservas', '2026-03-05 16:45:00', 'Anulacion de reserva por enfermedad', 18),
(10, 'INSERT', 'Tipos_Suscripciones', '2026-03-05 17:00:00', 'Creacion de tarifa Estudiante', 14),
(11, 'UPDATE', 'Empleados', '2026-03-06 08:30:00', 'Cambio de turno a Chris Bumstead', 15),
(12, 'INSERT', 'Suscripciones', '2026-03-06 09:45:00', 'Cobro manual suscripcion en recepcion', 19),
(13, 'UPDATE', 'Pagos', '2026-03-07 10:15:00', 'Reembolso por error de cobro', 1),
(14, 'INSERT', 'Salas', '2026-03-07 11:30:00', 'Añadida Pista de Padel 2', 12),
(15, 'UPDATE', 'Gimnasios', '2026-03-08 12:45:00', 'Actualizacion de telefono central', 1),
(16, 'UPDATE', 'Reservas', '2026-03-08 13:00:00', 'Eliminacion reserva duplicada', 17),
(17, 'INSERT', 'Bonos_Clientes', '2026-03-09 14:15:00', 'Asignacion bono compensacion', 14),
(18, 'UPDATE', 'Usuarios', '2026-03-09 15:30:00', 'Reinicio de contraseña cliente', 1),
(19, 'INSERT', 'Actividades', '2026-03-10 16:45:00', 'Nueva actividad Masterclass', 13),
(20, 'UPDATE', 'Sesiones', '2026-03-10 17:00:00', 'Cambio de monitor por sustitucion', 14);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;