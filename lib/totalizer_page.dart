import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'websocket_service.dart';

class TotalizerPage extends StatelessWidget {
  const TotalizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final webSocketService = Provider.of<WebSocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Totalización General'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Dos columnas
                    childAspectRatio: 8, // Ajustar el aspecto de las tarjetas
                    mainAxisSpacing: 8, // Espaciado entre las filas
                    crossAxisSpacing: 8, // Espaciado entre las columnas
                  ),
                  itemCount: webSocketService.candidatesVotes.length,
                  itemBuilder: (context, index) {
                    final candidate = webSocketService.candidatesVotes[index];
                    final percentage = webSocketService.totalVotes > 0
                        ? (candidate.votes / webSocketService.totalVotes) * 100
                        : 0.0;

                    return Card(
                      margin: const EdgeInsets.all(5.0),
                      child: ListTile(
                        leading: Text('${index + 1}'),
                        title: Text(candidate.name),
                        subtitle: Text(
                          '${candidate.votes} votos (${percentage.toStringAsFixed(2)}%)',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total de votos: ${webSocketService.totalVotes}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
