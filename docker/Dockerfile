FROM mysql:5.7
MAINTAINER Jimmy Dixon <jamesalandixon@gmail.com>

LABEL Description="Development environment MySQL database and production schema documentation."

COPY schema/boxers.sql /docker-entrypoint-initdb.d
COPY schema/data.sql /docker-entrypoint-initdb.d