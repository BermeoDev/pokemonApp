import 'package:flutter/material.dart';

class EvolutionChain extends StatelessWidget {
  final List<String> evolutionChain;

  const EvolutionChain({Key? key, required this.evolutionChain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Evolution Chain:', style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: evolutionChain.map((pokemon) => Chip(label: Text(pokemon))).toList(),
        ),
      ],
    );
  }
}