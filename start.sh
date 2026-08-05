#!/bin/bash

# E-Commerce Application Quick Start Script

set -e

echo "🚀 Starting E-Commerce Application..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Copy environment file if not exists
if [ ! -f .env ]; then
    echo "📋 Creating .env file from .env.example..."
    cp .env.example .env
    echo "✅ .env file created. Please update with your configuration."
fi

# Build and start services
echo "🐳 Building and starting Docker services..."
docker-compose up -d

# Wait for services to be healthy
echo "⏳ Waiting for services to be ready..."
sleep 10

# Check if backend is running
if docker-compose logs backend | grep -q "Started EcommerceApplication"; then
    echo "✅ Backend is running"
else
    echo "⚠️  Backend may still be starting..."
fi

# Display access information
echo ""
echo "════════════════════════════════════════════════════"
echo "✅ Application Started Successfully!"
echo "════════════════════════════════════════════════════"
echo ""
echo "🌐 Frontend: http://localhost:80"
echo "   (or) http://localhost:3000"
echo ""
echo "🔌 Backend API: http://localhost:8080/api"
echo ""
echo "📚 Swagger UI: http://localhost:8080/api/swagger-ui.html"
echo ""
echo "💾 Database: postgresql://localhost:5432/ecommerce_db"
echo "   User: ecommerce_user"
echo "   Password: password (from .env)"
echo ""
echo "════════════════════════════════════════════════════"
echo ""
echo "Useful Commands:"
echo "  View logs: docker-compose logs -f"
echo "  View backend logs: docker-compose logs -f backend"
echo "  View frontend logs: docker-compose logs -f frontend"
echo "  Stop services: docker-compose down"
echo "  Stop and remove volumes: docker-compose down -v"
echo ""
