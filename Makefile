TARGET = AdamDateApp

.PHONY: clean
clean:
	swift package clean

.PHONY: format
format:
	swift format -r -p -i .

.PHONY: lint
lint:
	swift format lint -r -p .

.PHONY: build
build:
	swift build -Xswiftc -warnings-as-errors

.PHONY: docker-build
docker-build:
	docker buildx build --platform linux/amd64 -t adam-date-app -t adamayoung/adam-date-app -t adamayoung/adam-date-app:latest .

.PHONY: docker-push
docker-push:
	docker push adamayoung/adam-date-app:latest

.PHONY: build-tests
build-tests:
	swift build --build-tests -Xswiftc -warnings-as-errors

.PHONY: build-release
build-release:
	swift build -c release -Xswiftc -warnings-as-errors

.PHONY: test
test:
	swift build --build-tests -Xswiftc -warnings-as-errors
	swift test --skip-build

.PHONY: local-env
local:
	docker-compose -f docker-compose.yml up --remove-orphans --build

.PHONY: local-env
local-dev:
	docker-compose -f docker-compose-infra.yml up --remove-orphans

.PHONY: run
run:
	swift run $(TARGET)

.PHONY: deploy-prod
deploy-prod:
	az group create --name AdamDateProdRG --location uksouth
	az deployment group create --name LocalDeployment --resource-group AdamDateProdRG --template-file main.bicep --parameters prod.bicepparam

.PHONY: migrate
migrate:
	swift run $(TARGET) migrate

.PHONY: migrate-revert
migrate-revert:
	swift run $(TARGET) migrate --revert

.PHONY: migrate-prod
migrate-prod:
	swift run $(TARGET) --env production migrate

.PHONY: migrate-revert-prod
migrate-revert-prod:
	swift run $(TARGET) --env production migrate --revert
