DIR = $(shell pwd)

MYSQL = "ra-database"
MYSQL_DATA = "mysql/"
MYSQL_IMAGE = "mysql/mysql-server:5.7"
RUN_MYSQL = docker run --rm -d \
		-p 3306:3306 \
                --name=${MYSQL} \
		--user=0 \
                -e MYSQL_USER=core \
                -e MYSQL_PASSWORD=esn95384 \
                -e MYSQL_ROOT_PASSWORD=esn95384 \
		-t -v "${DIR}"/${MYSQL_DATA}:/var/lib/mysql \
		${MYSQL_IMAGE}

GRAFANA = "ra-dashboard"
GRAFANA_DATA = "grafana/"
GRAFANA_IMAGE = "grafana/grafana"
RUN_GRAFANA = docker run --rm -d \
		-p 3000:3000 \
                --name=${GRAFANA} \
		--user=0 \
                -e "GF_SECURITY_ADMIN_PASSWORD=esn95384" \
                --link ${MYSQL} \
		-t -v "${DIR}"/${GRAFANA_DATA}:/var/lib/grafana ${GRAFANA_IMAGE}

.PHONY: start stop mysql init clean

start:
	sudo ${RUN_MYSQL}
	sudo ${RUN_GRAFANA}

stop:
	sudo docker stop ${GRAFANA}
	sudo docker stop ${MYSQL}

mysql:
	mysql --host=127.0.0.1 --user=core --password=esn95384

MYSQL_INIT = $(shell cat mysql_init.sql)

init:
	sudo docker system prune
	sudo docker pull ${MYSQL_IMAGE}
	sudo docker pull ${GRAFANA_IMAGE}
	sudo apt-get install python-mysqldb python3-pymysql
	mkdir -p ${GRAFANA_DATA}
	mkdir -p ${MYSQL_DATA}
	sudo ${RUN_MYSQL}
	sudo docker exec -it ${MYSQL} mysql -uroot -p -e "${MYSQL_INIT}"
	sudo docker stop ${MYSQL}

clean:
	sudo rm -rf ${GRAFANA_DATA} ${MYSQL_DATA}
