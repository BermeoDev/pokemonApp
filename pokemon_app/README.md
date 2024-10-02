# pokemon_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


---

# Pokémon Flutter App

## Descripción

Esta es una aplicación móvil desarrollada en Flutter que consume la API pública de Pokémon (https://pokeapi.co/) y se conecta a un backend personalizado en Node.js para manejar la autenticación de usuarios, el registro y la gestión de Pokémon favoritos. La aplicación permite a los usuarios explorar una lista de Pokémon, ver sus detalles, ver la cadena evolutiva y registrar/guardar sus Pokémon favoritos en su cuenta.

## Características

- **Lista de Pokémon**: Los usuarios pueden ver una lista scrollable con los nombres e imágenes de los Pokémon.
- **Detalles del Pokémon**: Al tocar un Pokémon en la lista, se puede acceder a una pantalla con los detalles completos del Pokémon, incluyendo sus tipos, habilidades, estadísticas y cadena evolutiva.
- **Evolución del Pokémon**: Permite al usuario evolucionar un Pokémon si es posible. Si no hay más etapas evolutivas, muestra un mensaje adecuado.
- **Autenticación**: Registro e inicio de sesión con autenticación JWT para asegurar que solo usuarios autenticados puedan guardar Pokémon favoritos.
- **Favoritos**: Los usuarios pueden guardar sus Pokémon favoritos y acceder a ellos posteriormente.
- **Diseño**: La interfaz está diseñada para ser intuitiva y amigable, con una apariencia responsiva para adaptarse a diferentes tamaños de pantalla.

## Requisitos

### Flutter

Asegúrate de tener Flutter instalado en tu entorno de desarrollo. Puedes seguir la [guía oficial de instalación](https://flutter.dev/docs/get-started/install) de Flutter.

### Node.js Backend

El backend en Node.js debe estar corriendo para gestionar la autenticación y el almacenamiento de los Pokémon favoritos. Asegúrate de configurar correctamente la URL del backend en el código Flutter.

### Dependencias

Instala las dependencias necesarias ejecutando el siguiente comando en el directorio raíz de la aplicación:

```bash
flutter pub get
```

Las principales dependencias utilizadas son:

- `provider`: Para la gestión del estado.
- `shared_preferences`: Para almacenar el token de autenticación localmente.
- `http`: Para realizar peticiones HTTP a la API y al backend.
- `flutter_dotenv`: Para manejar las variables de entorno (como la URL de la API o el backend).

## Estructura del Proyecto

```plaintext
pokemon_app/
├── lib/
│   ├── api/
│   │   ├── api_service.dart        # Clase para realizar peticiones HTTP.
│   │   └── pokemon_api.dart        # Lógica para consumir la API de Pokémon.
│   ├── models/
│   │   ├── pokemon.dart            # Modelo de datos del Pokémon.
│   │   └── user.dart               # Modelo de datos del Usuario.
│   ├── providers/
│   │   ├── auth_provider.dart      # Gestión de autenticación y usuarios.
│   │   └── pokemon_provider.dart   # Gestión del estado de los Pokémon.
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── login_screen.dart   # Pantalla de inicio de sesión.
│   │   │   └── register_screen.dart# Pantalla de registro.
│   │   ├── pokemon/
│   │   │   ├── pokemon_list_screen.dart  # Pantalla con la lista de Pokémon.
│   │   │   ├── pokemon_detail_screen.dart# Pantalla con los detalles del Pokémon.
│   │   │   └── favorite_pokemon_screen.dart # Pantalla con los Pokémon favoritos.
│   │   └── home_screen.dart        # Pantalla principal que agrupa las demás.
│   ├── widgets/
│   │   ├── pokemon_card.dart       # Tarjeta visual para cada Pokémon en la lista.
│   │   ├── evolution_chain.dart    # Muestra la cadena evolutiva del Pokémon.
│   │   └── stats_display.dart      # Muestra las estadísticas del Pokémon.
│   ├── utils/
│   │   ├── constants.dart          # Constantes como URLs y otros valores importantes.
│   │   └── theme.dart              # Tema visual de la aplicación.
│   └── main.dart                   # Punto de entrada de la aplicación.
├── pubspec.yaml                     # Archivo de configuración de las dependencias.
└── README.md                        # Este archivo.
```

## Configuración

### Backend

1. Asegúrate de que el backend de Node.js esté configurado y corriendo. Puedes verificarlo utilizando herramientas como Postman o Reqbin.
2. En el archivo `lib/utils/constants.dart`, configura la URL del backend para que apunte a tu servidor:

```dart
class Constants {
  static const String pokeApiBaseUrl = 'https://pokeapi.co/api/v2/';
  static const String backendBaseUrl = 'http://TU_IP_O_DOMINIO:5000/';  // Reemplaza con la URL de tu backend.
}
```

### Variables de Entorno

Si estás utilizando el paquete `flutter_dotenv`, crea un archivo `.env` en la raíz del proyecto y define tus variables de entorno (por ejemplo, URLs, claves secretas, etc.):

```plaintext
API_URL=https://pokeapi.co/api/v2/
BACKEND_URL=http://TU_IP_O_DOMINIO:5000/
```

### Autenticación

Esta aplicación usa autenticación basada en tokens JWT. Asegúrate de que tu backend Node.js esté correctamente configurado para generar y verificar tokens JWT.

## Ejecución

Para correr la aplicación en tu dispositivo o emulador, utiliza el siguiente comando:

```bash
flutter run
```

Asegúrate de que el emulador o dispositivo móvil esté conectado a la misma red que el servidor backend.

## Pruebas

Puedes verificar que la aplicación está conectada correctamente al backend probando las siguientes características:

- **Registro e inicio de sesión**: Crea un nuevo usuario y luego inicia sesión con las credenciales recién creadas.
- **Guardado de Pokémon favoritos**: Una vez registrado, selecciona un Pokémon y guárdalo como favorito. Luego accede a la pantalla de favoritos para ver el Pokémon guardado.

## Problemas comunes

- **Error de conexión con el backend**: Asegúrate de que el dispositivo móvil o emulador esté en la misma red que el servidor backend y que la URL esté correctamente configurada.
- **Error de autenticación**: Verifica que el token JWT esté siendo generado y guardado correctamente en el almacenamiento local (`shared_preferences`).

## Contribuciones

Si deseas contribuir a este proyecto, por favor abre un issue o pull request en GitHub. Agradecemos cualquier sugerencia o mejora.

---

Este `README.md` proporciona una descripción detallada del proyecto, su estructura, cómo configurarlo y ejecutarlo, así como algunos pasos para la resolución de problemas.