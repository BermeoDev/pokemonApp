import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/pokemon_provider.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
      ],
      child: MaterialApp(
        title: 'Pokémon App',
        theme: AppTheme.lightTheme,
        home: HomeScreen(),
      ),
    );
  }
}