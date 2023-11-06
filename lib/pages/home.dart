import 'package:flutter/material.dart';
import 'package:scheduler/pages/courses.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:scheduler/utilities/table_scheduler.dart';
import 'package:scheduler/utilities/drawer_courses.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Center(
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
              child: Icon(
                Icons.add_circle,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/courses');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
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
        body: Container(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical, child: HorarioTable()),
          /*SfCalendar(
            view: CalendarView.week,
          ),*/
        ));
  }
}
