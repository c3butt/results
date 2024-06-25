# Etapa de construcción
FROM cirrusci/flutter:2.10.5 AS build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el archivo pubspec y descargar las dependencias
COPY pubspec.* ./
RUN flutter pub get

# Copiar todo el código fuente
COPY . .

# Construir la aplicación Flutter Web
RUN flutter build web

# Etapa de producción
FROM nginx:alpine

# Copiar archivos generados al servidor nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Exponer el puerto
EXPOSE 80

# Comando por defecto para ejecutar nginx
CMD ["nginx", "-g", "daemon off;"]
