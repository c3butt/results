# Usar una imagen de Docker oficial de Flutter
FROM cirrusci/flutter:stable AS build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el archivo pubspec y descargar las dependencias
COPY pubspec.* ./
RUN flutter pub get

# Copiar todo el código fuente
COPY . .

# Construir la aplicación Flutter Web
RUN flutter build web

# Usar Nginx para servir la aplicación
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
