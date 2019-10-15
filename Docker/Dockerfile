FROM ubuntu:18.04

WORKDIR database

COPY  scripts database/

RUN apt update

RUN apt install -y mysql-server

RUN service mysql start && \
    mysql < database/permissions.sql && \
    mysql < database/schema.sql &&  mysql northwind < database/data.sql

EXPOSE 3306

CMD [ "mysqld", "--user=root" ]