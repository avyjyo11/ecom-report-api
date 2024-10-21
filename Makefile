DB_URL=$(shell echo $$POSTGRES_ECOMM_DB_URL)

build:
	go build -o bin/main cmd/main.go

run:
	go run cmd/main.go

migrate-up: 
	migrate -path migrations/ -database "$(DB_URL)" -verbose up

migrate-down: 
	migrate -path migrations/ -database "$(DB_URL)" -verbose down 

migrate-fix: 
	migrate -path migrations/ -database "$(DB_URL)" force 102103