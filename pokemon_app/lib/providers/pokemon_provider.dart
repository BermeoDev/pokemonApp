import 'package:flutter/foundation.dart';
import 'package:pokemon_app/api/pokemon_api.dart';
import 'package:pokemon_app/models/pokemon.dart';

class PokemonProvider with ChangeNotifier {
  final PokemonApi _pokemonApi = PokemonApi();
  List<Pokemon> _pokemonList = [];
  Pokemon? _selectedPokemon;
  List<String> _evolutionChain = [];

  List<Pokemon> get pokemonList => _pokemonList;
  Pokemon? get selectedPokemon => _selectedPokemon;
  List<String> get evolutionChain => _evolutionChain;

  Future<void> fetchPokemonList({int limit = 20, int offset = 0}) async {
    try {
      _pokemonList = await _pokemonApi.getPokemonList(limit: limit, offset: offset);
      notifyListeners();
    } catch (e) {
      print('Error fetching Pokemon list: $e');
    }
  }

  Future<void> fetchPokemonDetails(int pokemonId) async {
    try {
      _selectedPokemon = await _pokemonApi.getPokemonDetails('pokemon/$pokemonId');
      _evolutionChain = await _pokemonApi.getPokemonEvolutionChain(pokemonId);
      notifyListeners();
    } catch (e) {
      print('Error fetching Pokemon details: $e');
    }
  }

  void clearSelectedPokemon() {
    _selectedPokemon = null;
    _evolutionChain = [];
    notifyListeners();
  }
}