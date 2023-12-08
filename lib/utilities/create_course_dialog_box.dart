import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/providers/provider.dart';

class CreateCourseDialogBox extends StatefulWidget {
  final controllerCourseShortName;
  final controllerCourseName;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final esObligatorio;

  const CreateCourseDialogBox({
    Key? key,
    required this.controllerCourseShortName,
    required this.controllerCourseName,
    required this.onSave,
    required this.onCancel,
    required this.esObligatorio,
  }) : super(key: key);
  @override
  _CreateCourseDialogBoxState createState() => _CreateCourseDialogBoxState();
}

class _CreateCourseDialogBoxState extends State<CreateCourseDialogBox> {
  // This widget is the root of your application.
  bool selectedOption = false;
  bool isShortNameValid = false;
  String botonHabilitado = " ";
  @override
  void initState() {
    super.initState();

    // Agrega un listener al controlador del campo shortName
    widget.controllerCourseShortName.addListener(() {
      setState(() {
        isShortNameValid = widget.controllerCourseShortName.text.isNotEmpty;
      });
    });
  }

  void mostrarTexto() {
    setState(() {
      if (isShortNameValid) {
        botonHabilitado = "";
      } else {
        botonHabilitado = "Ingrese un codigo";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    //return SingleChildScrollView(
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Container(
          width: queryData.size.width * 0.6,
          height: 490,
          child: Column(children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Creando Curso...",
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nombre del Curso:'),
                  TextField(
                    controller: widget.controllerCourseName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Sistemas Operat...",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Nombre Corto:"),
                      Container(
                        width: 70,
                        child: TextField(
                          controller: widget.controllerCourseShortName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "SO",
                          ),
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
                      onPressed: () {
                        if (isShortNameValid) {
                          widget.onSave();
                        } else {
                          mostrarTexto();
                        }
                      },
                      color: isShortNameValid
                          ? const Color.fromRGBO(0, 137, 236, 1)
                          : const Color.fromRGBO(0, 137, 236, 0.5),
                      child: const Text(
                        "Agregar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Center(child: Text(botonHabilitado))
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
    //);
  }
}
