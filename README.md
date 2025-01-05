# Pokémon Comparador

Este proyecto es una aplicación móvil desarrollada con Flutter que permite comparar dos Pokémon basándose en sus estadísticas. Los usuarios pueden buscar y comparar dos Pokémon de su elección, ver sus estadísticas y descubrir cuál es el "más fuerte".

## Funcionalidades

- Búsqueda de Pokémon por nombre.
- Comparación de las estadísticas de dos Pokémon (HP, Ataque, Defensa, etc.).
- Visualización de las imágenes de los Pokémon.
- Muestra de tipos de Pokémon (fuego, agua, planta, etc.).
- Comparación del total de estadísticas entre dos Pokémon.

## Tecnologías

- **Flutter**: Framework de desarrollo de aplicaciones móviles.
- **Dart**: Lenguaje de programación utilizado en Flutter.
- **PokeAPI**: API utilizada para obtener los datos de los Pokémon.

## Instalación

### Prerrequisitos

- [Flutter](https://flutter.dev/docs/get-started/install) instalado en tu máquina.
- [Android Studio](https://developer.android.com/studio) o [Visual Studio Code](https://code.visualstudio.com/) como editor.
- Un emulador de Android o dispositivo físico para ejecutar la aplicación.

### Pasos de instalación

1. Clona este repositorio en tu máquina:

    ```bash
    git clone https://github.com/tu-usuario/pokemon-comparador.git
    ```

2. Navega al directorio del proyecto:

    ```bash
    cd pokemon-comparador
    ```

3. Instala las dependencias del proyecto con el siguiente comando:

    ```bash
    flutter pub get
    ```

4. Conecta un dispositivo o inicia un emulador de Android.

5. Ejecuta la aplicación:

    ```bash
    flutter run
    ```

## Uso

1. Abre la aplicación en tu dispositivo o emulador.
2. Escribe el nombre del primer Pokémon en el campo correspondiente.
3. Escribe el nombre del segundo Pokémon en el campo correspondiente.
4. Presiona "Enter" o el botón de búsqueda para cargar los datos y compararlos.
5. Visualiza las estadísticas y la comparación entre ambos Pokémon.

## Subir la aplicación a Aptoide

Aptoide es una plataforma alternativa a Google Play Store para distribuir aplicaciones Android. Para subir tu aplicación a Aptoide, sigue estos pasos:

### 1. Crear una cuenta en Aptoide

- Visita [Aptoide Developer](https://dev.aptoide.com/) y crea una cuenta de desarrollador si aún no tienes una.

### 2. Preparar el APK

Primero, necesitas generar un archivo APK de tu aplicación. Si no lo has hecho ya, sigue estos pasos:

1. Abre tu terminal y navega al directorio del proyecto Flutter.
2. Ejecuta el siguiente comando para generar un APK de lanzamiento:

    ```bash
    flutter build apk --release
    ```

   Esto generará un archivo `.apk` optimizado en el directorio `build/app/outputs/flutter-apk/` de tu proyecto.

### 3. Subir el APK a Aptoide

1. Inicia sesión en tu cuenta de desarrollador en [Aptoide Developer](https://dev.aptoide.com/).
2. En el panel de control, haz clic en el botón **"Upload your app"** o **"Sube tu aplicación"**.
3. Completa los detalles de la aplicación, como el nombre, la descripción, la categoría, las capturas de pantalla, etc.
4. Haz clic en **"Upload APK"** y selecciona el archivo `.apk` generado anteriormente.
5. Sigue los pasos de la plataforma para completar el proceso y enviar la aplicación para su revisión.

### 4. Publicar la aplicación

Una vez que tu aplicación haya sido revisada y aprobada, aparecerá en la tienda de Aptoide, y podrás compartir el enlace con otros usuarios para que la descarguen.

## Contribuciones

Las contribuciones son bienvenidas. Si deseas colaborar con el proyecto, sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una nueva rama para tu característica o corrección de errores (`git checkout -b feature/nueva-caracteristica`).
3. Haz tus cambios y confirma tus cambios (`git commit -am 'Agregada nueva característica'`).
4. Envía tu rama al repositorio remoto (`git push origin feature/nueva-caracteristica`).
5. Crea un pull request.

## Licencia

Este proyecto está bajo la licencia MIT. Para más detalles, consulta el archivo [LICENSE](LICENSE).

---

**¡Gracias por usar Pokémon Comparador!** 🚀
