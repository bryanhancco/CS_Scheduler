import 'package:flutter/material.dart';
import 'package:scheduler/pages/courses.dart';
import 'package:scheduler/utilities/table_scheduler.dart';
import 'package:scheduler/utilities/drawer_courses.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "HorarioHarmony",
            style: TextStyle(
              color: Color.fromRGBO(0, 137, 236, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const Courses();
              }));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Icon(
              Icons.add_circle,
              color: Colors.black,
            ),
          ),
          //IconButton(onPressed: () {},  icon: Icon(Icons.add_circle, color: Colors.black,))
        ],
      ),
      /*drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                child: Text("HorarioHarmony"),
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Compartir/Exportar"),
              ),
            ],
          ),
        ),*/
      drawer: MyDrawer(),
      body: SingleChildScrollView(child: HorarioTable()),
    );
  }
}
