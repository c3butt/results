import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'websocket_service.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final webSocketService = Provider.of<WebSocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados en Tiempo Real'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: webSocketService.candidatesVotes.length,
                itemBuilder: (context, index) {
                  final candidate = webSocketService.candidatesVotes[index];
                  final percentage = (candidate.votes / webSocketService.totalVotes) * 100;

                  return ListTile(
                    leading: Text('${index + 1}'),
                    title: Text(candidate.name),
                    subtitle: Text(
                      '${candidate.votes} votos (${percentage.toStringAsFixed(2)}%)',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Total de votos: ${webSocketService.totalVotes}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
