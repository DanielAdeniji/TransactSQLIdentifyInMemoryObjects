


use [ppsivr]
go


/*

	oe_emp_home_dept
		oe_emp_home_dept	char	no	6

*/

--BEGIN ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'English')  
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

begin tran

	select top 10 tblE.*

	from   [dbo].[oe_emp] tblE --WITH (SNAPSHOT) 

	--inner join dbo.oe_dep tblD WITH (SNAPSHOT) 

	--	on tblE.[record_id] = tblD.[record_id]

commit tran