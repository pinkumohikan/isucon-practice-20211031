.PHONY: gogo build stop-services start-services truncate-logs kataribe bench

gogo: stop-services truncate-logs start-services bench

build:
	cd webapp/go && go build .

stop-services:
	sudo systemctl stop nginx
	sudo systemctl stop isucondition.php
	sudo systemctl stop mariadb

start-services:
	sudo systemctl start mariadb
	sudo systemctl start isucondition.php
	sudo systemctl start nginx

truncate-logs:
	sudo truncate --size 0 /var/log/nginx/access.log
	sudo truncate --size 0 /var/log/nginx/error.log
	sudo truncate --size 0 /var/log/mysql/error.log
	sudo truncate --size 0 /var/log/mysql/mysql-slow.log

kataribe:
	sudo cat /var/log/nginx/access.log | ./kataribe

bench:
	ssh isucon@35.77.19.223 "cd ./bench && ./bench -tls -all-addresses "172.31.27.78" -target 172.31.27.78:443 -jia-service-url http://172.31.17.228:5000"
