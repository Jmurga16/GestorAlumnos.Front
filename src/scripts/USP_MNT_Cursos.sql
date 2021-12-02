
USE DB_ParcialDAD
GO

CREATE PROCEDURE [dbo].[USP_MNT_Cursos]          
            
	@sOpcion VARCHAR(2) = '',   
	@pParametro VARCHAR(max)
                                                                                   
AS     

BEGIN

	BEGIN
		
		DECLARE @nIdCurso	INT;
		DECLARE @sCodCur	VARCHAR(MAX);
		DECLARE @sNomCur	VARCHAR(MAX);		
		DECLARE @nCreditos	VARCHAR(MAX);
		
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
			FROM Cursos
			                                                                                 
	END;                         

  ELSE IF @sOpcion = '02'   --CONSULTAR REGISTRO DE CODIGOS
	BEGIN
    BEGIN
      SET @nIdCurso	= (SELECT valor FROM @tParametro WHERE id = 1);
    END

    BEGIN
		SELECT
		  *
		FROM Cursos
		WHERE
      nIdCurso = @nIdCurso
    END
						                                                                                 
	END;

	ELSE IF @sOpcion = '03'  --INSERT
	BEGIN
		  BEGIN
			  SET @sNomCur		= (SELECT valor FROM @tParametro WHERE id = 1);
        SET @nCreditos  = (SELECT valor FROM @tParametro WHERE id = 2);
						
			  SELECT @Correlativo = ISNULL(MAX(nIdCurso), 0) + 1 FROM [Cursos];

		  END	

		  BEGIN
    	
				  SELECT @nCreditos = 'COD'+right('000' + convert(varchar(3), @Correlativo), 3)
					
				  INSERT INTO Cursos
						  (sCodCur, sNomCur,  nCreditos,  nCreditos)
				  VALUES	(@sCodCur, @sNomCur, @nCreditos, @nCreditos)

				  SELECT CONCAT('1|',@nCreditos)
		  		
		  END
		
	  END
	   	   
	ELSE IF @sOpcion = '04'  -- ACTUALIZAR
	BEGIN
      BEGIN
			  SET @nIdCurso	= (SELECT valor FROM @tParametro WHERE id = 1);
			  SET @sNomCur		= (SELECT valor FROM @tParametro WHERE id = 2);
        SET @nCreditos	= (SELECT valor FROM @tParametro WHERE id = 3);

        SELECT @sCodCur = sNomCur FROM Cursos WHERE nIdCurso = @nIdCurso

		  END	
		
			  BEGIN
			    UPDATE [Cursos]                           
				  SET 
					  sNomCur = @sNomCur,
            nCreditos = @nCreditos
				  WHERE 
					  nIdCurso = @nIdCurso

				  SELECT CONCAT('1|El Curso con código ',@sCodCur,' se registró con éxito')
			  END
	
        
	  END;

  ELSE IF @sOpcion = '05'  -- ELIMINAR
	BEGIN
      BEGIN
			  SET @nIdCurso	= (SELECT valor FROM @tParametro WHERE id = 1);

        SELECT @sCodCur = sCodCur FROM Cursos WHERE nIdCurso = @nIdCurso
		  END	
		
			  BEGIN

          DELETE FROM [Alu_Cur] WHERE nIdCurso = @nIdCurso
                  
			    DELETE FROM [Cursos] WHERE nIdCurso = @nIdCurso
          
				  SELECT CONCAT('1|El Curso con código ',@sCodCur,' ha Sido Eliminado')
			  END
	
        
	  END;
	
END
