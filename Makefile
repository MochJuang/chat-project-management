AUTH_BINARY=AuthenticationService
WEBSOCKET_BINARY=WebSocketService
CHAT_BINARY=ChatService
NOTIFICATION_BINARY=NotificationService

up: build_auth build_websocket
	@echo "Starting Docker images..."
	docker-compose up -d
	@echo "Docker images started!"

up_build: build_auth build_websocket build_chat build_notification
	@echo "Stopping docker images (if running...)"
	docker-compose down
	@echo "Building (when required) and starting docker images..."
	docker-compose up --build -d
	@echo "Docker images built and started!"

## down: stop docker compose
down:
	@echo "Stopping docker compose..."
	docker-compose down
	@echo "Done!"

build_auth:
	@echo "Building auth binary..."
	cd ../authentication-service && env GOOS=linux CGO_ENABLED=0 go build -o ${AUTH_BINARY} ./cmd/api
	@echo "Done!"

build_websocket:
	@echo "Building websocket binary..."
	cd ../websocket-service && env GOOS=linux CGO_ENABLED=0 go build -o ${WEBSOCKET_BINARY} ./cmd/api
	@echo "Done!"

build_chat:
	@echo "Building chat binary..."
	cd ../chat-service && env GOOS=linux CGO_ENABLED=0 go build -o ${CHAT_BINARY} ./cmd/api
	@echo "Done!"

build_notification:
	@echo "Building chat binary..."
	cd ../notification-service && env GOOS=linux CGO_ENABLED=0 go build -o ${NOTIFICATION_BINARY} ./cmd/api
	@echo "Done!"
