# Use official Nginx image
FROM nginx:alpine

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy your static site to nginx public folder
COPY . /usr/share/nginx/html

# Nginx listens on port 80 by default
EXPOSE 80
