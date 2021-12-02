
USE DB_ParcialDAD
GO

CREATE PROCEDURE [dbo].[USP_MNT_AlumnosxCurso]          
            
	@sOpcion VARCHAR(2) = '',   
	@pParametro VARCHAR(max)
                                                                                   
AS     

BEGIN

	BEGIN
		
		DECLARE @nIdAluCur	INT;
		DECLARE @nIdAlumno	INT;
		DECLARE @nIdCurso	INT;
		DECLARE @nNota		INT;
		DECLARE @sCodAlu	VARCHAR(MAX);		
		DECLARE @sNomAlu	VARCHAR(MAX);		
		DECLARE @sNomCur	VARCHAR(MAX);		
    		
				
	END
	
	--VARIABLE TABLA
	BEGIN

		DECLARE @tParametro TABLE (
			id int,
			valor varchar(max)
		);

	END

	--Descontena el parametro con split
	BEGIN
		IF(LEN(LTRIM(RTRIM(@pParametro))) > 0)
			BEGIN
			    INSERT INTO @tParametro (id, valor ) SELECT id, valor FROM dbo.Split(@pParametro, '|');
			END;
	END;
        		
	IF @sOpcion = '01'   --CONSULTAR TODO
	BEGIN
		BEGIN
			SET @sCodAlu	= (SELECT valor FROM @tParametro WHERE id = 1);
		END
		
		SELECT
			nIdAluCur
			,Alu.nIdAlumno
			,Cur.nIdCurso
			,sCodAlu
			,sCodCur
			,sNombres
			,sApellidos
			,nNota
			,nCreditos
		FROM Alu_Cur AluCur
		INNER JOIN Alumnos AS Alu ON AluCur.nIdAlumno = Alu.nIdAlumno
		INNER JOIN Cursos AS Cur ON AluCur.nIdCurso = Cur.nIdCurso
		WHERE
			sCodAlu = @sCodAlu

			                                                                                 
	END;                         

	ELSE IF @sOpcion = '02'   --CONSULTAR UNO
	BEGIN
    BEGIN
		SET @nIdAluCur	= (SELECT valor FROM @tParametro WHERE id = 1);
    END

    BEGIN
		SELECT
			nIdAluCur
			,Alu.nIdAlumno
			,Cur.nIdCurso
			,sCodAlu
			,sCodCur
			,sNombres
			,sApellidos
			,nNota
			,nCreditos
		FROM Alu_Cur AluCur
		INNER JOIN Alumnos AS Alu ON AluCur.nIdAlumno = Alu.nIdAlumno
		INNER JOIN Cursos AS Cur ON AluCur.nIdCurso = Cur.nIdCurso
		WHERE
			nIdAluCur = @nIdAluCur
    END
						                                                                                 
	END;

	ELSE IF @sOpcion = '03'  --INSERT
	BEGIN
		  BEGIN
			SET @nIdAlumno	= (SELECT valor FROM @tParametro WHERE id = 1);
			SET @nIdCurso	= (SELECT valor FROM @tParametro WHERE id = 2);
			SET @nNota  = (SELECT valor FROM @tParametro WHERE id = 3);
			
			SELECT @sNomAlu = sNombres + ' ' + sApellidos FROM Alumnos WHERE nIdAlumno = @nIdAlumno
			SELECT @sNomCur = @sNomCur FROM Cursos WHERE nIdCurso = @nIdCurso

		  END	

		  BEGIN
    						
				  INSERT INTO Alu_Cur
							(nIdAlumno, nIdCurso ,  nNota)
				  VALUES	(@nIdAlumno, @nIdCurso ,  @nNota)

				  SELECT CONCAT('1|','Sé Agregó la nota de ', @nNota,' al alumno ',@sNomAlu, ' en el curso ', @sNomCur)
		  		
		  END
		
	  END
	   	   
	ELSE IF @sOpcion = '04'  -- ACTUALIZAR
	BEGIN
      BEGIN			
			SET @nNota		= (SELECT valor FROM @tParametro WHERE id = 2);
			SET @nIdAluCur = (SELECT valor FROM @tParametro WHERE id = 1);

		  END	
		
			  BEGIN
			    UPDATE [Alu_Cur]                           
				  SET 
					  nNota = @nNota        
				  WHERE 
					  nIdAluCur = @nIdAluCur

				  SELECT '1|Se modificó la nota con éxito'
			  END
	
        
	  END;

  ELSE IF @sOpcion = '05'  -- ELIMINAR
	BEGIN
		BEGIN
			SET @nIdAluCur	= (SELECT valor FROM @tParametro WHERE id = 1);
		END	
		
		BEGIN

			DELETE FROM [Alu_Cur] WHERE nIdCurso = @nIdAluCur
            
			SELECT '1|Se eliminó la nota con éxito'
		END
	
        
	  END;
	
END
