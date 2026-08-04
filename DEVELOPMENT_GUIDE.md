# E-Commerce Application Development Guide

## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [Tech Stack](#tech-stack)
3. [Architecture](#architecture)
4. [Prerequisites](#prerequisites)
5. [Project Structure](#project-structure)
6. [Backend Setup](#backend-setup)
7. [Frontend Setup](#frontend-setup)
8. [Database Configuration](#database-configuration)
9. [Docker Setup](#docker-setup)
10. [AWS Deployment](#aws-deployment)
11. [Development Workflow](#development-workflow)
12. [Testing](#testing)
13. [Troubleshooting](#troubleshooting)

---

## Project Overview

This is a production-ready end-to-end e-commerce application built with modern technologies. It provides a complete shopping experience with:

- **User Management**: Registration, authentication, profiles
- **Product Catalog**: Browse, search, filter products
- **Shopping Cart**: Add/remove items, manage quantities
- **Orders**: Checkout, order history, tracking
- **Admin Dashboard**: Product management, order management, user management
- **Payments**: Integration-ready payment gateway support
- **Security**: JWT authentication, role-based access control
- **Scalability**: Containerized, cloud-ready deployment

---

## Tech Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| **Backend** | Java | 21 (LTS) |
| **Framework** | Spring Boot | 3.x |
| **Build Tool** | Gradle | 8.x |
| **Frontend** | Vue.js | 3.x |
| **Database** | PostgreSQL/MySQL | Latest |
| **Cache** | Redis | 7.x (optional) |
| **Containerization** | Docker | Latest |
| **Orchestration** | Docker Compose | Latest |
| **Cloud** | AWS | Free Tier |

---

## Architecture

```
┌─────────────────────────────────────────────────────┐
│                   Client (Vue.js)                   │
│              - SPA with Vite/Webpack               │
│              - Responsive UI/UX                    │
└────────────────────────┬────────────────────────────┘
                         │ HTTP/HTTPS
┌────────────────────────▼────────────────────────────┐
│         API Gateway / Load Balancer (AWS)           │
└────────────────────────┬────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────┐
│        Spring Boot REST API (Java 21)               │
│  - Authentication/Authorization                    │
│  - Business Logic                                  │
│  - API Endpoints                                   │
│  - Validation & Exception Handling                 │
└────────────────────────┬────────────────────────────┘
                         │
          ┌──────────────┼──────────────┐
          │              │              │
    ┌─────▼──────┐  ┌───▼────────┐  ┌─▼──────────┐
    │ PostgreSQL │  │   Redis    │  │ AWS S3     │
    │  Database  │  │   Cache    │  │   Storage  │
    └────────────┘  └────────────┘  └────────────┘
```

---

## Prerequisites

### System Requirements
- **OS**: Windows, macOS, or Linux
- **CPU**: Minimum 2 cores (4+ recommended)
- **RAM**: Minimum 4GB (8GB recommended)
- **Disk**: 20GB free space

### Required Software

#### Java Development
```
✓ JDK 21 (Amazon Corretto, OpenJDK, or Oracle JDK)
✓ Gradle 8.x or later
✓ IDE: IntelliJ IDEA, VS Code, or Eclipse
```

#### Node.js & Frontend
```
✓ Node.js 18.x or later
✓ npm 9.x or pnpm 8.x
```

#### Database
```
✓ PostgreSQL 15+ OR MySQL 8.0+
✓ Database client: pgAdmin, MySQL Workbench, or CLI
```

#### Containerization
```
✓ Docker (latest version)
✓ Docker Compose
```

#### AWS
```
✓ AWS Account (free tier eligible)
✓ AWS CLI v2
✓ AWS credentials configured
```

---

## Project Structure

```
ecommerceapp/
│
├── backend/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/ecommerce/
│   │   │   │   ├── controller/
│   │   │   │   │   ├── AuthController.java
│   │   │   │   │   ├── ProductController.java
│   │   │   │   │   ├── OrderController.java
│   │   │   │   │   └── UserController.java
│   │   │   │   ├── service/
│   │   │   │   │   ├── AuthService.java
│   │   │   │   │   ├── ProductService.java
│   │   │   │   │   ├── OrderService.java
│   │   │   │   │   └── UserService.java
│   │   │   │   ├── repository/
│   │   │   │   │   ├── UserRepository.java
│   │   │   │   │   ├── ProductRepository.java
│   │   │   │   │   └── OrderRepository.java
│   │   │   │   ├── entity/
│   │   │   │   │   ├── User.java
│   │   │   │   │   ├── Product.java
│   │   │   │   │   ├── Order.java
│   │   │   │   │   └── OrderItem.java
│   │   │   │   ├── dto/
│   │   │   │   │   ├── LoginRequest.java
│   │   │   │   │   ├── RegisterRequest.java
│   │   │   │   │   ├── ProductDTO.java
│   │   │   │   │   └── OrderDTO.java
│   │   │   │   ├── security/
│   │   │   │   │   ├── JwtTokenProvider.java
│   │   │   │   │   ├── JwtAuthenticationFilter.java
│   │   │   │   │   └── SecurityConfig.java
│   │   │   │   ├── exception/
│   │   │   │   │   ├── ApiException.java
│   │   │   │   │   └── GlobalExceptionHandler.java
│   │   │   │   └── EcommerceApplication.java
│   │   │   └── resources/
│   │   │       ├── application.yml
│   │   │       ├── application-dev.yml
│   │   │       ├── application-prod.yml
│   │   │       └── db/migration/ (Flyway/Liquibase scripts)
│   │   └── test/
│   │       └── java/com/ecommerce/
│   │
│   ├── build.gradle
│   ├── settings.gradle
│   ├── Dockerfile
│   └── .dockerignore
│
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── Header.vue
│   │   │   ├── Footer.vue
│   │   │   ├── ProductCard.vue
│   │   │   ├── Cart.vue
│   │   │   └── Checkout.vue
│   │   ├── views/
│   │   │   ├── Home.vue
│   │   │   ├── ProductList.vue
│   │   │   ├── ProductDetail.vue
│   │   │   ├── Cart.vue
│   │   │   ├── Login.vue
│   │   │   ├── Register.vue
│   │   │   ├── Orders.vue
│   │   │   └── Admin.vue
│   │   ├── store/
│   │   │   ├── modules/
│   │   │   │   ├── auth.js
│   │   │   │   ├── products.js
│   │   │   │   ├── cart.js
│   │   │   │   └── orders.js
│   │   │   └── index.js
│   │   ├── services/
│   │   │   ├── api.js
│   │   │   ├── authService.js
│   │   │   ├── productService.js
│   │   │   └── orderService.js
│   │   ├── App.vue
│   │   └── main.js
│   ├── public/
│   ├── package.json
│   ├── vite.config.js
│   ├── Dockerfile
│   └── .dockerignore
│
├── docker-compose.yml
├── docker-compose.prod.yml
├── DEVELOPMENT_GUIDE.md (this file)
├── DEPLOYMENT_GUIDE.md
├── .github/
│   └── workflows/
│       ├── ci.yml
│       └── deploy.yml
├── .gitignore
└── README.md
```

---

## Backend Setup

### Step 1: Initialize Spring Boot Project

If not already initialized, create a new Spring Boot project:

```bash
# Using Spring Boot CLI
spring boot new ecommerce-backend --from=https://start.spring.io \
  -dweb,data-jpa,security,validation,postgresql,lombok

# Or manually via Spring Initializr:
# 1. Visit https://start.spring.io
# 2. Select Java 21, Spring Boot 3.x
# 3. Add dependencies: Spring Web, Spring Data JPA, Spring Security, PostgreSQL Driver, Lombok
```

### Step 2: Configure Gradle

**build.gradle** - Core dependencies:

```gradle
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.2.0'
    id 'io.spring.dependency-management' version '1.1.4'
}

group = 'com.ecommerce'
version = '1.0.0'
sourceCompatibility = '21'

repositories {
    mavenCentral()
}

dependencies {
    // Spring Boot Starters
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.springframework.boot:spring-boot-starter-security'
    implementation 'org.springframework.boot:spring-boot-starter-validation'

    // Database
    runtimeOnly 'org.postgresql:postgresql'
    // OR for MySQL: runtimeOnly 'mysql:mysql-connector-java:8.0.33'

    // Utilities
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'

    // JWT Authentication
    implementation 'io.jsonwebtoken:jjwt-api:0.12.3'
    runtimeOnly 'io.jsonwebtoken:jjwt-impl:0.12.3'
    runtimeOnly 'io.jsonwebtoken:jjwt-jackson:0.12.3'

    // API Documentation
    implementation 'org.springdoc:springdoc-openapi-starter-webmvc-ui:2.2.0'

    // Testing
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    testImplementation 'org.springframework.security:spring-security-test'
}

tasks.named('test') {
    useJUnitPlatform()
}
```

### Step 3: Application Configuration

**application.yml**:

```yaml
spring:
  application:
    name: ecommerce-api
  
  datasource:
    url: jdbc:postgresql://localhost:5432/ecommerce_db
    username: ecommerce_user
    password: ${DB_PASSWORD:password}
    driver-class-name: org.postgresql.Driver
  
  jpa:
    hibernate:
      ddl-auto: validate
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
        format_sql: true
        jdbc:
          batch_size: 20
    show-sql: false
  
  jackson:
    serialization:
      write-dates-as-timestamps: false
  
  cors:
    allowed-origins: ${CORS_ORIGINS:http://localhost:3000}
    allowed-methods: GET,POST,PUT,DELETE,OPTIONS
    allowed-headers: '*'

server:
  port: 8080
  servlet:
    context-path: /api

jwt:
  secret: ${JWT_SECRET:your-secret-key-change-in-production}
  expiration: 86400000  # 24 hours in milliseconds

logging:
  level:
    root: INFO
    com.ecommerce: DEBUG
```

### Step 4: Core Backend Implementation

**Entity Example** - User.java:

```java
@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String firstName;

    private String lastName;

    @Enumerated(EnumType.STRING)
    private Role role = Role.USER;

    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    private LocalDateTime updatedAt = LocalDateTime.now();

    private boolean active = true;
}
```

**Service Example** - AuthService.java:

```java
@Service
@Slf4j
public class AuthService {
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private JwtTokenProvider jwtTokenProvider;

    public AuthResponse login(LoginRequest request) {
        Optional<User> user = userRepository.findByEmail(request.getEmail());
        if (user.isEmpty() || !passwordEncoder.matches(request.getPassword(), user.get().getPassword())) {
            throw new ApiException("Invalid credentials", HttpStatus.UNAUTHORIZED);
        }
        
        String token = jwtTokenProvider.generateToken(user.get());
        return new AuthResponse(token, user.get());
    }

    public AuthResponse register(RegisterRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new ApiException("Email already exists", HttpStatus.BAD_REQUEST);
        }

        User user = User.builder()
            .email(request.getEmail())
            .password(passwordEncoder.encode(request.getPassword()))
            .firstName(request.getFirstName())
            .lastName(request.getLastName())
            .build();

        userRepository.save(user);
        String token = jwtTokenProvider.generateToken(user);
        return new AuthResponse(token, user);
    }
}
```

---

## Frontend Setup

### Step 1: Initialize Vue.js Project

```bash
# Using Vite (recommended for Vue 3)
npm create vite@latest ecommerce-frontend -- --template vue

# Navigate to project
cd ecommerce-frontend

# Install dependencies
npm install
```

### Step 2: Essential Dependencies

**package.json** - Add these dependencies:

```bash
npm install axios vue-router pinia dotenv
npm install --save-dev @vitejs/plugin-vue sass
```

### Step 3: Project Setup

**router/index.js** - Configure routing:

```javascript
import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import ProductList from '../views/ProductList.vue'
import Cart from '../views/Cart.vue'

const routes = [
  { path: '/', component: Home },
  { path: '/login', component: Login },
  { path: '/products', component: ProductList },
  { path: '/cart', component: Cart },
  // Add more routes
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
```

**store/index.js** - Pinia state management:

```javascript
import { createPinia } from 'pinia'

const pinia = createPinia()

export default pinia
```

**services/api.js** - API client:

```javascript
import axios from 'axios'

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || 'http://localhost:8080/api'
})

api.interceptors.request.use(config => {
  const token = localStorage.getItem('token')
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
  return config
})

export default api
```

---

## Database Configuration

### PostgreSQL Setup

```bash
# Using Docker (recommended)
docker run --name ecommerce-postgres \
  -e POSTGRES_USER=ecommerce_user \
  -e POSTGRES_PASSWORD=your_password \
  -e POSTGRES_DB=ecommerce_db \
  -p 5432:5432 \
  -d postgres:15-alpine

# Verify
docker ps
```

### Database Initialization

**SQL Scripts** (src/main/resources/db/migration/V1__Initial_Schema.sql):

```sql
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    role VARCHAR(20) DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN DEFAULT TRUE
);

CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT DEFAULT 0,
    category VARCHAR(100),
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT NOT NULL REFERENCES orders(id),
    product_id BIGINT NOT NULL REFERENCES products(id),
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
```

---

## Docker Setup

### Backend Dockerfile

**backend/Dockerfile**:

```dockerfile
# Build stage
FROM gradle:8.3-jdk21 as builder
WORKDIR /app
COPY . .
RUN gradle build --no-daemon -x test

# Runtime stage
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

### Frontend Dockerfile

**frontend/Dockerfile**:

```dockerfile
# Build stage
FROM node:18-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Runtime stage
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### Docker Compose

**docker-compose.yml**:

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    container_name: ecommerce-postgres
    environment:
      POSTGRES_USER: ecommerce_user
      POSTGRES_PASSWORD: ${DB_PASSWORD:-password}
      POSTGRES_DB: ecommerce_db
    ports:
      - "5432:5432"
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - ecommerce-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ecommerce_user"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    container_name: ecommerce-redis
    ports:
      - "6379:6379"
    networks:
      - ecommerce-network
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile
    container_name: ecommerce-backend
    ports:
      - "8080:8080"
    environment:
      DB_PASSWORD: ${DB_PASSWORD:-password}
      JWT_SECRET: ${JWT_SECRET:-your-secret-key}
      CORS_ORIGINS: http://localhost:3000,http://localhost
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    networks:
      - ecommerce-network
    restart: unless-stopped

  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    container_name: ecommerce-frontend
    ports:
      - "80:80"
    environment:
      VITE_API_URL: http://localhost:8080/api
    depends_on:
      - backend
    networks:
      - ecommerce-network
    restart: unless-stopped

volumes:
  postgres-data:

networks:
  ecommerce-network:
    driver: bridge
```

---

## AWS Deployment

### Prerequisites
- AWS Account with free tier eligible
- AWS CLI installed and configured
- Docker Hub account (for container registry)

### Step 1: Push Images to AWS ECR

```bash
# Create ECR repositories
aws ecr create-repository --repository-name ecommerce-backend --region us-east-1
aws ecr create-repository --repository-name ecommerce-frontend --region us-east-1

# Get login token
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com

# Tag and push images
docker build -t ecommerce-backend ./backend
docker tag ecommerce-backend:latest <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/ecommerce-backend:latest
docker push <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/ecommerce-backend:latest

docker build -t ecommerce-frontend ./frontend
docker tag ecommerce-frontend:latest <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/ecommerce-frontend:latest
docker push <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/ecommerce-frontend:latest
```

### Step 2: Setup RDS Database (Free Tier)

```bash
# Create PostgreSQL RDS instance
aws rds create-db-instance \
  --db-instance-identifier ecommerce-db \
  --db-instance-class db.t3.micro \
  --engine postgres \
  --master-username admin \
  --master-user-password '<YOUR_PASSWORD>' \
  --allocated-storage 20 \
  --storage-type gp2 \
  --no-publicly-accessible \
  --db-name ecommerce_db \
  --region us-east-1
```

### Step 3: Deploy with ECS Fargate (Free Tier)

```bash
# Create ECS cluster
aws ecs create-cluster --cluster-name ecommerce-cluster

# Create task definitions and services
# See DEPLOYMENT_GUIDE.md for detailed steps
```

### Step 4: Setup Route 53 & CloudFront (Optional)

```bash
# For custom domain and CDN caching
aws route53 create-hosted-zone --name yourdomain.com
aws cloudfront create-distribution --distribution-config file://cloudfront-config.json
```

### Cost Optimization for Free Tier

- **EC2**: t2.micro or t3.micro instances
- **RDS**: db.t3.micro with 20GB storage (free for 12 months)
- **NAT Gateway**: Use VPC endpoints instead
- **Data Transfer**: Minimize cross-region traffic
- **Monitoring**: Use CloudWatch free tier limits

---

## Development Workflow

### Running Locally

```bash
# Terminal 1: Start services
docker-compose up

# Terminal 2: Backend
cd backend
gradle bootRun

# Terminal 3: Frontend
cd frontend
npm run dev
```

### Environment Variables

**Create .env files:**

**.env.backend** (backend root):
```
DB_PASSWORD=your_password
JWT_SECRET=your_secret_key_here
CORS_ORIGINS=http://localhost:3000
```

**.env.frontend** (frontend root):
```
VITE_API_URL=http://localhost:8080/api
```

### Code Quality

```bash
# Backend linting
gradle checkstyleMain

# Frontend linting
npm run lint

# Format code
gradle spotlessApply
npm run format
```

---

## Testing

### Backend Testing

```bash
# Run all tests
gradle test

# Run specific test
gradle test --tests UserControllerTest

# Run with coverage
gradle jacocoTestReport
```

### Frontend Testing

```bash
# Unit tests
npm run test

# E2E tests
npm run test:e2e

# Coverage
npm run test:coverage
```

---

## Troubleshooting

### Common Issues

**1. Database connection failed**
```bash
# Check if postgres container is running
docker ps | grep postgres

# View logs
docker logs ecommerce-postgres

# Reset database
docker rm ecommerce-postgres
docker volume rm ecommerce-postgres-data
```

**2. Port already in use**
```bash
# Kill process on port
# Windows: netstat -ano | findstr :8080
# Linux/Mac: lsof -i :8080
```

**3. CORS errors**
- Verify `CORS_ORIGINS` in backend configuration
- Check frontend API URL matches backend

**4. JWT token issues**
- Verify `JWT_SECRET` is consistent
- Check token expiration time
- Ensure Authorization header format: `Bearer <token>`

### Useful Commands

```bash
# Docker
docker-compose logs -f backend
docker-compose exec postgres psql -U ecommerce_user -d ecommerce_db

# Gradle
gradle tasks
gradle dependencies

# npm
npm audit
npm outdated
```

---

## Next Steps

1. **Database Schema**: Design and implement your specific domain models
2. **API Endpoints**: Build REST endpoints for all business operations
3. **Authentication**: Implement JWT refresh tokens, 2FA
4. **Frontend Components**: Build reusable Vue components
5. **Testing**: Write comprehensive unit and integration tests
6. **CI/CD**: Setup GitHub Actions for automated testing and deployment
7. **Monitoring**: Configure CloudWatch, logging, and alerting
8. **Security**: Implement rate limiting, input validation, CORS properly
9. **Performance**: Add caching, pagination, indexing
10. **Documentation**: Generate API docs with Swagger/OpenAPI

---

## Resources

- [Spring Boot 3 Documentation](https://spring.io/projects/spring-boot)
- [Vue.js 3 Guide](https://vuejs.org/)
- [Docker Documentation](https://docs.docker.com/)
- [AWS Free Tier](https://aws.amazon.com/free/)
- [PostgreSQL Docs](https://www.postgresql.org/docs/)
- [Gradle Guide](https://gradle.org/guides/)

---

## Support & Contribution

For issues, questions, or contributions, please refer to the main README.md

---

**Last Updated**: 2026-08-04
**Version**: 1.0.0
