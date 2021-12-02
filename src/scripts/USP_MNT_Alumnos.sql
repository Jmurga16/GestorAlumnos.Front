USE DB_PagoEfectivo
GO
USE DB_ParcialDAD
GO

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
				  *
      FROM Alumnos
      WHERE nIdAlumno = @nIdAlumno
    END
						                                                                                 
	END;

	ELSE IF @sOpcion = '03'  --INSERT
	  BEGIN
		  BEGIN
			  SET @sNombres		= (SELECT valor FROM @tParametro WHERE id = 1);
        SET @sApellidos	= (SELECT valor FROM @tParametro WHERE id = 2);
						
			  SELECT @Correlativo = ISNULL(MAX(nIdAlumno), 0) + 1 FROM [Alumnos];

		  END	

		  BEGIN
    	
				  SELECT @sCodAlu = 'COD'+right('0000' + convert(varchar(5), @Correlativo), 5)
					
				  INSERT INTO Alumnos
						  (sCodAlu,  sNombres,  sApellidos)
				  VALUES	(@sCodAlu, @sNombres, @sApellidos)

				  SELECT CONCAT('1|',@sCodAlu)
		  		
		  END
		
	  END
	   
	   
	ELSE IF @sOpcion = '04'  -- ACTUALIZAR
	  BEGIN
      BEGIN
			  SET @nIdAlumno	= (SELECT valor FROM @tParametro WHERE id = 1);
			  SET @sNombres		= (SELECT valor FROM @tParametro WHERE id = 2);
        SET @sApellidos	= (SELECT valor FROM @tParametro WHERE id = 3);

        SELECT @sCodAlu = sCodAlu FROM Alumnos WHERE nIdAlumno = @nIdAlumno
		  END	
		
			  BEGIN
			    UPDATE [Alumnos]                           
				  SET 
					  sNombres = @sNombres,
            sApellidos = @sApellidos
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
                  
			    DELETE FROM [Alumnos] WHERE nIdAlumno = @nIdAlumno
          
				  SELECT CONCAT('1|El Alumno con código ',@sCodAlu,' ha Sido Eliminado')
			  END
	
        
	  END;
	
END
