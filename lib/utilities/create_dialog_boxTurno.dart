/*
import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';

class CreateDialogBoxTurno extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final Turno turno;
  const CreateDialogBoxTurno({
    Key? key,
    required this.onSave,
    required this.onCancel,
    required this.turno,
  }) : super(key: key);
  @override
  _CreateDialogBoxTurnoState createState() => _CreateDialogBoxTurnoState();
}

class _CreateDialogBoxTurnoState extends State<CreateDialogBoxTurno> {
  bool lunes = false;
  bool martes = false;
  bool miercoles = false;
  bool jueves = false;
  bool viernes = false;
  final _controllerDocentes = TextEditingController();
  List<String> opciones = ['Obligatorio', 'Selectivo'];
  // ignore: non_constant_identifier_names
  String selectedOption = 'Obligatorio';
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    _controllerDocentes.text = widget.turno.docente;
  }

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
                Text('Turno ' + widget.turno.turnoName),
                IconButton(
                    onPressed: widget.onCancel, icon: const Icon(Icons.cancel)),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Docente',
              ),
            ),
            TextField(
              controller: _controllerDocentes,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ingrese el curso",
              ),
            ),
            Container(
                alignment: Alignment.centerLeft, child: Text('Categoria')),
            Container(
              alignment: Alignment.centerLeft,
              child: DropdownButton(
                  value: selectedOption,
                  items: opciones.map((String option) {
                    return DropdownMenuItem<String>(
                        value: option, child: Text(option));
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('L'),
                    Checkbox(
                        value: lunes,
                        onChanged: (bool? newValue) {
                          setState(() {
                            lunes = newValue!;
                          });
                        })
                  ],
                ),
                Column(
                  children: [
                    Text('M'),
                    Checkbox(
                        value: martes,
                        onChanged: (bool? newValue) {
                          setState(() {
                            martes = newValue!;
                          });
                        })
                  ],
                ),
                Column(
                  children: [
                    Text('M'),
                    Checkbox(
                        value: miercoles,
                        onChanged: (bool? newValue) {
                          setState(() {
                            miercoles = newValue!;
                          });
                        })
                  ],
                ),
                Column(
                  children: [
                    Text('J'),
                    Checkbox(
                        value: jueves,
                        onChanged: (bool? newValue) {
                          setState(() {
                            jueves = newValue!;
                          });
                        })
                  ],
                ),
                Column(
                  children: [
                    Text('V'),
                    Checkbox(
                        value: viernes,
                        onChanged: (bool? newValue) {
                          setState(() {
                            viernes = newValue!;
                          });
                        })
                  ],
                ),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Desde'),
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Hasta'),
            ),
            MaterialButton(
              onPressed: widget.onSave,
              color: const Color.fromRGBO(0, 137, 236, 1),
              child: const Text("Grabar"),
            ),
          ],
        ),
      ),
    );
  }
}
*/