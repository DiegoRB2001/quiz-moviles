import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: QuizPage(),
      backgroundColor: Color.fromARGB(255, 233, 196, 106),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> puntuacion = [];
  List<String> preguntas = [
    '¿Los glóbulos rojos viven 4 meses?',
    '¿El cuerpo humano adulto tiene 306 huesos?',
    '¿La cobalamina es una vitamina?',
    '¿El cereal es un carbohidrato?',
    '¿Hacer esta app fue facil?'
  ];
  List<bool> respuestas = [true, false, true, true, false];
  int numeroPregunta = 0;
  int aciertos = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  preguntas[numeroPregunta],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 231, 111, 81),
              ),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      resultado(true);
                    });
                  },
                  child: const Text(
                    'Verdadero',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 231, 111, 81),
              ),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      resultado(false);
                    });
                  },
                  child: const Text('Falso',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20))),
            ),
          ),
          Row(
            children: puntuacion,
          )
        ],
      ),
    );
  }

  resultado(respuesta) {
    bool resultado = respuesta == respuestas[numeroPregunta];
    if (resultado) {
      aciertos++;
      puntuacion.add(const Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      puntuacion.add(const Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
    if (numeroPregunta != preguntas.length - 1) {
      numeroPregunta++;
    } else {
      numeroPregunta = 0;
      alertaFinal(context);
    }
  }

  alertaFinal(BuildContext context) {
    AlertDialog alertaFinal = AlertDialog(
      title: const Text("Juego terminado"),
      content: Text("Puntuación: $aciertos"),
      actions: [
        TextButton(
          child: const Text("Volver a jugar"),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              aciertos = 0;
              puntuacion.clear();
            });
          },
        ),
        WillPopScope(onWillPop: () async => false, child: const Text(''))
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertaFinal;
      },
    );
  }
}
