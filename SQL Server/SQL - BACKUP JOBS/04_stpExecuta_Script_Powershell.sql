CREATE PROCEDURE [dbo].[stpExecuta_Script_Powershell]
    @Ds_Script [varchar](MAX),
    @Fl_Apaga_Script [bit] = 1
AS
BEGIN
    

    SET NOCOUNT ON
    

    DECLARE 
        @QuebraLinha VARCHAR(10) = CHAR(13) + CHAR(10),
        @arquivo VARCHAR(MAX),
        @diretorio VARCHAR(MAX) = 'C:\Temp\',
        @scriptPS VARCHAR(MAX) = CAST(NEWID() AS VARCHAR(50)) + '.ps1',
        @caminho VARCHAR(MAX)


    SET @caminho = @diretorio + @scriptPS
        
    
    EXEC dbo.stpEscreve_Arquivo_FSO
        @String = @Ds_Script, -- varchar(max)
        @Ds_Arquivo = @caminho -- varchar(1501)
    
    SET @scriptPS = @diretorio + @scriptPS
        
        
    DECLARE @cmd VARCHAR(4000)
    SET @cmd = 'powershell -ExecutionPolicy Unrestricted -File "' + @scriptPS + '"'
    
    
    DECLARE @Retorno TABLE (Ds_Texto VARCHAR(MAX))
    
    INSERT INTO @Retorno
    EXEC master.dbo.xp_cmdshell @cmd
    
    
    -- Apaga o script gerado
    IF (@Fl_Apaga_Script = 1)
    BEGIN
    
        EXEC dbo.stpApaga_Arquivo_FSO
            @strArquivo = @scriptPS -- varchar(1000)
        
    END
    

    SELECT * FROM @Retorno

    
END