import 'package:flutter/material.dart';
import 'websocket_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String selectedState = '';
  String selectedCenter = '';
  String selectedTable = '';
  
  // Lista de estados de Venezuela
  List<String> states = [
    'Amazonas', 'Anzoátegui', 'Apure', 'Aragua', 'Barinas', 'Bolívar',
    'Carabobo', 'Cojedes', 'Delta Amacuro', 'Distrito Capital', 'Falcón', 
    'Guárico', 'La Guaira', 'Lara', 'Mérida', 'Miranda', 'Monagas', 
    'Nueva Esparta', 'Portuguesa', 'Sucre', 'Táchira', 'Trujillo', 
    'Yaracuy', 'Zulia'
  ]..sort(); // Ordenar alfabéticamente
  
  List<String> centers = [];
  List<String> tables = [];
  List<CandidateVotes> filteredCandidates = [];
  int totalVotes = 0;

  void fetchFilteredResults() async {
    final response = await http.get(Uri.parse('http://your-backend-url.com/search?state=$selectedState&center=$selectedCenter&table=$selectedTable'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        filteredCandidates = (data['candidates'] as List)
            .map((candidate) => CandidateVotes.fromJson(candidate))
            .toList();
        totalVotes = data['total_votes'];
      });
    } else {
      // Manejar error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Actas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedState.isEmpty ? null : selectedState,
              hint: const Text('Seleccionar Estado'),
              items: states.map((String state) {
                return DropdownMenuItem<String>(
                  value: state,
                  child: Text(state),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedState = value!;
                  // Aquí deberíamos actualizar los centros y mesas según el estado seleccionado
                  // Como no tenemos datos para los centros y mesas, se dejarán vacíos
                  centers = []; // Actualizar centros según el estado seleccionado
                  tables = []; // Actualizar mesas según el centro seleccionado
                  selectedCenter = ''; // Limpiar selección de centro
                  selectedTable = ''; // Limpiar selección de mesa
                });
              },
            ),
            DropdownButton<String>(
              value: selectedCenter.isEmpty ? null : selectedCenter,
              hint: const Text('Seleccionar Centro de Votación'),
              items: centers.map((String center) {
                return DropdownMenuItem<String>(
                  value: center,
                  child: Text(center),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCenter = value!;
                  // Actualizar mesas según el centro seleccionado
                });
              },
            ),
            DropdownButton<String>(
              value: selectedTable.isEmpty ? null : selectedTable,
              hint: const Text('Seleccionar Mesa'),
              items: tables.map((String table) {
                return DropdownMenuItem<String>(
                  value: table,
                  child: Text(table),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTable = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: fetchFilteredResults,
              child: const Text('Buscar'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCandidates.length,
                itemBuilder: (context, index) {
                  final candidate = filteredCandidates[index];
                  final percentage = (candidate.votes / totalVotes) * 100;

                  return ListTile(
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
              'Total de votos: $totalVotes',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
