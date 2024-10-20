package migrations

import (
	"database/sql"
	"log"

	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/pgx/v5"
)

// RunMigrations applies the database migrations
func RunMigrations(connString string) {
		db, err := sql.Open("pgx", connString)
		if err != nil {
			log.Fatalf("failed to create db instance: %v", err)
		}
		driver, err := pgx.WithInstance(db, &pgx.Config{})
    if err != nil {
        log.Fatalf("failed to create driver: %v", err)
    }

    m, err := migrate.NewWithDatabaseInstance(
        "file:///Users/avyjyo/Documents/Workspace/bench/ecom-report-api/migrations", // Path to migrations folder
        "pgx",          // Your database name
        driver,
    )
    if err != nil {
        log.Fatalf("failed to create migrate instance: %v", err)
    }

    if err := m.Up(); err != nil {
        if err != migrate.ErrNoChange {
            log.Fatalf("failed to apply migrations: %v", err)
        }
    }

    log.Println("Migrations applied successfully!")
}
