---
title: how to install and run docker on linux
description: how to install and run your first container in docker on ubuntu 
date: 2019-04-01T14:26:00+08:00
tags:
  - docker
  - learning
  - linux
  - devops
  - go
  - java
  - security
  - web
  - fullstack
  - frontend
  - backend
  - hosting
  - database
  - mysql
  - postgresql
  - ai
  - chatgpt
  - seo
  - mobile development
  - virtualization
  - aws
  - azure
  - SAAS
  - self hosting
  - university
  - leet code
  - algorithms
  - data structures
  - projects
  - open source
  - privacy
  - vpn
  - rust


toc: false
---
# Installing Docker and Running Your First Container on Linux

## Introduction

In the modern world of software development, the need for efficient and reliable deployment methods has led to the rise of containerization. Docker is one of the most popular tools in this space, allowing developers to package applications and their dependencies into standardized units called containers. This article will guide you through the installation of Docker on a Linux system and demonstrate how to run your first container.

## What is Docker?

Docker is an open-source platform designed to automate the deployment, scaling, and management of applications in lightweight, portable containers. Unlike traditional virtual machines, which require a full operating system to run, Docker containers share the host OS kernel and are therefore more efficient. This means they can start up quickly, use fewer resources, and be easily shared across environments, making Docker an essential tool for developers and system administrators alike.

With Docker, you can:

- **Package Applications**: Bundle your application with all its dependencies, ensuring that it runs the same regardless of the environment.
- **Isolate Environments**: Run multiple applications on the same host without conflicts.
- **Simplify Deployment**: Easily deploy applications to any system that supports Docker.

## Step-by-Step Guide to Install Docker on Linux

### Prerequisites

Before we begin, ensure you have:

- A Linux machine (Ubuntu, Debian, CentOS, etc.)
- Sudo privileges
- An internet connection

### Step 1: Update Your Package Index

Open your terminal and update your package index:

```bash
sudo apt-get update
```

### Step 2: Install Required Packages

Next, install the necessary packages that allow `apt` to use packages over HTTPS:

```bash
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
```

### Step 3: Add Docker’s Official GPG Key

Add Docker’s official GPG key to your system:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

### Step 4: Add the Docker Repository

Add the Docker repository to your package sources:

```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

### Step 5: Update the Package Index Again

Update the package index once more to include the Docker repository:

```bash
sudo apt-get update
```

### Step 6: Install Docker CE

Install the Docker Community Edition:

```bash
sudo apt-get install docker-ce
```

### Step 7: Start and Enable Docker

After installation, start the Docker service and enable it to run at boot:

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

### Step 8: Verify Docker Installation

Check if Docker is installed correctly by running:

```bash
sudo docker --version
```

You should see the installed Docker version.

### Step 9: Run Your First Docker Container

To verify that Docker is functioning correctly, run a simple container using the `hello-world` image:

```bash
sudo docker run hello-world
```

If everything is set up correctly, you’ll see a message that says "Hello from Docker!" indicating that your Docker installation is working.

### Step 10: Manage Docker as a Non-Root User (Optional)

If you prefer to run Docker commands without using `sudo`, you can add your user to the `docker` group:

```bash
sudo usermod -aG docker $USER
```

Log out and log back in for the changes to take effect.

## Conclusion

Congratulations! You’ve successfully installed Docker on your Linux system and run your first container. Docker's ability to streamline application deployment and enhance scalability makes it a vital tool in modern software development. With this foundation, you're now ready to explore Docker's more advanced features, such as building your own images, managing multi-container applications, and utilizing Docker Compose. Embrace the power of containers and revolutionize the way you develop and deploy applications!

This version includes everything in one Markdown file. Let me know if you need anything else!