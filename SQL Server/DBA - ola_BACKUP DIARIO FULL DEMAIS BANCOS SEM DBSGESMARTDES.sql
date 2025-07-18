﻿BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - ola_BACKUP DIARIO FULL DEMAIS BANCOS SEM DBSGESMARTDES', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'ADM\sqladmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup DB_MatricPP', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''DBMATRIC_PP\FULL\*.bak''
EXEC xp_cmdshell @cmd;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup IntegraMXM', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''IntegraMXM\FULL\*.bak''
EXEC xp_cmdshell @cmd;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup Pergamarc', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PERGAMARC\FULL\*.bak''
EXEC xp_cmdshell @cmd;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup Traces', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''TRACES\FULL\*.bak''
EXEC xp_cmdshell @cmd;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup MOL', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''MOL\FULL\*.bak''
EXEC xp_cmdshell @cmd;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup GerenciaUsuarios', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''GerenciaUsuarios\FULL\*.bak''
EXEC xp_cmdshell @cmd;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup ProducaoDN', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''ProducaoDN\FULL\*.bak''
EXEC xp_cmdshell @cmd;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup ProducaoDNArquivo', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''ProducaoDNArquivo\FULL\*.bak''
EXEC xp_cmdshell @cmd;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup PRS', 
		@step_id=9, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PRS\FULL\*.bak''
EXEC xp_cmdshell @cmd;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup NetSqlAzManStorage', 
		@step_id=10, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''NetSqlAzManStorage\FULL\*.bak''
EXEC xp_cmdshell @cmd;
', 
		@database_name=N'DBMATRIC_PP', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup DbCorreios', 
		@step_id=11, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''DbCorreios\FULL\*.bak''
EXEC xp_cmdshell @cmd;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup PDN01D', 
		@step_id=12, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PDN01D\FULL\*.bak''
EXEC xp_cmdshell @cmd;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup PLANCONS', 
		@step_id=13, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PLANCONS_2022\FULL\*.bak''
EXEC xp_cmdshell @cmd;
GO

DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PLANCONS_2021\FULL\*.bak''
EXEC xp_cmdshell @cmd;
GO

DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PLANCONS_2020\FULL\*.bak''
EXEC xp_cmdshell @cmd;
GO

DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PLANCONS_2019\FULL\*.bak''
EXEC xp_cmdshell @cmd;
GO

DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PLANCONS_2018\FULL\*.bak''
EXEC xp_cmdshell @cmd;
GO

DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PLANCONS_2017\FULL\*.bak''
EXEC xp_cmdshell @cmd;
GO

DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PLANCONS_2016\FULL\*.bak''
EXEC xp_cmdshell @cmd;
GO

DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PLANCONS_2015\FULL\*.bak''
EXEC xp_cmdshell @cmd;
GO

DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PLANCONS_2014\FULL\*.bak''
EXEC xp_cmdshell @cmd;
GO

DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PLANCONS_2013\FULL\*.bak''
EXEC xp_cmdshell @cmd;
GO

DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PLANCONS_2012\FULL\*.bak''
EXEC xp_cmdshell @cmd;
GO

DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''PLANCONS_2011\FULL\*.bak''
EXEC xp_cmdshell @cmd;
GO
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DBA - BACKUP DIARIO TODOS BANCOS', 
		@step_id=14, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dia varchar(10), @cmd varchar(1000), @db varchar(60), @dir varchar(100)

set @dia = (
	SELECT 
	CASE DATEPART(w, GETDATE()) 
	WHEN 1 THEN ''DOMINGO''
	WHEN 2 THEN ''SEGUNDA''
	WHEN 3 THEN ''TERCA''
	WHEN 4 THEN ''QUARTA''
	WHEN 5 THEN ''QUINTA'' 
	WHEN 6 THEN ''SEXTA''
	WHEN 7 THEN ''SABADO''
	END AS ''DiaSemana''
)

--print @dthr
if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end
--print @dir

EXECUTE dbo.DatabaseBackup
@Databases = ''ALL_DATABASES, -%DbSgeSmartDes%'',
@Directory = @dir,
@BackupType = ''FULL'',
@Compress = ''Y''

', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'DBA - BACKUP DIARIO FULL DEMAIS BANCOS', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=126, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20190426, 
		@active_end_date=99991231, 
		@active_start_time=3000, 
		@active_end_time=235959, 
		@schedule_uid=N'd1cf9a34-0087-4722-9962-ed5d21759bd3'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

