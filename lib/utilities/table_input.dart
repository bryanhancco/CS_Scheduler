import 'package:flutter/material.dart';

class TableInput extends StatelessWidget {
  List<int> horasSelec;
  var i = 1;

  TableInput({
    Key? key,
    required this.horasSelec,
  }) : super(key: key);

  final List<String> diasSemana = [
    '   L   ',
    '   M   ',
    '   M   ',
    '   J   ',
    '   V   '
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 10.0, top: 10.0),
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
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                              ColorCell(horas: horasSelec, h: i++),
                            //const ElementTile(currentNumber: 1, txt: 'a'),
                          ],
                        ),
                    ],
                  ))),
        ),
      ),
    );
  }
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
              const EdgeInsets.all(1.0), // Añade un margen entre las celdas
          child: Text(
            txt,
            style: TextStyle(fontSize: 8.0),
          ),
        ),
      ),
    );
  }
}

class ColorCell extends StatelessWidget {
  List<int> horas;
  int h; //La Hora del bloque
  ColorCell({Key? key, required this.horas, required this.h}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: ColorChangingWidget(horas: horas, h: h),
    );
  }
}

class ColorChangingWidget extends StatefulWidget {
  List<int> horas;
  int h; //La Hora del bloque
  ColorChangingWidget({Key? key, required this.horas, required this.h})
      : super(key: key);
  @override
  _ColorChangingWidgetState createState() => _ColorChangingWidgetState();
}

class _ColorChangingWidgetState extends State<ColorChangingWidget> {
  Color _currentColor = Colors.blue; // Color inicial

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Cambiar el color al ser tocado
        setState(() {
          if (_currentColor == Colors.blue) {
            _currentColor = Colors.red;
            widget.horas.add(widget.h);
          } else {
            _currentColor = Colors.blue;
            widget.horas.remove(widget.h);
          }
          //_currentColor = _currentColor == Colors.blue ? Colors.red : Colors.blue;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        color: _currentColor,
        child: Text(
          widget.h.toString(),
          style: TextStyle(fontSize: 8.0),
        ),
      ),
    );
  }
}
