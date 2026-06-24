# --- Etapa 1: Instalación de Dependencias ---
FROM node:18-alpine AS dependencies
WORKDIR /usr/src/app

COPY package*.json ./
# npm ci asegura una instalación limpia y exacta basada en el package-lock.json
RUN npm ci --only=production

# --- Etapa 2: Entorno de Ejecución ---
FROM node:18-alpine
WORKDIR /usr/src/app

# Copiar dependencias y código fuente de manera selectiva
COPY --from=dependencies /usr/src/app/node_modules ./node_modules
COPY . .

# Exponer el puerto definido por la aplicación
EXPOSE 8081

# Principio de menor privilegio: Correr la aplicación como un usuario sin privilegios de root
USER node

CMD ["npm", "start"]