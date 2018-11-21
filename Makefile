DIR = $(shell pwd)

GRAFANA_RUN = docker run --rm -d \
		-p 3000:3000 \
                --name=ra-dashboard \
		--user=0 \
                -e "GF_SECURITY_ADMIN_PASSWORD=esn95384" \
                --link ra-database \
		-t -v "${DIR}/grafana":/var/lib/grafana grafana/grafana

MYSQL_RUN = docker run --rm -d \
		-p 3306:3306 \
                --name=ra-database \
		--user=0 \
                -e MYSQL_USER=core \
                -e MYSQL_PASSWORD=esn95384 \
                -e MYSQL_ROOT_PASSWORD=esn95384 \
		-t -v "${DIR}"/mysql:/var/lib/mysql \
		mysql/mysql-server:5.7

.PHONY: run stop mysql init clean

run:
	sudo ${MYSQL_RUN}
	sudo ${GRAFANA_RUN}

stop:
	sudo docker stop ra-dashboard
	sudo docker stop ra-database

mysql:
	mysql --host=127.0.0.1 --user=core --password=esn95384

MYSQL_INIT = $(shell cat mysql_init.sql)

init:
	sudo docker pull mysql/mysql-server:5.7
	sudo docker pull grafana/grafana
	sudo apt-get install python-mysqldb
	mkdir -p grafana
	mkdir -p mysql
	sudo ${MYSQL_RUN}
	sudo docker exec -it ra-database mysql -uroot -p -e "${MYSQL_INIT}"
	sudo docker stop ra-database

clean:
	rm -rf grafana/ mysql/
