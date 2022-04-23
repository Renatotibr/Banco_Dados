CREATE FUNCTION [dbo].[fncArquivo_Existe_FSO] (
    @strArquivo VARCHAR(1000)
)
RETURNS INT 
AS 
BEGIN

    DECLARE	
        @hr INT,
        @objFileSystem INT,
        @retorno INT,
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
            
        RETURN 0
        
    END

    EXEC @hr = sp_OAMethod
        @objFileSystem,
        'FileExists',
        @retorno OUT,
        @strArquivo
        
    IF (@hr <> 0)
    BEGIN
    
        EXEC sp_OAGetErrorInfo
            @objFileSystem,
            @source OUT,
            @description OUT
            
        EXEC sp_OADestroy
            @objFileSystem
            
        RETURN 0
        
    END
    
    
    EXEC sp_OADestroy
        @objFileSystem
        
        
    RETURN @retorno

END