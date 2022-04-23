CREATE PROCEDURE [dbo].[stpApaga_Arquivo_FSO] (@strArquivo VARCHAR(1000))
AS 
BEGIN

    DECLARE	
        @hr INT,
        @objFileSystem INT,
        @source VARCHAR(250),
        @description VARCHAR(2000)


    EXEC @hr = sp_OACreate
        'Scripting.FileSystemObject',
        @objFileSystem OUT
        
    IF @hr <> 0
    BEGIN
    
        EXEC sp_OAGetErrorInfo
            @objFileSystem,
            @source OUT,
            @description OUT
        
    END

    
    IF (dbo.fncArquivo_Existe_FSO(@strArquivo) = 1)
    BEGIN
    
        EXEC @hr = sp_OAMethod
            @objFileSystem,
            'DeleteFile',
            NULL,
            @strArquivo
            
    END
    
    
    IF (@hr <> 0)
    BEGIN
    
        EXEC sp_OAGetErrorInfo
            @objFileSystem,
            @source OUT,
            @description OUT
            
        EXEC sp_OADestroy
            @objFileSystem
        
    END
    
    
    EXEC sp_OADestroy
        @objFileSystem
    

END