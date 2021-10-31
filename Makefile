.PHONY: gogo build stop-services start-services truncate-logs kataribe

gogo: stop-services build truncate-logs start-services

build:
	cd webapp/go && go build .

stop-services:
	sudo systemctl stop nginx
	sudo systemctl stop isucondition.go
	sudo systemctl stop mariadb

start-services:
	sudo systemctl start mariadb
	sudo systemctl start isucondition.go
	sudo systemctl start nginx

truncate-logs:
	sudo truncate --size 0 /var/log/nginx/access.log
	sudo truncate --size 0 /var/log/nginx/error.log

kataribe:
	sudo cat /var/log/nginx/access.log | ./kataribe