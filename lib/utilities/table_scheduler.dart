import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0), // Ajusta el margen izquierdo según tus necesidades
      child: Align(
        alignment: Alignment.center,
        child: Table(
          columnWidths: {
            0: IntrinsicColumnWidth(), // Ancho ajustado al contenido para la primera columna
            for (int i = 1; i <= diasSemana.length; i++)
              i: IntrinsicColumnWidth(), // Ancho ajustado al contenido para las demás columnas
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(),
          children: [
            TableRow(children: [
              for (var dia in ['Día', ...diasSemana])
                TableCell(
                    child: Center(
                        child: Padding(
                            padding: const EdgeInsets.all(
                                8.0), // Añade un margen entre las celdas
                            child: Text(dia)))),
            ]),
            for (var bloqueHorario in bloquesHorarios)
              TableRow(
                children: [
                  TableCell(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Añade un margen entre las celdas
                        child: Text(bloqueHorario),
                      ),
                    ),
                  ),
                  for (var dia in diasSemana)
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(
                              8.0), // Añade un margen entre las celdas
                          child: Text('Clase\nMateria'),
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
