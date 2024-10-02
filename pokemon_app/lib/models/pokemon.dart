class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final Map<String, int> stats;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.stats,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      types: (json['types'] as List).map((type) => type['type']['name'] as String).toList(),
      abilities: (json['abilities'] as List).map((ability) => ability['ability']['name'] as String).toList(),
      stats: Map.fromIterable(
        json['stats'],
        key: (item) => item['stat']['name'],
        value: (item) => item['base_stat'],
      ),
    );
  }
}