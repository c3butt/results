class Candidate {
  final String name;
  final String party;
  int votes;

  Candidate(this.name, this.party, {this.votes = 0});

  // Candidato vacío para representar espacios vacíos
  static final Candidate empty = Candidate('Vacio', 'Vacio');
}

// Lista de candidatos organizados por su posición en el tarjetón
List<Candidate> initialCandidates = [
  Candidate("Nicolás Maduro", "PSUV"),
  Candidate("Nicolás Maduro", "TUPAMARO"),
  Candidate("Nicolás Maduro", "PPT"),
  Candidate("Nicolás Maduro", "Somos Vzla"),
  Candidate("Nicolás Maduro", "ORA"),
  Candidate("Nicolás Maduro", "PODEMOS"),
  Candidate("Nicolás Maduro", "Partido Verde"),
  Candidate("Nicolás Maduro", "ENAMÓRATE"),
  Candidate("Nicolás Maduro", "MEP"),
  Candidate("Nicolás Maduro", "Futuro"),
  Candidate("Nicolás Maduro", "PCV"),
  Candidate("Nicolás Maduro", "UPV"),
  Candidate.empty, // Vacío
  Candidate("Luis Martínez", "DDP"),
  Candidate("Edmundo González", "MUD"),
  Candidate("Daniel Ceballos", "VP"),
  Candidate("Edmundo González", "MPV"),
  Candidate("Antonio Ecarri", "ECOLOGICO"),
  Candidate("Antonio Ecarri", "UNIDAD"),
  Candidate("Antonio Ecarri", "LAPIZ"),
  Candidate("Nicolás Maduro", "ALIANZA CAMBIO"),
  Candidate("Luis Martínez", "UNE"),
  Candidate.empty, // Vacío
  Candidate("Benjamín Rausseo", "CONDE"),
  Candidate("Enrique Marquez", "Centrados"),
  Candidate("Daniel Ceballos", "AREPA"),
  Candidate("Edmundo González", "UNT"),
  Candidate("José Brito", "PJ"),
  Candidate("Antonio Ecarri", "Cambiemos"),
  Candidate("Antonio Ecarri", "Avanzada Progresista"),
  Candidate("Luis Martínez", "AD"),
  Candidate("Luis Martínez", "MR"),
  Candidate("Luis Martínez", "Bandera Roja"),
  Candidate("Javier Bertucci", "El Cambio"),
  Candidate("José Brito", "Primero Vzla"),
  Candidate("José Brito", "Vzla Unidad"),
  Candidate("Antonio Ecarri", "Fuerza Vecinal"),
  Candidate("Claudio Fermín", "Soluciones"),
  Candidate("José Brito", "Unidad visión Vzla"),
  Candidate("Luis Martínez", "COPEI")
];
