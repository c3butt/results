import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'websocket_service.dart';
import 'totalizer_page.dart';
import 'search_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WebSocketService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resultados en Tiempo Real',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados en Tiempo Real'),
      ),
      body: Center(
        child: Container(
          color: Colors.grey[200], // Fondo gris claro
          child: Padding(
            padding: const EdgeInsets.all(24.0), // Ajustar el padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TotalizerPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 72.0, vertical: 58.0), // Triplicar padding
                        textStyle: const TextStyle(fontSize: 36.0), // Triplicar tamaño de fuente
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0), // Borde redondeado
                        ),
                        backgroundColor: Colors.blue.withOpacity(0.5), // Fondo de agua
                      ),
                      child: const Text('Totalización General'),
                    ),
                    const SizedBox(width: 24.0), // Espaciado entre botones
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SearchPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 72.0, vertical: 58.0), // Triplicar padding
                        textStyle: const TextStyle(fontSize: 36.0), // Triplicar tamaño de fuente
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0), // Borde redondeado
                        ),
                        backgroundColor: Colors.green.withOpacity(0.5), // Fondo de agua
                      ),
                      child: const Text('Buscar Actas'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
