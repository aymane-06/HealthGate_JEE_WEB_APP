# HealthGate JEE Web Application

A digital clinic management system built with Jakarta EE technologies and Java 17.

## 📋 Overview

HealthGate is a comprehensive web application designed for digital clinic management. Built using Jakarta EE specifications, this application provides a robust platform for healthcare management operations.

## 🚀 Technologies Used

### Backend
- **Java 17** - Core programming language
- **Jakarta EE** - Enterprise application framework
  - Jakarta Persistence API (JPA) 3.1.0
  - Jakarta Servlet 6.0.0
  - Jakarta EJB 4.0.1
  - Jakarta Bean Validation 3.0.2
- **Hibernate 6.5.2** - JPA implementation
- **PostgreSQL 42.7.3** - Database
- **HikariCP 5.1.0** - Connection pooling

### Frontend
- **JSP & JSTL 3.0.1** - Server-side rendering
- **Jakarta Servlet** - Web layer

### Security & Utilities
- **BCrypt (jBcrypt 0.4)** - Password hashing
- **Jackson 2.17.1** - JSON processing
- **SLF4J 2.0.13** - Logging framework

## 📦 Prerequisites

- Java Development Kit (JDK) 17 or higher
- Apache Maven 3.6+
- PostgreSQL database
- Apache TomEE or compatible Jakarta EE application server
- Docker & Docker Compose (optional, for containerized deployment)

## 🛠️ Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/aymane-06/HealthGate_JEE_WEB_APP.git
cd HealthGate_JEE_WEB_APP
```

### 2. Database Setup
Ensure PostgreSQL is running and create a database for the application. 

### 3. Using Docker Compose (Recommended)
```bash
docker-compose up -d
```

### 4. Manual Setup

#### Build the Project
```bash
mvn clean install
```

#### Deploy
Deploy the generated WAR file (`CliniqueDigitaleJEE.war`) to your TomEE or compatible Jakarta EE server.

## 📁 Project Structure

```
HealthGate_JEE_WEB_APP/
├── src/
│   └── main/
│       ├── java/          # Java source files
│       ├── resources/     # Configuration files
│       └── webapp/        # Web resources (JSP, CSS, JS)
├── docker-compose.yml     # Docker configuration
├── pom.xml               # Maven configuration
├── sync-frontend.sh      # Frontend synchronization script
└── JPAAnonotations.txt   # JPA annotations reference
```

## 🔧 Configuration

The application uses the following configuration: 
- **Maven Build**: WAR packaging
- **Final Name**: CliniqueDigitaleJEE
- **Encoding**: UTF-8
- **Java Version**: 17

## 🚀 Running the Application

### Using Maven
```bash
mvn clean package
# Deploy the WAR file from target/ directory to your application server
```

### Using Docker
```bash
docker-compose up
```

## 📝 Features

- Digital clinic management
- JPA-based data persistence
- Secure password handling with BCrypt
- RESTful capabilities with JSON support
- Transaction management
- Connection pooling for optimal database performance

## 🔐 Security

- Password encryption using BCrypt
- Jakarta Bean Validation for input validation
- Transaction management for data integrity

## 📚 Development

### Build Commands
- `mvn clean` - Clean build artifacts
- `mvn compile` - Compile the project
- `mvn package` - Create WAR file
- `mvn clean install` - Full build and install

### Frontend Synchronization
Use the provided script to sync frontend resources:
```bash
./sync-frontend.sh
```

## 📄 License

This project is currently unlicensed. Please contact the repository owner for usage terms.

## 👤 Author

**aymane-06**
- GitHub: [@aymane-06](https://github.com/aymane-06)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! 

## 📧 Support

For support, please open an issue in the GitHub repository.

---

**Note**: Make sure to configure your database connection settings and application server before deployment. 
```
