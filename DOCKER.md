# 🐳 Docker Setup for Todo App

This guide explains how to build and run the Todo App using Docker and Docker Compose.

## 📋 Prerequisites

- **Docker** (version 20.10+)
- **Docker Compose** (version 2.0+)
- **Git** (to clone the repository)

## 🚀 Quick Start with Docker Compose

### 1. Clone the Repository
```bash
git clone https://github.com/Ngocanhjr/Todo_App.git
cd Todo_App
```

### 2. Build the Application
```bash
cd todoapp
./mvnw clean package -DskipTests
cd ..
```

### 3. Run with Docker Compose
```bash
docker compose up -d
```

This command will:
- Build the Todo application Docker image
- Pull MySQL 8.0 image
- Start both services with proper networking
- Create persistent volume for MySQL data

### 3. Access the Application
- **Todo App**: [http://localhost:8080](http://localhost:8080)
- **MySQL**: `localhost:3306` (if you need direct database access)

### 4. Stop the Application
```bash
docker compose down
```

To remove volumes (⚠️ **this will delete all data**):
```bash
docker compose down -v
```

---

## 🛠 Manual Docker Build and Run

### 1. Build the Application
```bash
cd todoapp
./mvnw clean package -DskipTests
cd ..
```

### 2. Build the Docker Image
```bash
docker build -t todo-app:latest .
```

### 2. Run MySQL Container
```bash
docker run -d \
  --name todo-mysql \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=todoappdb \
  -e MYSQL_USER=todouser \
  -e MYSQL_PASSWORD=todopassword \
  -p 3306:3306 \
  mysql:8.0
```

### 3. Run Todo App Container
```bash
docker run -d \
  --name todo-app \
  --link todo-mysql:mysql \
  -e DB_URL=jdbc:mysql://mysql:3306/todoappdb \
  -e DB_USERNAME=todouser \
  -e DB_PASSWORD=todopassword \
  -p 8080:8080 \
  todo-app:latest
```

---

## ⚙️ Environment Variables

The application supports the following environment variables:

| Variable | Default Value | Description |
|----------|---------------|-------------|
| `DB_URL` | `jdbc:mysql://localhost:3306/todoappdb` | Database connection URL |
| `DB_USERNAME` | `root` | Database username |
| `DB_PASSWORD` | `rhna` | Database password |
| `SPRING_PROFILES_ACTIVE` | (none) | Spring Boot profile to activate |

---

## 📊 Monitoring and Health Checks

### Health Check Endpoints
- **Application Health**: [http://localhost:8080/actuator/health](http://localhost:8080/actuator/health)
- **Application Info**: [http://localhost:8080/actuator/info](http://localhost:8080/actuator/info)

### Check Container Status
```bash
docker compose ps
```

### View Application Logs
```bash
# All services
docker compose logs

# Todo app only
docker compose logs todo-app

# MySQL only
docker compose logs mysql

# Follow logs in real-time
docker compose logs -f todo-app
```

---

## 🔧 Development

### Rebuilding After Code Changes
```bash
docker compose down
docker compose up --build
```

### Running in Development Mode
For development, you might want to mount the source code:
```bash
# Create docker compose.override.yml for development
version: '3.8'
services:
  todo-app:
    volumes:
      - ./todoapp/src:/app/src:ro
    environment:
      SPRING_DEVTOOLS_RESTART_ENABLED: true
```

---

## 🐛 Troubleshooting

### Common Issues

#### 1. Port Already in Use
```bash
# Check what's using port 8080
sudo netstat -tulpn | grep :8080

# Stop existing containers
docker compose down
```

#### 2. Database Connection Issues
```bash
# Check MySQL container logs
docker compose logs mysql

# Ensure MySQL is healthy
docker compose ps
```

#### 3. Build Issues
```bash
# Clean build
docker compose down
docker system prune -a
docker compose up --build
```

#### 4. Permission Issues (Linux/macOS)
```bash
# Make sure mvnw is executable
chmod +x todoapp/mvnw
```

### Database Access

To connect to MySQL directly:
```bash
docker compose exec mysql mysql -u todouser -p todoappdb
# Password: todopassword
```

---

## 📈 Production Considerations

### Security
- Change default passwords in production
- Use Docker secrets for sensitive data
- Enable SSL/TLS for database connections
- Configure firewall rules appropriately

### Performance
- Adjust JVM heap size: `-e JAVA_OPTS="-Xmx512m"`
- Configure connection pooling parameters
- Use external MySQL instance for better performance

### Backup
```bash
# Backup MySQL data
docker compose exec mysql mysqldump -u todouser -p todoappdb > backup.sql

# Restore MySQL data
docker compose exec -T mysql mysql -u todouser -p todoappdb < backup.sql
```

---

## 📚 Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Spring Boot Docker Guide](https://spring.io/guides/gs/spring-boot-docker/)
- [MySQL Docker Hub](https://hub.docker.com/_/mysql)