FROM mcr.microsoft.com/mssql/server:2017-latest

EXPOSE 1433
EXPOSE 5022

ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD="p@ssw0rd"
ENV MSSQL_PID=Developer

# Certificate previously generated (see Readme.md)
ENV CERTFILE "./dbm_certificate_cer"
ENV CERTFILE_PWD "./dbm_certificate_pvk"

RUN mkdir /usr/certificate
WORKDIR /usr/
COPY ${CERTFILE} ./certificate
COPY ${CERTFILE} ./certificate
COPY ${CERTFILE_PWD} ./certificate

# Enable SQL Server Agent
RUN /opt/mssql/bin/mssql-conf set sqlagent.enabled true

# Enable availability groups
RUN /opt/mssql/bin/mssql-conf set hadr.hadrenabled 1

# Run SQL Server process.
CMD /opt/mssql/bin/sqlservr