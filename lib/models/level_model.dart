// lib/models/level_model.dart

class Question {
  final String pregunta;
  final num respuesta;
  final List<num> opciones;
  Question({
    required this.pregunta,
    required this.respuesta,
    required this.opciones,
  });
  factory Question.fromJson(Map<String, dynamic> j) => Question(
    pregunta: j['pregunta'],
    respuesta: j['respuesta'],
    opciones: List<num>.from(j['opciones']),
  );
}

class Etapa {
  final int etapa;
  final List<Question> preguntas;
  Etapa({required this.etapa, required this.preguntas});
  factory Etapa.fromJson(Map<String, dynamic> j) => Etapa(
    etapa: j['etapa'],
    preguntas:
        (j['preguntas'] as List).map((e) => Question.fromJson(e)).toList(),
  );
}

class Seccion {
  final String seccion;
  final List<Etapa> etapas;
  Seccion({required this.seccion, required this.etapas});
  factory Seccion.fromJson(Map<String, dynamic> j) => Seccion(
    seccion: j['seccion'],
    etapas: (j['etapas'] as List).map((e) => Etapa.fromJson(e)).toList(),
  );
}

class Nivel {
  final String nivel;
  final List<Seccion> secciones;
  Nivel({required this.nivel, required this.secciones});
  factory Nivel.fromJson(Map<String, dynamic> j) => Nivel(
    nivel: j['nivel'],
    secciones:
        (j['secciones'] as List).map((e) => Seccion.fromJson(e)).toList(),
  );
}
