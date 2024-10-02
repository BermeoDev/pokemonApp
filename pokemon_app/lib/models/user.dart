class User {
  final String id;
  final String username;
  final String email;
  final List<String> favoritePokemon;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.favoritePokemon,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      favoritePokemon: List<String>.from(json['favoritePokemon']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'favoritePokemon': favoritePokemon,
    };
  }
}