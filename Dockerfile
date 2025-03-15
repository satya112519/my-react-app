# Step 1: Use the official Node.js image to build the app
FROM node:16 AS build

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the app files and build the app
COPY . .
RUN npm run build

# Step 2: Use nginx to serve the React build files
FROM nginx:alpine

# Copy the built files to nginx directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 8080
EXPOSE 8080

# Run nginx
CMD ["nginx", "-g", "daemon off;"]
