#!/bin/bash

#VOLUME_HOME="/var/lib/mysql"

#sed 's/REDIS_HOST/'$REDIS_HOST'/g' -i /app/im_stat.php
#sed 's/REDIS_PORT/'$REDIS_PORT'/g' -i /app/im_stat.php
#sed 's/REDIS_PASS/'$REDIS_PASS'/g' -i /app/im_stat.php
sed -i '1i\masterauth '$REDIS_PASS /etc/redis/redis.conf
sed -i '1i\slaveof '$REDIS_HOST' '$REDIS_PORT /etc/redis/redis.conf

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/apache2/php.ini
# if [[ ! -d $VOLUME_HOME/mysql ]]; then
#     echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
#     echo "=> Installing MySQL ..."
#     mysql_install_db > /dev/null 2>&1
#     echo "=> Done!"  
#     /create_mysql_admin_user.sh
# else
#     echo "=> Using an existing volume of MySQL"
# fi

exec supervisord -n
