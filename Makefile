start:
	docker compose build --pull --no-cache
	docker-compose up

stop:
	docker compose down --remove-orphans

deploy:
	docker rmi -f smsaed/back-app
	docker build \
	--build-arg APP_ENV=prod \
	--build-arg HTTP_PORT=80 \
	--build-arg HTTPS_PORT=443 \
	--build-arg HTTP3_PORT=443 \
	--build-arg WEBSITE_NAME=backend.foo.bar \
	--build-arg CERTS_PATH='./docker/caddy/certs'\
	--build-arg SSL_CERT='_wildcard.foo.bar.pem' \
	--build-arg SSL_CERT_KEY='_wildcard.foo.bar-key.pem' \
	--build-arg DATABASE_USER=chiron_user \
    --build-arg DATABASE_PASSWORD=If1JSl73p9aT \
    --build-arg DATABASE_IP=postgres-database-1 \
    --build-arg DATABASE_PORT=5432 \
    --build-arg DATABASE_NAME=chiron_local \
    --build-arg POSTGRES_VERSION=14 \
	 -t smsaed/back-app:latest46 .
	docker image push smsaed/back-app:latest46
	docker pull smsaed/back-app:latest46
	docker run --name back-app -p 443:443 -d smsaed/back-app:latest46

tests: bin-phpunit

bin-phpunit:
	@echo "$(STEP) Exécution des tests... $(STEP)"
	-php -d memory_limit=-1 ./vendor/bin/phpunit --configuration phpunit.xml.dist
