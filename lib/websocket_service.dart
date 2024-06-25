import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketService with ChangeNotifier {
  late WebSocketChannel channel;
  List<CandidateVotes> _candidatesVotes = [];
  int _totalVotes = 0;

  List<CandidateVotes> get candidatesVotes => _candidatesVotes;
  int get totalVotes => _totalVotes;

  WebSocketService() {
    _initializeCandidates();
    _connect();
  }

  void _connect() {
    channel = WebSocketChannel.connect(
      Uri.parse('https://qrwebresults.onrender.com'), // Actualiza esta URL con la de tu backend en Render
    );

    channel.stream.listen(
      (data) {
        final decodedData = json.decode(data);
        _totalVotes = decodedData['total_votes'];
        _updateVotes((decodedData['candidates'] as List)
            .map((candidate) => CandidateVotes.fromJson(candidate))
            .toList());
        notifyListeners();
      },
      onError: (error) {
        print('WebSocket Error: $error');
        _reconnect();
      },
      onDone: () {
        print('WebSocket Disconnected');
        _reconnect();
      },
    );
  }

  void _reconnect() {
    Future.delayed(const Duration(seconds: 5), () {
      if (channel.closeCode != null) {
        _connect();
      }
    });
  }

  void _updateVotes(List<CandidateVotes> newVotes) {
    for (var newVote in newVotes) {
      var candidate = _candidatesVotes.firstWhere((c) => c.name == newVote.name, orElse: () => CandidateVotes(name: newVote.name, votes: 0));
      candidate.votes += newVote.votes;
    }
    _candidatesVotes.sort((a, b) => a.name.compareTo(b.name)); // Orden alfabético
    notifyListeners();
  }

  void _initializeCandidates() {
    _candidatesVotes = [
      CandidateVotes(name: "Antonio Ecarri", votes: 0),
      CandidateVotes(name: "Benjamín Rausseo", votes: 0),
      CandidateVotes(name: "Claudio Fermín", votes: 0),
      CandidateVotes(name: "Daniel Ceballos", votes: 0),
      CandidateVotes(name: "Edmundo González", votes: 0),
      CandidateVotes(name: "Enrique Marquez", votes: 0),
      CandidateVotes(name: "Javier Bertucci", votes: 0),
      CandidateVotes(name: "José Brito", votes: 0),
      CandidateVotes(name: "Luis Martínez", votes: 0),
      CandidateVotes(name: "Nicolás Maduro", votes: 0),
    ];
    _candidatesVotes.sort((a, b) => a.name.compareTo(b.name)); // Orden alfabético
    notifyListeners();
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }
}

class CandidateVotes {
  final String name;
  int votes;

  CandidateVotes({required this.name, required this.votes});

  factory CandidateVotes.fromJson(Map<String, dynamic> json) {
    return CandidateVotes(
      name: json['name'],
      votes: json['votes'],
    );
  }
}
