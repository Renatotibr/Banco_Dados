setlocal enableDelayedExpansion
@echo off
ECHO. > "Execucao.log"
 
for /R %%G in (*.sql) do (
 
    ECHO -------------------------------------------------------- >> "Execucao.log"
    ECHO !DATE! !TIME! Executando o script "%%G"... >> "Execucao.log"
    ECHO -------------------------------------------------------- >> "Execucao.log"
    ECHO. >> "Execucao.log"
    
    sqlcmd /S ARMG51 /d HTAF -E -i"%%G" >> "Execucao.log"
    
    ECHO. >> "Execucao.log"
    ECHO Fim da execucao: !DATE! !TIME! >> "Execucao.log"
    ECHO -------------------------------------------------------- >> "Execucao.log"
    ECHO. >> "Execucao.log"
    ECHO. >> "Execucao.log"
    
)
 
PAUSE