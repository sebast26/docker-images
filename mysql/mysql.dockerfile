FROM mysql:8.0
MAINTAINER Sebastian Gorecki

COPY ./scripts/init-sebatest-db.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]


# To build:
# docker build -f mysql-sebatest.dockerfile --tag mysql-sebatest .

# To run the image
# docker run -p 3306:3306 --env-file mysql-sebatest.env -d --name mysql-sebatest mysql-sebatest

# To run another container with mysql client against original mysql container:
# docker run -it --link mysql-sebatest:mysql --rm mysql-sebatest sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"' 
