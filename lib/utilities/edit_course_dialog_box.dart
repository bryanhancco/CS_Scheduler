import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/providers/provider.dart';

class EditCourseDialogBox extends StatefulWidget {
  final Curso cursoForEdition;
  final controllerCourseShortName;
  final controllerCourseName;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final esObligatorio;

  const EditCourseDialogBox({
    Key? key,
    required this.controllerCourseShortName,
    required this.controllerCourseName,
    required this.onSave,
    required this.onCancel,
    required this.esObligatorio,
    required this.cursoForEdition,
  }) : super(key: key);
  @override
  _EditCourseDialogBoxState createState() => _EditCourseDialogBoxState();
}

class _EditCourseDialogBoxState extends State<EditCourseDialogBox> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();

    // Asigna el valor predeterminado al controlador
    widget.controllerCourseName.text = widget.cursoForEdition.CurNom;
    widget.controllerCourseShortName.text = widget.cursoForEdition.CurCod;
  }

  bool selectedOption = false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Container(
          width: queryData.size.width * 0.6,
          height: 390,
          child: Column(children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Editando Curso...",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                        onPressed: widget.onCancel,
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              height: 330,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nombre del Curso:'),
                  TextField(
                    controller: widget.controllerCourseName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: widget.cursoForEdition.CurNom,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Nombre Corto:"),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: widget.controllerCourseShortName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: widget.cursoForEdition.CurCod,
                          ),
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("¿Es obligatorio?"),
                      Checkbox(
                        value: selectedOption,
                        onChanged: (bool? value) {
                          setState(() {
                            selectedOption = !selectedOption;
                            widget.esObligatorio.text = "${selectedOption}";
                          });
                        },
                        side: MaterialStateBorderSide.resolveWith(
                          (states) =>
                              const BorderSide(width: 1.0, color: Colors.black),
                        ),
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return Colors.white;
                        }),
                        checkColor: Colors.black,
                      ),
                    ],
                  ),
                  Center(
                    child: MaterialButton(
                      height: 45,
                      onPressed: widget.onSave,
                      color: const Color.fromRGBO(0, 137, 236, 1),
                      child: const Text(
                        "Modficar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ]
                    .map((widget) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: widget,
                        ))
                    .toList(),
              ),
            ),
          ])),
    );
  }
}
