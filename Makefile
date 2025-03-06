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
local-env:
	docker-compose -f docker-compose-dev.yml up --remove-orphans

.PHONY: migrate
migrate:
	swift run $(TARGET) migrate
