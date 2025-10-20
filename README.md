# Clinique Digitale JEE

Clinique Digitale JEE is a Java EE-based web application for managing a digital clinic. It provides features for managing patients, doctors, appointments, departments, specialties, and staff, with a modern web interface and robust backend.

## Features
- Patient, doctor, and staff management
- Appointment scheduling and tracking
- Department and specialty management
- User authentication and authorization
- Admin dashboard
- Doctor and patient dashboards

## Technologies Used
- Java EE (Jakarta EE)
- JPA (Hibernate)
- JSP/Servlets
- Maven
- Docker (for deployment)
- PostgreSQL (database)

## Project Structure
- `src/main/java` - Java source code (models, repositories, services, controllers)
- `src/main/resources` - Configuration files (logging, persistence)
- `src/main/webapp` - JSP pages, static resources (CSS, JS)
- `docker/` - Docker configuration and scripts
- `pom.xml` - Maven build file

## Getting Started

### Prerequisites
- Java 17 or later
- Maven
- Docker (for containerized deployment)

### Build and Run (Local)
1. Clone the repository:
   ```sh
   git clone <repo-url>
   cd CliniqueDigitaleJEE
   ```
2. Build the project:
   ```sh
   mvn clean install
   ```
3. Deploy the generated WAR file (`target/CliniqueDigitaleJEE.war`) to your application server (e.g., Tomcat).

### Run with Docker
1. Build and start the containers:
   ```sh
   docker-compose up --build
   ```
2. Access the application at `http://localhost:8080/CliniqueDigitaleJEE`

## Configuration
- Database and other settings can be configured in `src/main/resources/META-INF/persistence.xml` and `docker/` configs.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the MIT License.

