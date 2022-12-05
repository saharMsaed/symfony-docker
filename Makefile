start-with-build:
	docker compose build --pull --no-cache
	docker-compose up

start:
	docker-compose up

stop:
	docker compose down --remove-orphans

deploy:
	docker container rm -f back-app
	docker build -t smsaed/back-app:latest .
	docker run --name back-app -p 443:443 -p 80:80 \
	-e APP_ENV=prod \
	-e HTTP_PORT=80 \
	-e HTTPS_PORT=443 \
	-e HTTP3_PORT=443 \
	-e WEBSITE_NAME=galien.back.local \
	-e CERTS_PATH='./docker/caddy/certs' \
	-e SSL_CERT='_wildcard.galien.back.local.pem' \
	-e SSL_CERT_KEY='_wildcard.galien.back.local-key.pem' \
	-e DATABASE_USER=galien_user \
    -e DATABASE_PASSWORD=If1JSl73p9aT \
    -e DATABASE_IP=postgres-database-1 \
    -e DATABASE_PORT=5432 \
    -e DATABASE_NAME=galien_local \
    -e POSTGRES_VERSION=14 \
    -d smsaed/back-app:latest

## Tests

tests: bin-phpunit
tests-coverage: coverage

bin-phpunit:
	@echo "$(STEP) Exécution des tests... $(STEP)"
	-php -d memory_limit=-1 ./vendor/bin/phpunit --configuration phpunit.xml.dist

coverage:
	@echo "$(STEP) Exécution des tests avec analyse du coverage... $(STEP)"
	-XDEBUG_MODE=coverage php -d memory_limit=-1 ./vendor/bin/phpunit --configuration phpunit.xml.dist --log-junit docs/coverage/junit-report.xml --coverage-text --coverage-cobertura=docs/coverage/cobertura.xml --coverage-html docs/coverage --coverage-clover docs/coverage/result.xml
