import 'package:flutter/material.dart';

class StatsDisplay extends StatelessWidget {
  final Map<String, int> stats;

  const StatsDisplay({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Stats:', style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: 8),
        ...stats.entries.map((entry) => _buildStatBar(context, entry.key, entry.value)),
      ],
    );
  }

  Widget _buildStatBar(BuildContext context, String statName, int statValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(statName)),
          Expanded(
            child: LinearProgressIndicator(
              value: statValue / 255,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(width: 8),
          Text(statValue.toString()),
        ],
      ),
    );
  }
}