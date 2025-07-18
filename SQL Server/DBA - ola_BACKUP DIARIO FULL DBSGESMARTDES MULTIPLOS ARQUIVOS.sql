﻿BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - ola_BACKUP DIARIO FULL DBSGESMARTDES MULTIPLOS ARQUIVOS', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'executando as 00:02 por conta do fechamento de caixa zerado das unidades', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'ADM\sqladmin', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup SA Anterior', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
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

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''DbSgeSmartDes\FULL\DbSgeSmartDes_FULL*.bak''

EXEC xp_cmdshell @cmd;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga Backup Senac_BO Anterior', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
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

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''SENAC_BO\FULL\SENAC_BO_FULL*.bak''

EXEC xp_cmdshell @cmd;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DBA - BACKUP DBSGESMARTDES MULTIPLOS ARQUIVOS', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
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

EXECUTE dbo.DatabaseBackup 
@Databases = ''DbSgeSmartDes'', 
@Directory = @dir,
@BackupType = ''FULL'', 
@Compress = ''Y'', 
@BufferCount = 512, 
@MaxTransferSize = 4194304, 
@NumberOfFiles = 10
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga log SA', 
		@step_id=4, 
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

if @dia = ''SEGUNDA'' or @dia=''QUARTA'' or @dia=''SEXTA''
begin
	set @dir =(''K:\BACKUP1\SEG_QUA_SEX\'');
end
if @dia = ''TERCA'' or @dia=''QUINTA'' or @dia=''SABADO''
begin
	set @dir =(''H:\BACKUP2\TER_QUI_SAB\'');
end

SET @cmd = ''del '' + @dir + ''DbSgeSmartDes\LOG\DbSgeSmartDes_LOG*.trn''

EXEC xp_cmdshell @cmd;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'DBA - BACKUP SA MULTIPLOS ARQUIVOS', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=126, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20190521, 
		@active_end_date=99991231, 
		@active_start_time=200, 
		@active_end_time=235959, 
		@schedule_uid=N'7dcc476d-7423-4679-83ea-80e2004b908c'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

