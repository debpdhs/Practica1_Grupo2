# Dockerfile for basic web application
FROM nginx:alpine

# Copy custom nginx configuration if needed
# COPY nginx.conf /etc/nginx/nginx.conf

# Copy static content
COPY src/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]