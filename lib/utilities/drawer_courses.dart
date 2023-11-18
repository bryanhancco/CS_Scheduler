import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/database/firebase_operations.dart';
import 'package:scheduler/database/scheduler_database.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<Curso> items = <Curso>[];
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
                    snapshot.data?.forEach((data) {
                      items.add(Curso.fromJson(data));
                    });
                    List<bool> isChecked =
                        List.generate(items.length, (index) => true);
                    return items.isEmpty
                        ? Center(
                            child: Text(
                            "No hay Cursos!",
                            style: TextStyle(fontSize: 20),
                          ))
                        : ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(items[index].CurNom),
                                leading: Checkbox(
                                  value: isChecked[index],
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked[index] = value ?? false;
                                    });
                                  },
                                ),
                              );
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
