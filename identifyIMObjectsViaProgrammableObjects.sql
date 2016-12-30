
use [ppsivr]
go

/*

	exec sp_helpuser
*/

/*

	sys.sql_modules

		execute_as_principal_id

			Value of -2 indicates that the batch submitted does not depend on implicit name resolution and can be shared among different users. 
			This is the preferred method. Any other value represents the user ID of the user submitting the query in the database.

*/

select 
		  [object]
			= quoteName(tblSS.[name])
				+ '.'
				+ quoteName(object_name(tblSSM.[object_id]))

		, [type]
			= tblSO.type_desc

		, [createDate]
			= tblSO.[create_date]

		, [isSchemaBound]
			= case
					when tblSSM.is_schema_bound = 1 then 'Y'
					else 'N'
			  end	

		, [principal]
			= case
			 
					when ( tblSSM.execute_as_principal_id is null ) 
						then tblSS.[name]
			  
					when  ( tblSSM.execute_as_principal_id = -2) 
						then '--Shared--'

					else user_name(tblSSM.execute_as_principal_id)

						  
			  end			 
		      
		, [definition]
			= tblSSM.[definition]

from  sys.objects tblSO

inner join sys.schemas tblSS

		on tblSO.[schema_id] = tblSS.[schema_id]

inner join sys.sql_modules tblSSM

		on tblSO.[object_id] = tblSSM.[object_id]

where tblSSM.[uses_native_compilation] = 1