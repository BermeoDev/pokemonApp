import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/widgets/pokemon_card.dart';
import 'package:pokemon_app/screens/pokemon/pokemon_details_screen.dart';

class PokemonListScreen extends StatefulWidget {
  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  static const int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _loadMorePokemon();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMorePokemon();
    }
  }

  Future<void> _loadMorePokemon() async {
    await Provider.of<PokemonProvider>(context, listen: false)
        .fetchPokemonList(limit: _pageSize, offset: _currentPage * _pageSize);
    _currentPage++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokémon List')),
      body: Consumer<PokemonProvider>(
        builder: (context, pokemonProvider, child) {
          if (pokemonProvider.pokemonList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: pokemonProvider.pokemonList.length + 1,
            itemBuilder: (context, index) {
              if (index < pokemonProvider.pokemonList.length) {
                final pokemon = pokemonProvider.pokemonList[index];
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
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        },
      ),
    );
  }
}