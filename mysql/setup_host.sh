#!/bin/bash
# Usage: export APP_NAME=[app_name] && ./setup_host.sh 

#
# Config variables
#
DATA_DIRECTORY=$HOME/docker-volumes

#
# Check if APP_NAME is set
#
if [ -z $APP_NAME ]; then
	echo "APP_NAME variable must be set."
	exit 1
fi

echo "Starting mysql setup for new '$APP_NAME' application..."

#
# Create data directory
#
DATA_DIR="$DATA_DIRECTORY/$APP_NAME"
echo -n "Creating data directory $DATA_DIR... "
mkdir -p $DATA_DIR
if [ $? -ne 0 ] ; then
	echo "error"
	exit
fi
echo "done"

#
# Create mysql-<app_name>.env file
#
echo -n "Preparing MySQL environment variables file... "
MYSQL_ENV_FILENAME="mysql-$APP_NAME.env"
cp "mysql.env.template" $MYSQL_ENV_FILENAME
if [ $? -ne 0 ] ; then
	echo "error"
	exit
fi

sed -i "s/{{APP_NAME}}/$APP_NAME/g" $MYSQL_ENV_FILENAME
if [ $? -ne 0 ] ; then
	echo "error"
	exit
fi
echo "done"

#
# Create db init script
#
echo -n "Preparing database initialization script... "
MYSQL_INIT_FILE="scripts/init-$APP_NAME-db.sql"
cp "scripts/init-db.sql.template" $MYSQL_INIT_FILE
if [ $? -ne 0 ] ; then
	echo "error"
	exit
fi

sed -i "s/{{APP_NAME}}/$APP_NAME/g" $MYSQL_INIT_FILE
if [ $? -ne 0 ] ; then
	echo "error"
	exit
fi
echo "done"

#
# Create mysql-<app_name>.dockerfile
#
echo -n "Preparing Docker file... "
DOCKER_FILE="mysql-$APP_NAME.dockerfile"
cp "mysql.dockerfile.template" $DOCKER_FILE
if [ $? -ne 0 ] ; then
	echo "error"
	exit
fi

sed -i "s/{{APP_NAME}}/$APP_NAME/g" $DOCKER_FILE
if [ $? -ne 0 ] ; then
	echo "error"
	exit
fi
echo "done"
