SELECT	TOP 50
		SPID,
		CONVERT(VARCHAR(12),CONVERT(TIME,EndTime - StartTime)) AS 'TmpExecution',
		TextData,
		Reads,
		Writes,
		CPU,
		RowCounts as RowCounts_linhas,
		--Duration,		
		StartTime, 
		EndTime,		
		Objectname,
		hostname,
		loginName,		
		DatabaseName,
		ServerName
FROM SYS.FN_TRACE_GETTABLE ('C:\totvs\PROFILER\JOFEGE - Cópia de movimento selecionado.trc', DEFAULT)
WHERE ENDTIME IS NOT NULL
ORDER BY DURATION DESC
