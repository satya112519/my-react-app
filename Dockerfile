# Step 1: Build the React app using Node.js
FROM node:16 AS build

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy all source files and build the app
COPY . .
RUN npm run build

# Step 2: Use nginx to serve the React app
FROM nginx:alpine

# Copy the build files into the nginx directory
COPY --from=build /app/build /usr/share/nginx/html

# Copy the custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 8080 for Cloud Run
EXPOSE 8080

# Run nginx
CMD ["nginx", "-g", "daemon off;"]
