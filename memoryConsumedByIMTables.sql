
SELECT

	[object]
		= quotename(tblSS.name)
			+'.'
			+ quotename(tblSO.name)

    , [allocatedMB]
		= SUM(tblXTPMC.[allocated_bytes]) / (1024* 1024)

	, [usedMB]
		= SUM(tblXTPMC.[used_bytes]) / (1024 * 1024)

FROM  sys.objects tblSO

INNER JOIN sys.schemas tblSS
 
	ON tblSO.schema_id = tblSS.schema_id 

INNER JOIN sys.indexes tblSI
 
	ON tblSO.object_id = tblSI.object_id 

INNER JOIN sys.dm_db_xtp_memory_consumers tblXTPMC 

	ON  tblSI.object_id = tblXTPMC.object_id
	AND tblSI.index_id  = tblXTPMC.index_id

GROUP BY 
		  quotename(tblSS.name)
		, tblSO.schema_id
		, tblSO.object_id
		, tblSO.[name]
		
ORDER BY 
		  quotename(tblSS.name)
		, tblSO.[name]
;