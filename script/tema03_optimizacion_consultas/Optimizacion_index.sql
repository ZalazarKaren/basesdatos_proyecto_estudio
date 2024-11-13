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
  CONSTRAINT FK_Control_Horarios_Medicos FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico),
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




--Carga de datos aleatorios


DECLARE @i INT = 1;

WHILE @i <= 1000000
BEGIN
    INSERT INTO Entrada (id_entrada, fecha_entrada, hora)
    VALUES (
        @i,
        DATEADD(DAY, @i % 365, '2020-01-01'),  -- Genera fechas distintas
        DATEADD(SECOND, RAND() * 86400, '00:00:00')  -- Genera horas aleatorias
    );
    SET @i = @i + 1;
END;

--SELECTS de las tablas

/*SELECT * FROM Tipo_Consulta;
SELECT * FROM Medicos;
SELECT * FROM Provincia;
SELECT * FROM Localidad;
SELECT * FROM Domicilio;
SELECT * FROM Paciente;
SELECT * FROM Entrada;
SELECT * FROM Salida;
SELECT * FROM Control_Horarios;
SELECT * FROM Consulta_Medica;
SELECT * FROM Informes_Desempeño;*/




--1r0
--Realizamos una Búsqueda por Período (en este caso del año 2021)


SET STATISTICS TIME ON;  
SET STATISTICS IO ON;    

SELECT *
FROM Entrada
WHERE fecha_entrada BETWEEN '2020-01-01' AND '2020-12-31';

---2do
--realizamos los pasos necesarios para crear un Índice Agrupado en fecha_entrada


--Eliminamos la clave Foránea
ALTER TABLE Control_Horarios DROP CONSTRAINT FK_Control_Horarios_Entrada;

--Eliminamos la clave Primaria
ALTER TABLE Entrada DROP CONSTRAINT PK_Entrada;

--Creamos el índice único en id_entrada
CREATE UNIQUE INDEX IX_Entrada_Id ON Entrada (id_entrada);

--Cargamos de nuevo la clave foránea
ALTER TABLE Control_Horarios
ADD CONSTRAINT FK_Control_Horarios_Entrada
FOREIGN KEY (id_entrada) REFERENCES Entrada(id_entrada);

--Creamos un índice agrupado en `fecha_entrada`
CREATE CLUSTERED INDEX IX_Entrada_Fecha ON Entrada (fecha_entrada);

--Borramos el Índice Creado para crear uno mas específico (el índice agrupado de columnas)
DROP INDEX IX_Entrada_Fecha ON Entrada;

-- Restauramos la clave primaria (índice agrupado en id_entrada)
ALTER TABLE Entrada ADD CONSTRAINT PK_Entrada PRIMARY KEY (id_entrada);


--3ro
--Creamos un Índice Agrupado que Incluya Columnas Seleccionadas

-- Eliminamos el índice agrupado actual si existe
ALTER TABLE Entrada DROP CONSTRAINT PK_Entrada;

-- Creamos un nuevo índice agrupado sobre 'fecha_entrada' y 'hora'
CREATE CLUSTERED INDEX [IX_fecha_Entrada] 
ON [dbo].[Entrada]([fecha_entrada], [hora]);



