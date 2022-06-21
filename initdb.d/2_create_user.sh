#!/bin/bash

function fn_create_user
{
	local create_user_rel="CREATE USER 'repl'@'%' IDENTIFIED BY 'pass';
							GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'repl'@'%';
							FLUSH PRIVILEGES;"

	local create_user_dbz="CREATE USER 'dbz'@'%' IDENTIFIED BY 'dbz';
							GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT  ON *.* TO 'dbz'@'%';
							FLUSH PRIVILEGES;"

	if [[ $(hostname) == *primary* || $(hostname) == mysql ]]; then
		echo "Primary node"
		mysql -P 3306 -uroot -proot -e "$create_user_rel"
		mysql -P 3306 -uroot -proot -e "$create_user_dbz"
	else
		echo "No Primary node"
	fi
}

function fn_main
{
	exit

	fn_create_user
}

fn_main $@
