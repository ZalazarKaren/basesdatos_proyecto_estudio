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

CREATE TABLE Paciente
(
  dni_paciente INT NOT NULL,
  nombre_apellido VARCHAR(100) NOT NULL,
  fecha_nac DATE NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  domicilio VARCHAR (100) NOT NULL,
  CONSTRAINT PK_Paciente PRIMARY KEY (dni_paciente),
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

-- Paciente
INSERT INTO Paciente (dni_paciente, nombre_apellido, fecha_nac, telefono, domicilio) VALUES
(12345678, 'Pedro Gomez', '1980-01-01', '123456789', 'av siempre viva 124'),
(87654321, 'Ana Martinez', '1990-02-02', '987654321', 'av maipu 543'),
(56781234, 'Laura Lopez', '1985-05-05', '321654987', 'san lorenzo 1034'),
(12347856, 'Carlos Ruiz', '1975-10-10', '789654123', 'jujuy 1980'),
(90807060, 'Veronica Sanchez', '2001-12-15', '456789321', 'av artigas 323'),
(87651234, 'Rosa Molina', '1982-07-13', '111222333', 'peru 1234'),
(43217856, 'Marcos Avila', '1969-09-23', '222333444', 'junin 1042'),
(55667788, 'Florencia Godoy', '1995-12-18', '333444555', 'san martin 2049'),
(66554433, 'Emanuel Perez', '2000-03-12', '444555666', '9 de julio 1240'),
(44556677, 'Alejandra Moreno', '1987-05-15', '555666777', 'españa 756');

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
SELECT * FROM Paciente;
SELECT * FROM Entrada;
SELECT * FROM Salida;
SELECT * FROM Control_Horarios;
SELECT * FROM Consulta_Medica;
SELECT * FROM Informes_Desempeño;


-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------PROCEDIMIENTOS ALMACENADOS----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

--INSERTAR PACIENTE
CREATE PROCEDURE InsertarPaciente
    @dni_paciente INT,
    @nombre_apellido VARCHAR(100),
    @fecha_nac DATE,
    @telefono VARCHAR(20),
    @domicilio VARCHAR(100)
AS
BEGIN
    INSERT INTO Paciente (dni_paciente, nombre_apellido, fecha_nac, telefono, domicilio)
    VALUES (@dni_paciente, @nombre_apellido, @fecha_nac, @telefono, @domicilio);
END;

--MODIFICAR PACIENTE
CREATE PROCEDURE ModificarPaciente
    @dni_paciente INT,
    @nombre_apellido VARCHAR(100),
    @fecha_nac DATE,
    @telefono VARCHAR(20),
    @domicilio VARCHAR(100)
AS
BEGIN
    UPDATE Paciente
    SET nombre_apellido = @nombre_apellido,
        fecha_nac = @fecha_nac,
        telefono = @telefono,
        domicilio = @domicilio
    WHERE dni_paciente = @dni_paciente;
END;

--BORRAR PACIENTE
CREATE PROCEDURE BorrarPaciente
    @dni_paciente INT
AS
BEGIN
    DELETE FROM Paciente
    WHERE dni_paciente = @dni_paciente;
END;

------------------------------------------LOTE CON SENTENCIAS--------------------------------------------
INSERT INTO Paciente (dni_paciente, nombre_apellido, fecha_nac, telefono, domicilio) VALUES
(12121212, 'Pedro Pascal', '1975-02-23', '123098237', 'av chacabuco 122'), --YA CARGADO/BORRADO
(11111111, 'Dibu Martinez', '1982-06-23', '77622389', 'av escaloneta 423') --NO CARGADO TODAVIA


------------------------------------------LOTE CON PROCEDIMIENTO-----------------------------------------
EXEC InsertarPaciente 99999999, 'Pity Alvarez ', '1978-09-22', '3333323122', 'Viejas Locas 363';
EXEC InsertarPaciente 88888888, 'Homero Simpson', '1989-01-26', '2211334456', 'Siempre Viva 444';

SELECT * FROM Paciente

------------------------------------------UPDATE CON PROCEDIMIENTO-----------------------------------------
EXEC ModificarPaciente 12345678, 'Pedro Jose Gomez (new)', '1995-06-15', '1122334455', 'Calle Nueva 202';

------------------------------------------DELETE CON PROCEDIMIENTO-----------------------------------------
EXEC BorrarPaciente 12121212;


-----------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------FUNCIONES ALMACENADAS------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

/*
CREATE FUNCTION CalcularEdad (@fecha_nac DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @fecha_nac, GETDATE()) - 
           CASE 
               WHEN MONTH(@fecha_nac) > MONTH(GETDATE()) OR 
                    (MONTH(@fecha_nac) = MONTH(GETDATE()) AND DAY(@fecha_nac) > DAY(GETDATE())) 
               THEN 1 
               ELSE 0 
           END;
END;
-------------------------------------------
SELECT dbo.CalcularEdad(fecha_nac) AS Edad
FROM Paciente
WHERE dni_paciente = 12345678;
*/


--CALCULAR EDAD POR FECHA
CREATE FUNCTION CalcularEdadFecha (@fecha_nac DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @fecha_nac, GETDATE()) - 
           CASE 
               WHEN MONTH(@fecha_nac) > MONTH(GETDATE()) OR 
                    (MONTH(@fecha_nac) = MONTH(GETDATE()) AND DAY(@fecha_nac) > DAY(GETDATE())) 
               THEN 1 
               ELSE 0 
           END;
END;

---------------------------------------------------
SELECT dbo.CalcularEdadFecha('1995-11-27') AS Edad;
---------------------------------------------------

--CALCULAR EDAD POR DNI
CREATE FUNCTION CalcularEdadDNI (@dni_paciente INT)
RETURNS INT
AS
BEGIN
    DECLARE @fecha_nac DATE;
    DECLARE @edad INT;

    -- Obtener la fecha de nacimiento del paciente
    SELECT @fecha_nac = fecha_nac
    FROM Paciente
    WHERE dni_paciente = @dni_paciente;

    -- Calcular la edad utilizando la función CalcularEdad
    SET @edad = dbo.CalcularEdadFecha(@fecha_nac);

    RETURN @edad;
END;

---------------------------------------------
SELECT dbo.CalcularEdadDNI(12345678) AS Edad;
---------------------------------------------


--OBTENER NOMBRE COMPLETO DEL PACIENTE
CREATE FUNCTION ObtenerNombreCompleto (@dni INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @nombre VARCHAR(100);
    SELECT @nombre = nombre_apellido
    FROM Paciente
    WHERE dni_paciente = @dni;
    RETURN @nombre;
END;

SELECT dbo.ObtenerNombreCompleto(12345678) AS 'Nombre y Apellido';

--CALCULAR EL PRECIO DE LA CONSULTA

--FUNCTION PARA DIVIDIR CADENA PORQUE ESTA EN VERSION NO ESTA DISPONIBLE EL STRING SPLIT
CREATE FUNCTION dbo.SplitString
(
    @string NVARCHAR(MAX),
    @delimiter CHAR(1)
)
RETURNS @output TABLE (id_tipo INT)
AS
BEGIN
    DECLARE @start INT, @end INT;
    SET @start = 1;
    SET @end = CHARINDEX(@delimiter, @string);

    WHILE @start < LEN(@string) + 1
    BEGIN
        IF @end = 0 
            SET @end = LEN(@string) + 1;

        INSERT INTO @output (id_tipo)
        VALUES (CAST(SUBSTRING(@string, @start, @end - @start) AS INT));

        SET @start = @end + 1;
        SET @end = CHARINDEX(@delimiter, @string, @start);
    END;

    RETURN;
END;

CREATE FUNCTION dbo.CalcularPrecio (@ids_tipo NVARCHAR(MAX))
RETURNS @result TABLE (
    descripcion VARCHAR(100),
    precio FLOAT
)
AS
BEGIN
    --Convertir la lista de IDs en una tabla usando la función SplitString
    DECLARE @tbl_ids_tipo TABLE (id_tipo INT);
    INSERT INTO @tbl_ids_tipo (id_tipo)
    SELECT id_tipo FROM dbo.SplitString(@ids_tipo, ',');

    --Insertar las descripciones y precios en la tabla de resultados
    INSERT INTO @result (descripcion, precio)
    SELECT descripcion, precio
    FROM Tipo_Consulta
    WHERE id_tipo IN (SELECT id_tipo FROM @tbl_ids_tipo);

    --Calcular el precio total
    DECLARE @precio_total FLOAT;
    SELECT @precio_total = SUM(precio)
    FROM @result;

    --Insertar el total en la tabla de resultados
    INSERT INTO @result (descripcion, precio)
    VALUES ('Total', @precio_total);

    RETURN;
END;


SELECT descripcion, precio
FROM dbo.CalcularPrecio('1,3,4');


------------------
