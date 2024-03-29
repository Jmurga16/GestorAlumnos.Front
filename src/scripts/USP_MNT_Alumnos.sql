USE [DB_ParcialDAD]
GO
/****** Object:  StoredProcedure [dbo].[USP_MNT_Alumnos]    Script Date: 26/01/2022 19:35:58 ******/

	CREATE PROCEDURE [dbo].[USP_MNT_Alumnos]          
            
	@sOpcion VARCHAR(2) = '',   
	@pParametro VARCHAR(max)
                                                                                   
AS     

BEGIN

	BEGIN
		
		DECLARE @nIdAlumno  INT;
		DECLARE @sCodAlu	  VARCHAR(MAX);
		DECLARE @sNombres		VARCHAR(MAX);		
		DECLARE @sApellidos	VARCHAR(MAX);
		DECLARE @nEdad  INT;

		
		DECLARE @Correlativo INT;
				
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
        
		
	IF @sOpcion = '01'   --CONSULTAR REGISTRO DE CODIGOS
	BEGIN
			
			SELECT
				*
			FROM Alumnos
			                                                                                 
	END;                         

  ELSE IF @sOpcion = '02'   --CONSULTAR REGISTRO DE CODIGOS
	BEGIN
    BEGIN
      SET @nIdAlumno	= (SELECT valor FROM @tParametro WHERE id = 1);
    END

    BEGIN
      SELECT
        nIdAlumno,
		TRIM(sCodAlu) AS 'sCodAlu',
        sNombres,
        sApellidos,
		nEdad
      FROM Alumnos
      WHERE nIdAlumno = @nIdAlumno
    END
						                                                                                 
	END;

	ELSE IF @sOpcion = '03'  --INSERT
		BEGIN
			BEGIN
				SET @sNombres		= (SELECT valor FROM @tParametro WHERE id = 1);
				SET @sApellidos	= (SELECT valor FROM @tParametro WHERE id = 2);
				SET @nEdad		= (SELECT valor FROM @tParametro WHERE id = 3);
				
				SELECT @Correlativo = ISNULL(MAX(nIdAlumno), 0) + 1 FROM [Alumnos];

		  END	
      
		  BEGIN
    	
				  SELECT @sCodAlu = 'ALU'+right('0000' + convert(varchar(5), @Correlativo), 5)
					
				  INSERT INTO Alumnos
						  (sCodAlu,  sNombres,  sApellidos, nEdad)
				  VALUES	(@sCodAlu, @sNombres, @sApellidos, @nEdad)

				  SELECT CONCAT('1|',@sCodAlu)
		  		
		  END
		
	  END
	   
	   
	ELSE IF @sOpcion = '04'  -- ACTUALIZAR
	  BEGIN
      BEGIN
			  
			  SET @sNombres		= (SELECT valor FROM @tParametro WHERE id = 1);
        SET @sApellidos	= (SELECT valor FROM @tParametro WHERE id = 2);
        SET @nEdad	= (SELECT valor FROM @tParametro WHERE id = 3);

        SET @nIdAlumno	= (SELECT valor FROM @tParametro WHERE id = 4);

        SELECT @sCodAlu = sCodAlu FROM Alumnos WHERE nIdAlumno = @nIdAlumno
		  END	
		
			  BEGIN
			    UPDATE [Alumnos]                           
				  SET 
					  sNombres = @sNombres,
            sApellidos = @sApellidos,
			nEdad = @nEdad
				  WHERE 
					  nIdAlumno = @nIdAlumno

				  SELECT CONCAT('1|El Alumno con código ',@sCodAlu,' se registró con éxito')
			  END
	
        
	  END;

  ELSE IF @sOpcion = '05'  -- ELIMINAR
	  BEGIN
      BEGIN
			  SET @nIdAlumno	= (SELECT valor FROM @tParametro WHERE id = 1);

        SELECT @sCodAlu = sCodAlu FROM Alumnos WHERE nIdAlumno = @nIdAlumno
		  END	
		
			  BEGIN

          DELETE FROM [Alu_Cur] WHERE nIdAlumno = @nIdAlumno
                  
			    DELETE FROM [Alumnos] WHERE nIdAlumno = @nIdAlumno
          
				  SELECT CONCAT('1|El Alumno con código ',@sCodAlu,' ha Sido Eliminado')
			  END
	
        
	  END;
	
END
