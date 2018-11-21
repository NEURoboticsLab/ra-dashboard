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
		mysql/mysql-server:5.5

MYSQL_CONN = mysql --host=127.0.0.1 --user=core --password=esn95384

.PHONY: run stop mysql

run:
	${MYSQL_RUN}
	${GRAFANA_RUN}

stop:
	docker stop ra-dashboard
	docker stop ra-database

mysql:
	${MYSQL_CONN}

mysql-init:
	${MYSQL_CONN} < mysql_init.sql

mysql-root:
	docker exec -it ra-database mysql -uroot -p

init:
	sudo apt-get install python-mysqldb
	mkdir -p grafana
	mkdir -p mysql

clean:
	rm -rf grafana/ mysql/
