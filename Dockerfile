# Use Node.js LTS version as the base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the entire application
COPY . .

# Build the React app
RUN npm run build

# Install serve for static hosting
RUN npm install -g serve

# Start the application
CMD ["serve", "-s", "build", "-l", "8080"]

# Expose the required port
EXPOSE 8080
