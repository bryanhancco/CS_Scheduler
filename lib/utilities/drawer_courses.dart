import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/database/firebase_operations.dart';
import 'package:scheduler/database/scheduler_database.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/providers/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<Curso> items = <Curso>[];
  List<bool> isChecked = [true, true];

  void updateCheckboxValue(int i, bool newValue) {
    setState(() {
      isChecked[i] = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 140, // Ajusta la altura del DrawerHeader
            decoration: const BoxDecoration(
              color: Colors.blue, // Color de fondo personalizado
            ),
            child: const DrawerHeader(
              margin: EdgeInsets.all(0), // Sin margen
              padding: EdgeInsets.all(10), // Añade relleno personalizado
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                    width: double.infinity,
                    child: Image(image: AssetImage('assets/LogoHorario.jpg')),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "HorarioHarmony",
                    style: TextStyle(
                      fontSize: 20, // Tamaño de fuente personalizado
                    ),
                  ),
                ],
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.share),
            title: Text("Compartir/Exportar"),
          ),
          // = List.generate(Curso.ejemplos.length, (index) => true);
          Expanded(
            child: FutureBuilder(
                future: readCourses(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    items.clear();
                    print("Cargando cursos");
                    snapshot.data?.forEach((data) {
                      items.add(Curso.fromJson(data));
                    });
                    return items.isEmpty
                        ? Center(
                            child: Text(
                            "No hay Cursos!",
                            style: TextStyle(fontSize: 20),
                          ))
                        : ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              /*return ListTile(
                                title: Text(items[index].CurNom),
                                leading: Checkbox(
                                  value: boolProvider.getValue(index),
                                  onChanged: (value) {
                                    /*
                                    setState(() {
                                      print("set estate");
                                      isChecked[index] = value ?? false;
                                    });*/
                                    //boolProvider.changeValue(index);
                                    updateCheckboxValue(index, value ?? false);
                                  },
                                ),
                              );*/
                              return ItemCurso(
                                  name: items[index].CurNom, i: index);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                              height: 1,
                            ),
                            itemCount: items.length,
                          );
                  } else {
                    return const Center(
                      child: Text(
                        "No se han ingresado cursos!",
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class ItemCurso extends StatefulWidget {
  final String name;
  //final bool initialValue;
  final int i;
  //List<bool> listaValores;
//, required this.listaValores
  ItemCurso({required this.name, required this.i});

  @override
  _ItemCursoState createState() => _ItemCursoState();
}

class _ItemCursoState extends State<ItemCurso> {
  late bool _value;

  @override
  Widget build(BuildContext context) {
    final boolProvider = Provider.of<BoolProvider>(context);
    /*void _changeValue() {
      boolProvider.changeValue(widget.i);
    }*/

    return ListTile(
      title: Text(widget.name),
      leading: Checkbox(
        value: boolProvider.getValue(widget.i),
        onChanged: (value) {
          /*
                                    setState(() {
                                      print("set estate");
                                      isChecked[index] = value ?? false;
                                    });*/
          boolProvider.changeValue(widget.i);
          //updateCheckboxValue(widget.i, value ?? false);
        },
      ),
    );
  }
}
