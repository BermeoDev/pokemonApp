import 'package:pokemon_app/api/api_service.dart';
import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/utils/constans.dart';

class PokemonApi {
  final ApiService _apiService = ApiService(baseUrl: Constants.pokeApiBaseUrl);

  Future<List<Pokemon>> getPokemonList({int limit = 20, int offset = 0}) async {
    final response = await _apiService.get('pokemon?limit=$limit&offset=$offset');
    final results = response['results'] as List;
    return Future.wait(results.map((pokemon) => getPokemonDetails(pokemon['url'])));
  }

  Future<Pokemon> getPokemonDetails(String url) async {
    final response = await _apiService.get(url.replaceAll(Constants.pokeApiBaseUrl, ''));
    return Pokemon.fromJson(response);
  }

  Future<List<String>> getPokemonEvolutionChain(int pokemonId) async {
    final speciesResponse = await _apiService.get('pokemon-species/$pokemonId');
    final evolutionChainUrl = speciesResponse['evolution_chain']['url'];
    final evolutionResponse = await _apiService.get(evolutionChainUrl.replaceAll(Constants.pokeApiBaseUrl, ''));
    
    List<String> evolutionChain = [];
    var evoData = evolutionResponse['chain'];
    
    do {
      evolutionChain.add(evoData['species']['name']);
      evoData = evoData['evolves_to'].isNotEmpty ? evoData['evolves_to'][0] : null;
    } while (evoData != null);
    
    return evolutionChain;
  }
}