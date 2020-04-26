# Availability Groups on SQL Server 2017 using docker containers

You can create a complete environment with 2 Avalability Group nodes by following steps:

1. Download the container image hosted on my docker repository.

```cmd
docker pull sandeeparora/sql2k17-ag-node
```

2. Run the infrastructure

```cmd
docker-compose up -d
```

Now, you have a 2 nodes (sql2k17node1 and sql2k17node2) sharing the network and prepared to be part of a new availability group.

3. Connect to sql2k17node1 on port 1433 (exposed on the host) and create the availability group using SSMS. 

4. Connect to sql2k17node2 on port 1434 (exposed on the host) and add it to the availability group created in step 3.

