package config

import "os"

type Config struct {
    DBHost     string
    DBPort     string
    DBUser     string
    DBPassword string
    DBName     string
    SSLMode    string
}

// LoadConfig loads environment variables for the configuration
func LoadConfig() Config {
    return Config{
        DBHost:     getEnv("DB_HOST", "localhost"),
        DBPort:     getEnv("DB_PORT", "5432"),
        DBUser:     getEnv("DB_USER", "admin"),
        DBPassword: getEnv("DB_PASSWORD", "admin"),
        DBName:     getEnv("DB_NAME", "ecomm"),
        SSLMode:    getEnv("DB_SSLMODE", "disable"),
    }
}

// getEnv reads an environment variable or returns a default value
func getEnv(key, defaultValue string) string {
    value := os.Getenv(key)
    if value == "" {
        return defaultValue
    }
    return value
}
