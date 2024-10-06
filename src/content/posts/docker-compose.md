---
title: how to install and run docker on linux
description: how to install and run your first container in docker on ubuntu 
date: 2024-10-06T14:20:00+01:00
tags:
  - docker
  - learning
  - linux
  - devops


toc: false
---

# Getting Started with Docker Compose

Docker Compose is a tool for defining and managing multi-container Docker applications. With a simple YAML file, you can configure all of your application’s services, making it easier to develop, ship, and run distributed systems.

## Why Use Docker Compose?

Docker Compose simplifies the following:

- **Multi-container orchestration**: You can define multiple containers in a single file and manage them as a group.
- **Easier configuration**: Services, networks, and volumes are all defined in a single `docker-compose.yml` file.
- **Reusability**: You can reuse your Compose file in different environments (development, testing, production) by specifying different configurations.

## Installing Docker Compose

If Docker is already installed on your machine, you can check if Docker Compose is installed by running:

```bash
docker-compose --version
```

If it’s not installed, follow the [official installation guide](https://docs.docker.com/compose/install/) based on your OS.

## Defining Your Application with `docker-compose.yml`

The main configuration for Docker Compose is defined in a file called `docker-compose.yml`. Here’s the basic structure:

```yaml
version: '3'
services:
  service_name:
    image: image_name:tag
    ports:
      - "host_port:container_port"
    volumes:
      - host_directory:container_directory
    environment:
      - ENV_VAR_NAME=value
```

Let’s go through an example.

## Example 1: Simple Web Application with Nginx and Redis

In this example, we'll set up a simple web application with two services: `nginx` and `redis`.

```yaml
version: '3'
services:
  web:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html
  redis:
    image: redis:alpine
    ports:
      - "6379:6379"
```

### Explanation:
- **`web` service**: Runs Nginx and exposes port 80 inside the container to port 8080 on the host.
- **`redis` service**: Runs Redis, exposing port 6379 to the host.

Now, you can start both services by running:

```bash
docker-compose up
```

Visit `http://localhost:8080` to see the Nginx welcome page, and Redis will be accessible on port 6379.

## Example 2: Running a Django + PostgreSQL Application

Here’s an example of setting up a Django application with PostgreSQL as the database.

```yaml
version: '3'
services:
  db:
    image: postgres:13
    environment:
      POSTGRES_USER: django_user
      POSTGRES_PASSWORD: django_password
      POSTGRES_DB: django_db
    volumes:
      - pgdata:/var/lib/postgresql/data
  web:
    image: django:latest
    volumes:
      - .:/code
    ports:
      - "8000:8000"
    depends_on:
      - db
    environment:
      - DATABASE_URL=postgres://django_user:django_password@db:5432/django_db

volumes:
  pgdata:
```

### Explanation:
- **`db` service**: Runs a PostgreSQL database with environment variables for the username, password, and database name.
- **`web` service**: Runs a Django application and maps the code from the local directory to the container.

### Start the Services:
```bash
docker-compose up
```

Django will start on `http://localhost:8000`, and it will be connected to the PostgreSQL container.

## Scaling Services with Docker Compose

You can scale services horizontally using the `--scale` flag. For example, to run multiple instances of the `web` service:

```bash
docker-compose up --scale web=3
```

This command runs three instances of the `web` service.

## Common Docker Compose Commands

- **Starting services**:  
  ```bash
  docker-compose up
  ```

- **Starting in detached mode** (runs containers in the background):  
  ```bash
  docker-compose up -d
  ```

- **Stopping services**:  
  ```bash
  docker-compose down
  ```

- **Viewing logs**:  
  ```bash
  docker-compose logs
  ```

- **Rebuilding containers** (after changes):  
  ```bash
  docker-compose up --build
  ```

- **Checking the status of running containers**:  
  ```bash
  docker-compose ps
  ```

## Conclusion

Docker Compose is a powerful tool for managing multi-container Docker applications. Whether you're developing locally or deploying in production, Docker Compose simplifies running complex setups with just a single command.

You can learn more by exploring the [Docker Compose documentation](https://docs.docker.com/compose/), where advanced topics like networking, production deployments, and Compose file structure are covered in more detail.
```

This article introduces Docker Compose with examples and covers basic commands. Let me know if you'd like to add more advanced topics or a different use case!iHere’s an article on Docker Compose, written in Markdown:

```markdown
# Getting Started with Docker Compose

Docker Compose is a tool for defining and managing multi-container Docker applications. With a simple YAML file, you can configure all of your application’s services, making it easier to develop, ship, and run distributed systems.

## Why Use Docker Compose?

Docker Compose simplifies the following:

- **Multi-container orchestration**: You can define multiple containers in a single file and manage them as a group.
- **Easier configuration**: Services, networks, and volumes are all defined in a single `docker-compose.yml` file.
- **Reusability**: You can reuse your Compose file in different environments (development, testing, production) by specifying different configurations.

## Installing Docker Compose

If Docker is already installed on your machine, you can check if Docker Compose is installed by running:

```bash
docker-compose --version
```

If it’s not installed, follow the [official installation guide](https://docs.docker.com/compose/install/) based on your OS.

## Defining Your Application with `docker-compose.yml`

The main configuration for Docker Compose is defined in a file called `docker-compose.yml`. Here’s the basic structure:

```yaml
version: '3'
services:
  service_name:
    image: image_name:tag
    ports:
      - "host_port:container_port"
    volumes:
      - host_directory:container_directory
    environment:
      - ENV_VAR_NAME=value
```

Let’s go through an example.

## Example 1: Simple Web Application with Nginx and Redis

In this example, we'll set up a simple web application with two services: `nginx` and `redis`.

```yaml
version: '3'
services:
  web:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html
  redis:
    image: redis:alpine
    ports:
      - "6379:6379"
```

### Explanation:
- **`web` service**: Runs Nginx and exposes port 80 inside the container to port 8080 on the host.
- **`redis` service**: Runs Redis, exposing port 6379 to the host.

Now, you can start both services by running:

```bash
docker-compose up
```

Visit `http://localhost:8080` to see the Nginx welcome page, and Redis will be accessible on port 6379.

## Example 2: Running a Django + PostgreSQL Application

Here’s an example of setting up a Django application with PostgreSQL as the database.

```yaml
version: '3'
services:
  db:
    image: postgres:13
    environment:
      POSTGRES_USER: django_user
      POSTGRES_PASSWORD: django_password
      POSTGRES_DB: django_db
    volumes:
      - pgdata:/var/lib/postgresql/data
  web:
    image: django:latest
    volumes:
      - .:/code
    ports:
      - "8000:8000"
    depends_on:
      - db
    environment:
      - DATABASE_URL=postgres://django_user:django_password@db:5432/django_db

volumes:
  pgdata:
```

### Explanation:
- **`db` service**: Runs a PostgreSQL database with environment variables for the username, password, and database name.
- **`web` service**: Runs a Django application and maps the code from the local directory to the container.

### Start the Services:
```bash
docker-compose up
```

Django will start on `http://localhost:8000`, and it will be connected to the PostgreSQL container.

## Scaling Services with Docker Compose

You can scale services horizontally using the `--scale` flag. For example, to run multiple instances of the `web` service:

```bash
docker-compose up --scale web=3
```

This command runs three instances of the `web` service.

## Common Docker Compose Commands

- **Starting services**:  
  ```bash
  docker-compose up
  ```

- **Starting in detached mode** (runs containers in the background):  
  ```bash
  docker-compose up -d
  ```

- **Stopping services**:  
  ```bash
  docker-compose down
  ```

- **Viewing logs**:  
  ```bash
  docker-compose logs
  ```

- **Rebuilding containers** (after changes):  
  ```bash
  docker-compose up --build
  ```

- **Checking the status of running containers**:  
  ```bash
  docker-compose ps
  ```

## Conclusion

Docker Compose is a powerful tool for managing multi-container Docker applications. Whether you're developing locally or deploying in production, Docker Compose simplifies running complex setups with just a single command.

You can learn more by exploring the [Docker Compose documentation](https://docs.docker.com/compose/), where advanced topics like networking, production deployments, and Compose file structure are covered in more detail.
