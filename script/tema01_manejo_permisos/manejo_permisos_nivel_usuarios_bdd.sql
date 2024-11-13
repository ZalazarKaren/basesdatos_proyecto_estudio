CREATE DATABASE gestion_hospital;
USE gestion_hospital;

CREATE TABLE Tipo_Consulta
(
  id_tipo INT NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  precio FLOAT NOT NULL,
  CONSTRAINT PK_Tipo_Consulta PRIMARY KEY (id_tipo)
);

CREATE TABLE Medicos
(
  id_medico INT NOT NULL,
  nombre_apellido VARCHAR(100) NOT NULL,
  CONSTRAINT PK_Medicos PRIMARY KEY (id_medico)
);

CREATE TABLE Provincia
(
  id_provincia INT NOT NULL,
  nombre_provincia VARCHAR(100) NOT NULL,
  CONSTRAINT PK_Provincia PRIMARY KEY (id_provincia)
);

CREATE TABLE Entrada
(
  id_entrada INT NOT NULL,
  fecha_entrada DATE NOT NULL,
  hora VARCHAR(15) NOT NULL,
  CONSTRAINT PK_Entrada PRIMARY KEY (id_entrada)
);

CREATE TABLE Salida
(
  id_salida INT NOT NULL,
  fecha_salida DATE NOT NULL,
  hora VARCHAR(15) NOT NULL,
  CONSTRAINT PK_Salida PRIMARY KEY (id_salida)
);

CREATE TABLE Control_Horarios
(
  id_control_horarios INT NOT NULL,
  id_entrada INT NOT NULL,
  id_salida INT NOT NULL,
  id_medico INT NOT NULL,
  CONSTRAINT PK_Control_Horarios PRIMARY KEY (id_control_horarios),
  CONSTRAINT FK_Control_Horarios_Entrada FOREIGN KEY (id_entrada) REFERENCES Entrada(id_entrada),
  CONSTRAINT FK_Control_Horarios_Salida FOREIGN KEY (id_salida) REFERENCES Salida(id_salida),
  CONSTRAINT FK_Control_Horarios_Medicos FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico)
);

CREATE TABLE Localidad
(
  id_localidad INT NOT NULL,
  nombre_localidad VARCHAR(100) NOT NULL,
  id_provincia INT NOT NULL,
  CONSTRAINT PK_Localidad PRIMARY KEY (id_localidad),
  CONSTRAINT FK_Localidad FOREIGN KEY (id_provincia) REFERENCES Provincia(id_provincia)
);

CREATE TABLE Domicilio
(
  id_domicilio INT NOT NULL,
  calle VARCHAR(100) NOT NULL,
  numero INT NOT NULL,
  id_localidad INT NOT NULL,
  CONSTRAINT PK_Domicilio PRIMARY KEY (id_domicilio),
  CONSTRAINT FK_Domicilio_Localidad FOREIGN KEY (id_localidad) REFERENCES Localidad(id_localidad)
);

CREATE TABLE Paciente
(
  dni_paciente INT NOT NULL,
  nombre_apellido VARCHAR(100) NOT NULL,
  fecha_nac DATE NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  id_domicilio INT NOT NULL,
  CONSTRAINT PK_Paciente PRIMARY KEY (dni_paciente),
  CONSTRAINT FK_Paciente_Domicilio FOREIGN KEY (id_domicilio) REFERENCES Domicilio(id_domicilio),
  CONSTRAINT UK_Paciente_Telefono UNIQUE (telefono)
);

CREATE TABLE Consulta_Medica
(
  id_act_medica INT NOT NULL,
  fecha DATE NOT NULL,
  hora VARCHAR(15) NOT NULL,
  dni_paciente INT NOT NULL,
  id_medico INT NOT NULL,
  id_tipo INT NOT NULL,
  CONSTRAINT PK_Consulta_Medica PRIMARY KEY (id_act_medica),
  CONSTRAINT FK_Consulta_Medica_Paciente FOREIGN KEY (dni_paciente) REFERENCES Paciente(dni_paciente),
  CONSTRAINT FK_Consulta_Medica_Medicos FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico),
  CONSTRAINT FK_Consulta_Medica_Tipo FOREIGN KEY (id_tipo) REFERENCES Tipo_Consulta(id_tipo)
);

CREATE TABLE Informes_Desempeño
(
  id_informe INT NOT NULL,
  calificacion INT NOT NULL,
  comentario VARCHAR(100) NOT NULL, 
  id_medico INT NOT NULL,
  dni_paciente INT,
  CONSTRAINT PK_Informes_Desempeño PRIMARY KEY (id_informe),
  CONSTRAINT FK_Informes_Desempeño FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico),
  CONSTRAINT FK_Informes_Desempeño_Paciente FOREIGN KEY (dni_paciente) REFERENCES Paciente(dni_paciente),
  CONSTRAINT CK_Informes_Desempeño_Calificacion CHECK (calificacion BETWEEN 1 AND 10) 
);

/*---------------
-- LOTE DE DATOS 
----------------*/
/*---------------
-- LOTE DE DATOS COMPLETO
----------------*/

-- Tipo_Consulta
INSERT INTO Tipo_Consulta (id_tipo, descripcion, precio) VALUES
(1, 'Consulta General', 500.0),
(2, 'Consulta Especializada', 1000.0),
(3, 'Consulta de Emergencia', 1500.0),
(4, 'Consulta Psicología', 1200.0),
(5, 'Consulta Pediatría', 1100.0),
(6, 'Consulta Cardiología', 1800.0),
(7, 'Consulta Neurología', 2000.0),
(8, 'Consulta Oftalmología', 1500.0),
(9, 'Consulta Dermatología', 1300.0),
(10, 'Consulta Traumatología', 1700.0),
(11, 'Consulta Gastroenterología', 1600.0),
(12, 'Consulta Ginecología', 1900.0),
(13, 'Consulta Urología', 1800.0),
(14, 'Consulta Endocrinología', 1550.0),
(15, 'Consulta Nutrición', 1400.0);

-- Medicos
INSERT INTO Medicos (id_medico, nombre_apellido) VALUES
(1, 'Dr. Juan Perez'),
(2, 'Dra. Maria Lopez'),
(3, 'Dr. Carlos Sanchez'),
(4, 'Dra. Laura Medina'),
(5, 'Dr. Emilio Torres'),
(6, 'Dr. Luis Diaz'),
(7, 'Dra. Sonia Herrera'),
(8, 'Dr. Martin Castro'),
(9, 'Dra. Sofia Gonzalez'),
(10, 'Dr. Pablo Rojas'),
(11, 'Dr. Sergio Fernandez'),
(12, 'Dra. Mariana Ortega'),
(13, 'Dr. Alberto Gomez'),
(14, 'Dra. Julieta Vargas'),
(15, 'Dr. Ernesto Palacios');

-- Provincia
INSERT INTO Provincia (id_provincia, nombre_provincia) VALUES
(1, 'Buenos Aires'),
(2, 'Cordoba'),
(3, 'Santa Fe'),
(4, 'Mendoza'),
(5, 'Salta'),
(6, 'San Juan'),
(7, 'Tucuman'),
(8, 'Misiones'),
(9, 'Formosa'),
(10, 'Chubut');

-- Localidad
INSERT INTO Localidad (id_localidad, nombre_localidad, id_provincia) VALUES
(1, 'La Plata', 1),
(2, 'Cordoba Capital', 2),
(3, 'Rosario', 3),
(4, 'Mendoza Capital', 4),
(5, 'Salta Capital', 5),
(6, 'San Juan Capital', 6),
(7, 'San Miguel de Tucuman', 7),
(8, 'Posadas', 8),
(9, 'Formosa Capital', 9),
(10, 'Puerto Madryn', 10);

-- Domicilio
INSERT INTO Domicilio (id_domicilio, calle, numero, id_localidad) VALUES
(1, 'Calle Roca', 123, 1),
(2, 'Avenida Corrientes', 742, 2),
(3, 'Boulevard Oroño', 150, 3),
(4, 'Avenida San Martín', 500, 4),
(5, 'Calle Belgrano', 223, 5),
(6, 'Calle San Martin', 345, 6),
(7, 'Avenida Alem', 123, 7),
(8, 'Calle Colon', 789, 8),
(9, 'Boulevard San Juan', 456, 9),
(10, 'Avenida Argentina', 159, 10);

-- Paciente
INSERT INTO Paciente (dni_paciente, nombre_apellido, fecha_nac, telefono, id_domicilio) VALUES
(12345678, 'Pedro Gomez', '1980-01-01', '123456789', 1),
(87654321, 'Ana Martinez', '1990-02-02', '987654321', 2),
(56781234, 'Laura Lopez', '1985-05-05', '321654987', 3),
(12347856, 'Carlos Ruiz', '1975-10-10', '789654123', 4),
(90807060, 'Veronica Sanchez', '2001-12-15', '456789321', 5),
(87651234, 'Rosa Molina', '1982-07-13', '111222333', 6),
(43217856, 'Marcos Avila', '1969-09-23', '222333444', 7),
(55667788, 'Florencia Godoy', '1995-12-18', '333444555', 8),
(66554433, 'Emanuel Perez', '2000-03-12', '444555666', 9),
(44556677, 'Alejandra Moreno', '1987-05-15', '555666777', 10);

-- Entrada
INSERT INTO Entrada (id_entrada, fecha_entrada, hora) VALUES
(1, '2024-10-01', '08:00'),
(2, '2024-10-01', '09:00'),
(3, '2024-10-02', '07:45'),
(4, '2024-10-02', '09:30'),
(5, '2024-10-02', '10:00'),
(6, '2024-10-03', '07:30'),
(7, '2024-10-03', '08:30'),
(8, '2024-10-03', '09:30'),
(9, '2024-10-03', '10:30'),
(10, '2024-10-03', '11:30');

-- Salida
INSERT INTO Salida (id_salida, fecha_salida, hora) VALUES
(1, '2024-10-01', '10:00'),
(2, '2024-10-01', '11:00'),
(3, '2024-10-02', '13:00'),
(4, '2024-10-02', '14:30'),
(5, '2024-10-02', '15:00'),
(6, '2024-10-03', '12:00'),
(7, '2024-10-03', '13:00'),
(8, '2024-10-03', '14:00'),
(9, '2024-10-03', '15:00'),
(10, '2024-10-03', '16:00');

-- Control_Horarios
INSERT INTO Control_Horarios (id_control_horarios, id_entrada, id_salida, id_medico) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3),
(4, 4, 4, 4),
(5, 5, 5, 5),
(6, 6, 6, 6),
(7, 7, 7, 7),
(8, 8, 8, 8),
(9, 9, 9, 9),
(10, 10, 10, 10);

-- Consulta_Medica
INSERT INTO Consulta_Medica (id_act_medica, fecha, hora, dni_paciente, id_medico, id_tipo) VALUES
(1, '2024-10-01', '08:30', 12345678, 1, 1),
(2, '2024-10-01', '09:30', 87654321, 2, 2),
(3, '2024-10-02', '07:50', 56781234, 3, 3),
(4, '2024-10-02', '09:45', 12347856, 4, 4),
(5, '2024-10-02', '10:15', 90807060, 5, 5),
(6, '2024-10-03', '08:00', 87651234, 6, 6),
(7, '2024-10-03', '09:00', 43217856, 7, 7),
(8, '2024-10-03', '10:00', 55667788, 8, 8),
(9, '2024-10-03', '11:00', 66554433, 9, 9),
(10, '2024-10-03', '12:00', 44556677, 10, 10);

-- Informes_Desempeño
INSERT INTO Informes_Desempeño (id_informe, calificacion, comentario, id_medico, dni_paciente) VALUES
(1, 9, 'Excelente atención', 1, 12345678),
(2, 8, 'Muy buena atención', 2, 87654321),
(3, 7, 'Atención adecuada', 3, 56781234),
(4, 6, 'Atención aceptable', 4, 12347856),
(5, 10, 'Excelente trato y profesionalismo', 5, 90807060),
(6, 9, 'Muy buen trato', 6, 87651234),
(7, 7, 'Atención correcta', 7, 43217856),
(8, 8, 'Buen servicio', 8, 55667788),
(9, 6, 'Satisfactorio', 9, 66554433),
(10, 10, 'Excelente atención', 10, 44556677);

SELECT * FROM Tipo_Consulta;
SELECT * FROM Medicos;
SELECT * FROM Provincia;
SELECT * FROM Localidad;
SELECT * FROM Domicilio;
SELECT * FROM Paciente;
SELECT * FROM Entrada;
SELECT * FROM Salida;
SELECT * FROM Control_Horarios;
SELECT * FROM Consulta_Medica;
SELECT * FROM Informes_Desempeño;

/*----------------------------------
-- LOTE DE DATOS PARA RESTRICCIONES
----------------------------------*/
-- Datos incorrectos en Informes_Desempeño para verificar. Esto debería fallar porque la calificación está fuera del rango permitido.
INSERT INTO Informes_Desempeño (id_informe, calificacion, comentario, id_medico, dni_paciente) VALUES
(5, 11, 'Excelente atención', 1, 90807060);

/*----------------------------------
-- PERMISOS A NIVEL DE USUARIOS
----------------------------------*/
-- Crear usuarios de inicio de sesión en el servidor
CREATE LOGIN usuario_admin WITH PASSWORD = 'Contraseña1';
CREATE LOGIN usuario_lectura WITH PASSWORD = 'Contraseña2';

-- Asignar los usuarios a la base de datos gestion_hospital
USE gestion_hospital;
CREATE USER usuario_admin FOR LOGIN usuario_admin;
CREATE USER usuario_lectura FOR LOGIN usuario_lectura;

-- Dar permisos de administrador
ALTER ROLE db_owner ADD MEMBER usuario_admin;

-- Dar permisos de solo lectura
ALTER ROLE db_datareader ADD MEMBER usuario_lectura;

-- Crear un procedimiento almacenado para insertar datos en la tabla Consulta_Medica
CREATE PROCEDURE sp_InsertarConsulta
    @id_act_medica INT,
    @fecha DATE,
    @hora VARCHAR(15),
    @dni_paciente INT,
    @id_medico INT,
    @id_tipo INT
AS
BEGIN
    INSERT INTO Consulta_Medica (id_act_medica, fecha, hora, dni_paciente, id_medico, id_tipo)
    VALUES (@id_act_medica, @fecha, @hora, @dni_paciente, @id_medico, @id_tipo);
END;

-- Dar permisos de ejecución al usuario de solo lectura
GRANT EXECUTE ON sp_InsertarConsulta TO usuario_lectura;

-- Realizar un INSERT directo en la tabla con ambos usuarios
-- Nota: Intenta insertar datos directamente en Consulta_Medica con el usuario_admin (debería tener éxito)
-- y luego con usuario_lectura (debería fallar en el intento directo debido a permisos limitados).

-- 1. Iniciar sesión con usuario_admin
USE gestion_hospital;
-- Intentar hacer un INSERT en la tabla Consulta_Medica
INSERT INTO Consulta_Medica (id_act_medica, fecha, hora, dni_paciente, id_medico, id_tipo)
VALUES (12, '2024-11-13', '14:00', 87654321, 2, 3);

-- 2. Iniciar sesión con usuario_lectura
USE gestion_hospital;
-- Intentar hacer un INSERT en la tabla Consulta_Medica
INSERT INTO Consulta_Medica (id_act_medica, fecha, hora, dni_paciente, id_medico, id_tipo)
VALUES (13, '2024-11-14', '15:30', 23456789, 3, 4);


-- Realizar un INSERT usando el procedimiento almacenado con el usuario de solo lectura
EXEC sp_InsertarConsulta 
    @id_act_medica = 11,
    @fecha = '2024-11-12',
    @hora = '10:30',
    @dni_paciente = 12345678,
    @id_medico = 1,
    @id_tipo = 2;


/*----------------------------------
-- PERMISOS A NIVEL DE ROLES DEL DBMS
----------------------------------*/
-- 1. Crear dos usuarios de base de datos.

USE gestion_hospital;

-- Crear usuarios de base de datos
CREATE USER usuario_rol_lectura FOR LOGIN usuario_lectura;
CREATE USER usuario_sin_permiso FOR LOGIN usuario_lectura;

-- 2. Crear un rol que solo permita la lectura de alguna de las tablas creadas.

-- Crear un rol de solo lectura
CREATE ROLE rol_lectura;
-- Otorgar permisos de solo lectura sobre la tabla Consulta_Medica
GRANT SELECT ON Consulta_Medica TO rol_lectura;

-- 3. Darle permiso a uno de los usuarios sobre el rol creado anteriormente.

-- Asignar rol de solo lectura al usuario especificado
ALTER ROLE rol_lectura ADD MEMBER usuario_rol_lectura;

-- 4. Verificar el comportamiento de ambos usuarios (el que tiene permiso sobre el rol y el que no tiene), cuando intentan leer el contenido de la tabla.

-- Como usuario_rol_lectura
SELECT * FROM Consulta_Medica;

-- Como usuario_sin_permiso
SELECT * FROM Consulta_Medica;













