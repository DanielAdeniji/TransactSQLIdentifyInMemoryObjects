use [ppsivr]
go


select
		 [table]
			= quotename(tblSS.[name])
				+ '.'
				+ quotename(tblST.[name])

from   sys.tables tblST

inner join sys.schemas tblSS

		on tblST.[schema_id] = tblSS.[schema_id]

where  tblST.is_memory_optimized = 1

order by
		[table] asc


