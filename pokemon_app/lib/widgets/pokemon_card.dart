import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokemonCard({Key? key, required this.pokemon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.network(pokemon.imageUrl, width: 80, height: 80),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pokemon.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text('Types: ${pokemon.types.join(", ")}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}