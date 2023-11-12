import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/database/scheduler_database.dart';

class HorarioTable extends StatelessWidget {
  final List<String> diasSemana = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes'
  ];
  final List<String> bloquesHorarios = [
    "7:00 - 7:50",
    "7:50 - 8:40",
    "8:50 - 9:40",
    "9:40 - 10:30",
    "10:40 - 11:30",
    "11:30 - 12:20",
    "12:20  - 1:10",
    "1:10  - 2:00",
    "2:00  - 2:50",
    "2:50  - 3:40",
    "3:50  - 4:40",
    "4:40  - 5:30",
    "5:40  - 6:30",
    "6:30  - 7:20",
    "7:20  - 8:10",
    "8:10  - 9:00"
  ];
  int nro = -79;

  Map<int, String> horario = {};

  void agregarhora(int h, String c) {
    if (horario.containsKey(h)) {
      horario[h] = horario[h]! + c;
    } else {
      horario[h] = c;
    }
  }

  String getCurso(int h) {
    print('obteniendo ' + h.toString());
    if (!horario.containsKey(h)) {
      return h.toString();
    } else {
      return horario[h]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SchedulerDatabase.instance.getAllHors(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TurnoHorario>> snapshot) {
          if (snapshot.hasData) {
            List<TurnoHorario> hrs = snapshot.data!;
            hrs.forEach((element) {
              agregarhora(element.HorInd, element.TurCod);
            });
            return hrs.isEmpty
                ? Center(
                    child: Text(
                    "No hay Cursos!",
                    style: TextStyle(fontSize: 20),
                  ))
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 10.0, top: 10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Table(
                                  columnWidths: {
                                    0: const IntrinsicColumnWidth(), // Ancho ajustado al contenido para la primera columna
                                    for (int i = 1; i <= diasSemana.length; i++)
                                      i: const IntrinsicColumnWidth(), // Ancho ajustado al contenido para las demás columnas
                                  },
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  border: TableBorder.all(),
                                  children: [
                                    TableRow(children: [
                                      for (var dia in ['Día', ...diasSemana])
                                        TextCell(txt: dia),
                                    ]),
                                    for (var bloqueHorario in bloquesHorarios)
                                      TableRow(
                                        children: [
                                          TextCell(txt: bloqueHorario),
                                          for (var dia in diasSemana)
                                            TextCell(txt: getCurso(nro++))
                                          //const ElementTile(currentNumber: 1, txt: 'a'),
                                        ],
                                      ),
                                  ],
                                ))),
                      ),
                    ),
                  );
          } else {
            return const Center(
              child: Text(
                "No se han ingresado cursos!",
                style: TextStyle(fontSize: 20),
              ),
            );
          }
        });
  }

  Widget build2() {
    return SafeArea(
        child: Column(
      children: [
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              ElementTile(currentNumber: 4, txt: diasSemana[index]),
          itemCount: 5,
        )
      ],
    ));
  }
/*
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) => Text('a'),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: 10,
    );
  }*/
}

class TextCell extends StatelessWidget {
  final String txt;
  const TextCell({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.all(8.0), // Añade un margen entre las celdas
          child: Text(txt),
        ),
      ),
    );
  }
}

class ElementTile extends StatelessWidget {
  final int currentNumber;
  final String txt;
  const ElementTile({Key? key, required this.currentNumber, required this.txt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      color: Colors.primaries[currentNumber % Colors.primaries.length],
      child: FittedBox(
        child: Text(txt),
      ),
    );
  }
}
