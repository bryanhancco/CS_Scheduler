import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';

class DetailShiftDialogBox extends StatefulWidget {
  final Turno turno;

  const DetailShiftDialogBox({Key? key, required this.turno}) : super(key: key);
  @override
  _DetailShiftDialogBoxState createState() => _DetailShiftDialogBoxState();
}

class _DetailShiftDialogBoxState extends State<DetailShiftDialogBox> {
  final _controllerDocentes = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Container(
        height: 450,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Turno ' + widget.turno.TurLet),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.cancel)),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Docente:',
              ),
              Text(widget.turno.TurDoc),
            ]),
            Text(
              widget.turno.TurHrs,
              style: const TextStyle(
                fontSize: 27,
              ),
            ),
            Text('Horario'),
          ],
        ),
      ),
    );
  }
}
