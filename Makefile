start:
	docker compose build --pull --no-cache
	docker-compose up

stop:
	docker compose down --remove-orphans

tests: bin-phpunit

bin-phpunit:
	@echo "$(STEP) Exécution des tests... $(STEP)"
	-php -d memory_limit=-1 ./vendor/bin/phpunit --configuration phpunit.xml.dist
