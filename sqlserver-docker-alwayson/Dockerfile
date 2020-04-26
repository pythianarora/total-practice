FROM mcr.microsoft.com/mssql/server:2017-latest

EXPOSE 1433
EXPOSE 5022

ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD="P@ssw0rd"
ENV MSSQL_PID=Developer

# Create work directory
RUN mkdir -p /usr/work
WORKDIR /usr/work
# Copy all scripts into working directory
COPY . /usr/work/

# Grant permissions for the import-data script to be executable
RUN chmod +x /usr/work/sql-ao-settings.sh

# Enable SQL Server Agent
RUN /opt/mssql/bin/mssql-conf set sqlagent.enabled true

# Enable availability groups
RUN /opt/mssql/bin/mssql-conf set hadr.hadrenabled 1

# Run SQL Server process.
CMD /bin/bash ./entrypoint.sh