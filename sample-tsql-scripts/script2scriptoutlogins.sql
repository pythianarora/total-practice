USE [master]
GO
IF OBJECT_ID ('fn_hexadecimal') IS NOT NULL
DROP function fn_hexadecimal
GO
CREATE FUNCTION [dbo].[fn_hexadecimal]
(
    -- Add the parameters for the function here
     @binvalue varbinary(256)
)
RETURNS VARCHAR(256)
AS
BEGIN

    DECLARE @charvalue varchar(1000)
    DECLARE @i int
    DECLARE @length int
    DECLARE @hexstring char(16)
    SELECT @charvalue = '0x'
    SELECT @i = 1
    SELECT @length = DATALENGTH (@binvalue)
    SELECT @hexstring = '0123456789ABCDEF'
    WHILE (@i <= @length)
    BEGIN
      DECLARE @tempint int
      DECLARE @firstint int
      DECLARE @secondint int
      SELECT @tempint = CONVERT(int, SUBSTRING(@binvalue,@i,1))
      SELECT @firstint = FLOOR(@tempint/16)
      SELECT @secondint = @tempint - (@firstint*16)
      SELECT @charvalue = @charvalue +
        SUBSTRING(@hexstring, @firstint+1, 1) +
        SUBSTRING(@hexstring, @secondint+1, 1)
      SELECT @i = @i + 1
    END
    return @charvalue

END
GO


SET NOCOUNT ON
GO
--use MASTER
GO
PRINT '-----------------------------------------------------------------------------'
PRINT '-- Script created on ' + CAST(GETDATE() AS VARCHAR(100))
PRINT '-----------------------------------------------------------------------------'
PRINT ''
PRINT '-----------------------------------------------------------------------------'
PRINT '-- Create the windows logins'
PRINT '-----------------------------------------------------------------------------'
SELECT 'IF NOT EXISTS (SELECT * FROM master.sys.server_principals WHERE [name] = ''' + [name] + ''')
    CREATE LOGIN [' + [name] + '] FROM WINDOWS WITH DEFAULT_DATABASE=[' +
        default_database_name + '], DEFAULT_LANGUAGE=[us_english]
GO

'
FROM master.sys.server_principals
where type_desc In ('WINDOWS_GROUP', 'WINDOWS_LOGIN')
AND [name] not like 'BUILTIN%'
and [NAME] not like 'NT AUTHORITY%'
and [name] not like '%\SQLServer%'
GO

PRINT '-----------------------------------------------------------------------------'
PRINT '-- Create the SQL Logins'
PRINT '-----------------------------------------------------------------------------'
select 'IF NOT EXISTS (SELECT * FROM master.sys.sql_logins WHERE [name] = ''' + [name] + ''')
CREATE LOGIN [' + [name] + '] WITH PASSWORD=' + [master].[dbo].[fn_hexadecimal](password_hash) + ' HASHED, SID = ' + [master].[dbo].[fn_hexadecimal]([sid]) + ', DEFAULT_DATABASE=[' + default_database_name + '], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=' + CASE WHEN is_expiration_checked = 1 THEN 'ON' ELSE 'OFF' END + ', CHECK_POLICY=OFF
GO
IF EXISTS (SELECT * FROM master.sys.sql_logins WHERE [name] = ''' + [name] + ''')
ALTER LOGIN [' + [name] + '] WITH CHECK_EXPIRATION=' + CASE WHEN is_expiration_checked = 1 THEN 'ON' ELSE 'OFF' END + ', CHECK_POLICY=' + CASE WHEN is_policy_checked = 1 THEN 'ON' ELSE 'OFF' END + '
GO
'
--[name], [sid] , password_hash
from master.sys.sql_logins
where type_desc = 'SQL_LOGIN'
and [name] not in ('sa', 'guest')

PRINT '-----------------------------------------------------------------------------'
PRINT '-- Disable any logins'
PRINT '-----------------------------------------------------------------------------'
SELECT 'ALTER LOGIN [' + [name] + '] DISABLE
GO
'
from master.sys.server_principals
where is_disabled = 1

PRINT '-----------------------------------------------------------------------------'
PRINT '-- Assign groups'
PRINT 'GO'
PRINT '-----------------------------------------------------------------------------'
select
'EXEC master..sp_addsrvrolemember @loginame = N''' + l.name + ''', @rolename = N''' + r.name + '''
GO

'
from master.sys.server_role_members rm
join master.sys.server_principals r on r.principal_id = rm.role_principal_id
join master.sys.server_principals l on l.principal_id = rm.member_principal_id
where l.[name] not in ('sa')
AND l.[name] not like 'BUILTIN%'
and l.[NAME] not like 'NT AUTHORITY%'
and l.[name] not like '%\SQLServer%'