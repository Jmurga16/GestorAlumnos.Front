USE DB_ParcialDAD
GO

--CREACION DE TABLAS

--TABLA Alumnos
CREATE TABLE Alumnos(
    nIdAlumno  INT NOT NULL IDENTITY(1,1) PRIMARY KEY ,
    sCodAlu    CHAR(10),
	  sNombres   VARCHAR(50),
    sApellidos VARCHAR(50),
    nEdad INT
)
GO

--TABLA Cursos
CREATE TABLE Cursos(
    nIdCurso  INT NOT NULL IDENTITY(1,1) PRIMARY KEY ,
    sCodCur   CHAR(10),
	  sNomCur   VARCHAR(50),
    nCreditos INT
)
GO

--TABLA Alumnos por Curso
CREATE TABLE Alu_Cur(
  nIdAluCur INT NOT NULL IDENTITY(1,1) PRIMARY KEY ,
  nIdAlumno INT,
	FOREIGN KEY (nIdAlumno) REFERENCES Alumnos(nIdAlumno),
	nIdCurso  INT,
  FOREIGN KEY (nIdCurso) REFERENCES Cursos(nIdCurso),
	nNota     INT
)
GO
