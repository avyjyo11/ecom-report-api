module github.com/avyjyo11/ecom-report-api

go 1.23.2

require (
	github.com/go-chi/chi/v5 v5.1.0
	github.com/golang-migrate/migrate/v4 v4.18.1
	github.com/jackc/pgx/v5 v5.7.1
)

require (
	github.com/hashicorp/errwrap v1.1.0 // indirect
	github.com/hashicorp/go-multierror v1.1.1 // indirect
	github.com/jackc/pgerrcode v0.0.0-20240316143900-6e2875d9b438 // indirect
	github.com/jackc/pgpassfile v1.0.0 // indirect
	github.com/jackc/pgservicefile v0.0.0-20240606120523-5a60cdf6a761 // indirect
	github.com/jackc/puddle/v2 v2.2.2 // indirect
	go.uber.org/atomic v1.11.0 // indirect
	golang.org/x/crypto v0.28.0 // indirect
	golang.org/x/sync v0.8.0 // indirect
	golang.org/x/text v0.19.0 // indirect
)

replace ecom-service-api/config => ./config

replace ecom-service-api/services => ./services

replace ecom-service-api/controllers => ./controllers

replace ecom-service-api/repositories => ./repositories
