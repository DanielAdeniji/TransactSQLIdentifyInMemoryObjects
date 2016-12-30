
SELECT
        [object]
        = quoteName(tblS.[name])
           + '.'
           + quoteName(tblO.[name])
 
		, [index]
			= tblSI.[name]

		, [indexType]
			= tblSI.[type_desc]

		, [isPrimaryKey]
			= case
				when ( tblSI.[is_primary_key] = 1 ) then 'Y'
				else 'N'
			  end

        , [scansStarted]
			= tblXTPIS.scans_started	

		, [scansRetried]
			= tblXTPIS.scans_retries
			
		, [rowsReturned]
			= tblXTPIS.rows_returned

		, [rowsTouched]
			= tblXTPIS.rows_touched	

		/*

		--- Expiring -----
		, tblXTPIS.rows_expiring
		, tblXTPIS.rows_expired
		, tblXTPIS.rows_expired_removed	
		--- Expiring -----

		-- Phantom ----
		, tblXTPIS.phantom_scans_started	
		, tblXTPIS.phantom_scans_retries	
		, tblXTPIS.phantom_rows_touched	
		, tblXTPIS.phantom_expiring_rows_encountered	
		--, phantom_expired_rows_encountered	
		, tblXTPIS.phantom_expired_removed_rows_encountered	
		, tblXTPIS.phantom_expired_rows_removed
		-- Phantom ----

		*/

FROM sys.dm_db_xtp_index_stats tblXTPIS
 
INNER JOIN sys.objects tblO
 
    ON tblXTPIS.object_id = tblO.object_id

INNER JOIN sys.indexes tblSI
 
    ON  tblXTPIS.object_id = tblSI.object_id 
    AND tblXTPIS.index_id = tblSI.index_id 

INNER JOIN sys.schemas tblS
 
    ON tblO.schema_id = tblS.schema_id

order by
		  tblS.[name]
		, tblO.[name]
		, tblSI.[name]