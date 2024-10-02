import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/widgets/stats_display.dart';
import 'package:pokemon_app/widgets/evolution_chain.dart';

class PokemonDetailScreen extends StatefulWidget {
  final int pokemonId;

  PokemonDetailScreen({required this.pokemonId});

  @override
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PokemonProvider>(context, listen: false).fetchPokemonDetails(widget.pokemonId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles del Pokémon')),
      body: Consumer<PokemonProvider>(
        builder: (context, pokemonProvider, child) {
          final pokemon = pokemonProvider.selectedPokemon;
          if (pokemon == null) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(pokemon.imageUrl, height: 200),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pokemon.name, style: Theme.of(context).textTheme.headlineSmall),
                      SizedBox(height: 8),
                      Text('Types: ${pokemon.types.join(", ")}'),
                      SizedBox(height: 8),
                      Text('Abilities: ${pokemon.abilities.join(", ")}'),
                      SizedBox(height: 16),
                      StatsDisplay(stats: pokemon.stats),
                      SizedBox(height: 16),
                      EvolutionChain(evolutionChain: pokemonProvider.evolutionChain),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}