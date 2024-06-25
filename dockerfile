# Usar una imagen de Docker oficial de Dart
FROM dart:stable AS build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el archivo pubspec y descargar las dependencias
COPY pubspec.* ./
RUN dart pub get

# Copiar todo el código fuente
COPY . .

# Construir la aplicación Flutter Web
RUN dart pub global activate webdev
RUN webdev build

# Servir la aplicación construida
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
