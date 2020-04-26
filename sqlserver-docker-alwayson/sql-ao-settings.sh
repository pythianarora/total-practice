# wait for the SQL Server to come up
sleep 90s
# run the setup script to create the DB and the schema in the DB
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "P@ssw0rd" -i sql-ao-setup.sql
# ensuring sql agent is up and restarting mssql service
/opt/mssql/bin/mssql-conf set sqlagent.enabled true 
systemctl restart mssql-server