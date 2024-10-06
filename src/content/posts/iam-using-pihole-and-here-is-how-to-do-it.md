---
title: I'am using pi-hole as my local dns server and here is how to do it!
description: how to install pi-hole locally using docker and use it as a local dns server to get fast dns resolve and block ads
date: 2019-04-01T14:26:00+08:00
tags:
  - docker
  - learning
  - linux
  - devops
  - self hosting

toc: false
---

# How to Self-Host Pi-hole as a Local DNS for Your Home Lab Using Docker

Pi-hole is a network-wide ad blocker that acts as a DNS sinkhole, blocking unwanted content before it can even reach your devices. In this article, we will set up Pi-hole in Docker and configure it as the DNS server for your home lab. Using Docker makes the installation process easier, portable, and allows you to isolate Pi-hole from the rest of your system.

## Prerequisites

Before we get started, make sure you have the following:

- A machine running Docker and Docker Compose.
- Access to your router settings to configure the DNS server.
- A local domain name (optional but useful for home lab setups).

## Step 1: Create a `docker-compose.yml` for Pi-hole

Create a directory for Pi-hole and navigate to it in your terminal:

```bash
mkdir ~/pihole-docker
cd ~/pihole-docker
```

Now, create a `docker-compose.yml` file:

```bash
vim docker-compose.yml
```

Add the following content to the file:

```yaml
version: '3'
services:
  pihole:
    image: pihole/pihole:latest
    container_name: pihole
    environment:
    #   TZ: "Africa/London" # Change this to your time zone
    #   WEBPASSWORD: "yourpassword" # Change this to a secure password
    volumes:
      - './etc-pihole:/etc/pihole'
      - './etc-dnsmasq.d:/etc/dnsmasq.d'
    dns:
      - 127.0.0.1
      - 1.1.1.1 # Cloudflare DNS for backup
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "80:80/tcp"
    restart: unless-stopped
```

### Explanation:
- **Image**: We’re using the official `pihole/pihole:latest` image.
- **Volumes**: We mount directories to persist Pi-hole data and DNS configurations.
- **DNS**: Pi-hole uses itself (`127.0.0.1`) as a DNS resolver and falls back to Cloudflare’s DNS (`1.1.1.1`).
- **Ports**: Pi-hole uses port 53 for DNS queries (TCP and UDP) and port 80 for its web interface.
- **Environment Variables**: Set your time zone and a secure password for the Pi-hole web interface.

## Step 2: Start Pi-hole

Once your `docker-compose.yml` file is ready, start Pi-hole by running the following command:

```bash
docker-compose up -d
```

This will pull the Pi-hole image from Docker Hub and start it in detached mode. You can check if the container is running with:

```bash
docker ps
```

The Pi-hole web interface should now be accessible at `http://<your-server-ip>/admin`. You can log in using the password you set in the `docker-compose.yml`.

## Step 3: Set Pi-hole as Your Local DNS

To use Pi-hole as your DNS server for your home lab, you need to configure your router or DHCP server to use Pi-hole’s IP address as the primary DNS resolver.

### Configuring Your Router

1. Log in to your router’s admin interface (usually found at `192.168.1.1` or `192.168.0.1`).
2. Navigate to the DNS settings. This is often located under "Network" or "Advanced Settings".
3. Set the DNS server to the IP address of your Pi-hole Docker container (for example, `192.168.1.100`).

This will route all DNS requests from devices on your network through Pi-hole.

### Configuring Individual Devices (Optional)

If you prefer not to configure the entire network, you can manually set Pi-hole as the DNS server on individual devices:

- On Linux: Edit the `/etc/resolv.conf` file and add the IP of your Pi-hole container.
- On Windows: Go to "Network & Internet Settings" > "Change adapter options" > Select your network > Properties > Set DNS server manually.
- On macOS: Go to "System Preferences" > "Network" > Select your active connection > "Advanced" > "DNS" > Add your Pi-hole’s IP.

here is how to do it on linux 

- Edit the `resolv.conf` config file:
   ```bash
   vim /etc/resolv.conf
   ```

- Add your local domain entries:
   ```bash
    nameserver 127.0.0.1
    nameserver 8.8.8.8
   ```
## Step 4: Configuring Pi-hole for Your Home Lab by going to the http:/localhost:81/admin
-  create an account (make sure to remember it the first account is the admin by default)
-  enjoy you can add local domain names or white or black  domains



Now, any device using Pi-hole as a DNS server will be able to resolve your home lab domain names.


## Step 5: Monitoring and Managing Pi-hole

You can monitor blocked queries, check DNS logs, and manage blacklists/whitelists via the Pi-hole web interface. The dashboard provides detailed stats on DNS queries, blocked requests, and top clients.

You can also add additional blocklists by going to **Group Management > Adlists** in the web interface.

## Conclusion

Self-hosting Pi-hole using Docker is a straightforward way to set up network-wide ad blocking and local DNS resolution for your home lab. Once configured, Pi-hole will filter ads and unwanted content while serving local domain names to make your home lab more efficient and organized.

Feel free to explore more Pi-hole features like custom blocklists, conditional forwarding, and more to tailor your setup to your specific needs.