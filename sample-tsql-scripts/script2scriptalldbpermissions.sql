set nocount on

/*Grant All Databases Access Script*/

Print '---------------------------------Script Grant All DB Access---------------------------------------'
Print '--------------------------------------------------------------------------------------------------'

exec sp_msforeachdb 'Use [?] select ''Use '' + ''?'' + CHAR(13) + CHAR(10)+ ''GO''
+ CHAR(13) + CHAR(10) + ''if not exists (select * from dbo.sysusers where name = N''''''+''''+usu.name+'''''')''+ Char(13) + Char(10) +   
''EXEC sp_grantdbaccess N''''''+ lo.loginname collate database_default +  '''''''' + '',N''''''+ usu.name collate database_default+ ''''''''  +char(13) + char(10) + ''GO''
from sysusers usu , master.dbo.syslogins lo where usu.sid = lo.sid and (usu.islogin = 1 and usu.isaliased = 0 and usu.hasdbaccess = 1)'

Print '--------------------------------Grant All DB Access Script Complete for All DB---------------------'
Print '---------------------------------------------------------------------------------------------------'

/*Add Roles to All Databases Script*/

Print '-------------------------------Script Adding Roles All Databases-----------------------------------'
Print '---------------------------------------------------------------------------------------------------'

exec sp_msforeachdb 'Use [?] select ''Use '' + ''?'' + CHAR(13) + CHAR(10)+ ''GO''
+ CHAR(13) + CHAR(10) + ''if not exists (select *  from dbo.sysusers where name = N''''''+ name +'''''' )'' + Char(13) + Char(10) +
''EXEC sp_addrole N'''''' + name collate database_default +  '''''''' + Char(13) + Char(10) + ''GO''
from sysusers where uid > 0 and uid=gid and issqlrole=1'

Print '--------------------------------Adding Roles Script Complete for All DB----------------------------'
Print '---------------------------------------------------------------------------------------------------'

/*Add Role Members All Databases Script */

Print '-------------------------------Script Role Members All Databases-----------------------------------'
Print '---------------------------------------------------------------------------------------------------'

exec sp_msforeachdb 'Use [?] select ''Use '' + ''?'' + CHAR(13) + CHAR(10)+ ''GO''+ CHAR(13) + CHAR(10) +
''exec sp_addrolemember N'''''' + user_name(groupuid) collate database_default + ''''''''+ '',N'''''' + user_name (memberuid) collate database_default + '''''''' + Char(13) + Char(10) + ''GO''
from sysmembers where  user_name (memberuid) <> ''dbo'' order by groupuid'

Print '-----------------------------Adding Role Members Script Complete for All DB------------------------'
Print '---------------------------------------------------------------------------------------------------'

/*Add Alias Login All Databases*/

Print '------------------------------Script Add Alias All Databases---------------------------------------'
Print '---------------------------------------------------------------------------------------------------'

exec sp_msforeachdb 'Use [?] select ''Use '' + ''?'' + CHAR(13) + CHAR(10)+ ''GO''
+ CHAR(13) + CHAR(10) + ''if not exists (select * from dbo.sysusers where name = N''''''+''''+ a.name +'''''')'' + Char(13) + Char(10) +
''EXEC sp_addalias N'''''' + substring(a.name , 2, len(a.name)) collate database_default +''''''''+ '',N''''''+ b.name collate database_default +  '''''''' + Char(13) + Char(10) +''GO''
from sysusers a , sysusers b where a.altuid = b.uid and a.isaliased=1'

Print '------------------------------Add Alias Script Complete for All DB---------------------------------'
Print '---------------------------------------------------------------------------------------------------'