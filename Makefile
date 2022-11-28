start:
	#docker compose build --pull --no-cache
	docker-compose up

stop:
	docker compose down --remove-orphans

deploy:
# 	docker rmi -f smsaed/back-app
# 	docker build -t smsaed/back-app:latest5 .
# 	docker image push smsaed/back-app:latest5
# 	docker pull smsaed/back-app:latest5
	docker run --name back-app -p 443:443 -d smsaed/back-app:latest5

tests: bin-phpunit

bin-phpunit:
	@echo "$(STEP) Exécution des tests... $(STEP)"
	-php -d memory_limit=-1 ./vendor/bin/phpunit --configuration phpunit.xml.dist
