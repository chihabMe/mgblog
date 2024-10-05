# Use the official Node.js image as a base
FROM node:18 AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Astro project
RUN npm run build

# Use a lightweight web server for production
FROM node:18 AS production

# Set the working directory
WORKDIR /app

# Copy the build output from the builder stage
COPY --from=builder /app/dist ./dist

# Install only production dependencies
COPY package*.json ./
RUN npm install --production

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["node", "dist/index.mjs"]
