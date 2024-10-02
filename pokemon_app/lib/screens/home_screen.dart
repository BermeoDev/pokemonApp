import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_app/providers/auth_provider.dart';
import 'package:pokemon_app/screens/pokemon/pokemon_list_screen.dart';
import 'package:pokemon_app/screens/pokemon/favorite_pokemon_screen.dart';
import 'package:pokemon_app/screens/auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (!authProvider.isAuthenticated) {
          return LoginScreen();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Pokémon App'),
            actions: [
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () => authProvider.logout(),
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                child: Text('Lista de Pokémon'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PokemonListScreen()),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Pokémon Favorito'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritePokemonScreen()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}