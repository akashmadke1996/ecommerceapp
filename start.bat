@echo off
REM E-Commerce Application Quick Start Script for Windows

echo.
echo 🚀 Starting E-Commerce Application...
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker is not installed. Please install Docker Desktop first.
    pause
    exit /b 1
)

REM Copy environment file if not exists
if not exist .env (
    echo 📋 Creating .env file from .env.example...
    copy .env.example .env
    echo ✅ .env file created. Please update with your configuration.
)

REM Build and start services
echo 🐳 Building and starting Docker services...
docker-compose up -d

REM Wait for services to be healthy
echo ⏳ Waiting for services to be ready...
timeout /t 10 /nobreak

REM Display access information
cls
echo.
echo ════════════════════════════════════════════════════
echo ✅ Application Started Successfully!
echo ════════════════════════════════════════════════════
echo.
echo 🌐 Frontend: http://localhost:80
echo    (or) http://localhost:3000
echo.
echo 🔌 Backend API: http://localhost:8080/api
echo.
echo 📚 Swagger UI: http://localhost:8080/api/swagger-ui.html
echo.
echo 💾 Database: postgresql://localhost:5432/ecommerce_db
echo    User: ecommerce_user
echo    Password: password (from .env)
echo.
echo ════════════════════════════════════════════════════
echo.
echo Useful Commands:
echo   View logs: docker-compose logs -f
echo   View backend logs: docker-compose logs -f backend
echo   View frontend logs: docker-compose logs -f frontend
echo   Stop services: docker-compose down
echo   Stop and remove volumes: docker-compose down -v
echo.
pause
