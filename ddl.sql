CREATE DATABASE IF NOT EXISTS pelis_campus;
USE pelis_campus;

CREATE TABLE IF NOT EXISTS pais(
    id_pais SMALLINT PRIMARY KEY,
    nombre VARCHAR(50),
    ultima_actualizacion TIMESTAMP
);

CREATE TABLE IF NOT EXISTS idioma(
    id_idioma TINYINT PRIMARY KEY,
    nombre CHAR(20),
    ultima_actualizacion TIMESTAMP
);

CREATE TABLE IF NOT EXISTS categoria(
    id_categoria TINYINT PRIMARY KEY,
    nombre VARCHAR(25),
    ultima_actualizacion TIMESTAMP
);

CREATE TABLE IF NOT EXISTS actor(
    id_actor SMALLINT PRIMARY KEY,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    ultima_actualizacion TIMESTAMP
);

CREATE TABLE IF NOT EXISTS film_text(
    film_id SMALLINT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT
);


CREATE TABLE IF NOT EXISTS ciudad(
    id_ciudad SMALLINT PRIMARY KEY,
    nombre VARCHAR(50),
    id_pais SMALLINT,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

CREATE TABLE IF NOT EXISTS direccion(
    id_direccion SMALLINT PRIMARY KEY,
    direccion VARCHAR(50),
    direccion2 VARCHAR(50),
    distrito VARCHAR(20),
    id_ciudad SMALLINT,
    codigo_postal VARCHAR(10),
    telefono VARCHAR(20),
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);


CREATE TABLE IF NOT EXISTS almacen(
    id_almacen TINYINT PRIMARY KEY,
    id_direccion SMALLINT NOT NULL,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE IF NOT EXISTS empleado(
    id_empleado TINYINT PRIMARY KEY,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    id_direccion SMALLINT NOT NULL,
    imagen BLOB,
    email VARCHAR(50),
    id_almacen TINYINT NOT NULL,
    activo TINYINT(1),
    username VARCHAR(16),
    password VARCHAR(40),
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

ALTER TABLE almacen ADD COLUMN id_empleado_jefe TINYINT;
ALTER TABLE almacen ADD FOREIGN KEY (id_empleado_jefe) REFERENCES empleado(id_empleado);


CREATE TABLE IF NOT EXISTS pelicula(
    id_pelicula SMALLINT PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion TEXT,
    anio_lanzamiento YEAR,
    id_idioma TINYINT NOT NULL,
    id_idioma_original TINYINT NULL,
    duracion_alquiler TINYINT,
    rental_rate DECIMAL(4,2),
    duracion SMALLINT,
    replacement_cost DECIMAL(5,2),
    clasificacion ENUM('G', 'PG', 'PG-13', 'R', 'NC-17'),
    caracteristicas_especiales SET('Trailers', 'Commentaries', 'Deleted Scenes', 'Behind the Scenes'),
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_idioma) REFERENCES idioma(id_idioma),
    FOREIGN KEY (id_idioma_original) REFERENCES idioma(id_idioma)
);

CREATE TABLE IF NOT EXISTS pelicula_actor(
    id_actor SMALLINT,
    id_pelicula SMALLINT,
    ultima_actualizacion TIMESTAMP,
    PRIMARY KEY (id_actor, id_pelicula),
    FOREIGN KEY (id_actor) REFERENCES actor(id_actor),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula)
);

CREATE TABLE IF NOT EXISTS pelicula_categoria(
    id_pelicula SMALLINT,
    id_categoria TINYINT,
    ultima_actualizacion TIMESTAMP,
    PRIMARY KEY (id_pelicula, id_categoria),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);


CREATE TABLE IF NOT EXISTS inventario(
    id_inventario MEDIUMINT PRIMARY KEY,
    id_pelicula SMALLINT NOT NULL,
    id_almacen TINYINT NOT NULL,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

CREATE TABLE IF NOT EXISTS cliente(
    id_cliente SMALLINT PRIMARY KEY,
    id_almacen TINYINT NOT NULL,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    email VARCHAR(50),
    id_direccion SMALLINT NOT NULL,
    activo TINYINT(1),
    fecha_creacion DATETIME,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE IF NOT EXISTS alquiler(
    id_alquiler INT PRIMARY KEY,
    fecha_alquiler DATETIME,
    id_inventario MEDIUMINT NOT NULL,
    id_cliente SMALLINT NOT NULL,
    fecha_devolucion DATETIME,
    id_empleado TINYINT NOT NULL,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE IF NOT EXISTS pago(
    id_pago SMALLINT PRIMARY KEY,
    id_cliente SMALLINT NOT NULL,
    id_empleado TINYINT NOT NULL,
    id_alquiler INT NOT NULL,
    total DECIMAL(5,2),
    fecha_pago DATETIME,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_alquiler) REFERENCES alquiler(id_alquiler)
);
