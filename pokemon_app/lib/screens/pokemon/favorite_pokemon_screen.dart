import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_app/providers/auth_provider.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/widgets/pokemon_card.dart';
import 'package:pokemon_app/screens/pokemon/pokemon_details_screen.dart';

class FavoritePokemonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Favorite Pokémon')),
      body: FutureBuilder(
        future: Future.wait(authProvider.user!.favoritePokemon.map((pokemonId) => 
          pokemonProvider.fetchPokemonDetails(int.parse(pokemonId))
        )),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Center(child: Text('Aun no hay pokemones favoritos'));
          }
          
          return ListView.builder(
            itemCount: (snapshot.data as List).length,
            itemBuilder: (context, index) {
              final pokemon = pokemonProvider.pokemonList.firstWhere(
                (p) => p.id.toString() == authProvider.user!.favoritePokemon[index]
              );
              return PokemonCard(
                pokemon: pokemon,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PokemonDetailScreen(pokemonId: pokemon.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}