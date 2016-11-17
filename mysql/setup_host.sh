# Usage: ./setup_host.sh [app_name]

# Export APP_NAME variable
# export APP_NAME=sebatest

# Create data directory
# mkdir -p $HOME/docker-volumes/sebatest

# Create mysql-<app_name>.env file
# cp mysql.env.template mysql-sebatest.env
# change MYSQL_DATABASE=sebatest

# Create db init script
# cp scripts/init-db.sql scripts/init-sebatest-db.sql
# change USE sebatest;

# Create mysql-<app_name>.dockerfile
# cp mysql.dockerfile mysql-sebatest.dockerfile
