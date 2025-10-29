# Step 1: Build Nuxt app
FROM node:alpine3.18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: Serve with Nginx
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html

# Remove default files
RUN rm -rf ./*

# CORRECT PATH: .output/public (not publics)
COPY --from=build /app/.output/public .

# Custom Nginx config for SPA routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]