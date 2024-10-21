# E-Commerce Report API

This project is an E-Commerce Report API built with Go. It provides various endpoints for generating reports related to sales, customers, and product performance based on data stored in a PostgreSQL database.

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/avyjyo11/ecom-report-api.git
   cd ecom-report-api
   ```

2. **Create .env file in root directory:**

   ```env
   DB_USER=your_db_user
   DB_PASSWORD=your_db_password
   DB_HOST=localhost
   DB_PORT=5432
   DB_NAME=your_db_name
   SSL_MODE=disable
   ```

3. **Install dependencies**

   ```bash
     go mod tidy
   ```

4. **Run migration scripts setup**

a. **Setup golang-migrate in your system**

Follow the steps in given:
https://www.freecodecamp.org/news/database-migration-golang-migrate/

```bash
  go get -u github.com/golang-migrate/migrate/v4
```

b. **After setup, run migrate command**

To run the migration scripts, use the following command:

```bash
  make migrate-up
```

note: add DB_URL in environment variable. check makefile for info

OR

```bash
  migrate -path migrations/ -database "postgresql://username:secretkey@localhost:5432/database_name?sslmode=disable" -verbose up
```

Replace your_db_user, your_db_password, and your_db_name with your actual database credentials.

### Usage:

To run the API, use the following command:

```bash
   go run cmd/main.go
```

OR

```bash
  make run
```

### API Endpoints

**Sales Report**

- GET /reports/sales

Fetches the sales report based on query parameters.

**Customer Report**

- GET /reports/customers

Fetches the customer report with total revenue based on query params.

### Database optimization doc:

[Readme.md](https://github.com/avyjyo11/ecom-report-api/blob/main/db/README.md)
