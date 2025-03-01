# Tunde Obi - Official Website

A Spring Boot web application for Tunde Obi's official website, providing information about the author, books, and contact details.

## Features

- Home page with introductory content
- About page with author information
- Books showcase page
- Contact page with message submission
- Newsletter subscription functionality

## Technologies Used

- Java 17
- Spring Boot
- Maven
- Docker
- Thymeleaf (inferred from controller return values)

## Prerequisites

- Java 17 or higher
- Maven
- Docker and Docker Compose (for containerized deployment)

## Installation and Setup

### Local Development

1. Clone the repository
   ```bash
   git clone [repository-url]
   cd tundeobi
   ```

2. Build the application
   ```bash
   ./mvnw clean package
   ```

3. Run the application locally
   ```bash
   ./mvnw spring-boot:run
   ```

### Docker Deployment

1. Build and start the Docker container
   ```bash
   docker-compose up --build
   ```

## Usage

After starting the application, access the website at:
- http://localhost:8080

Available pages:
- Home: http://localhost:8080/
- About: http://localhost:8080/about
- Books: http://localhost:8080/books
- Contact: http://localhost:8080/contact

## Project Structure

- `src/main/java` - Java source files
- `src/main/resources` - Application resources and templates
- `src/test` - Test files

## Contributing

Please read the contribution guidelines before submitting pull requests.

## License

[License information]