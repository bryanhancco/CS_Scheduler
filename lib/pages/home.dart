import 'package:flutter/material.dart';
import 'package:scheduler/pages/courses.dart';
import 'package:scheduler/utilities/calendar.dart';
import 'package:scheduler/utilities/table_scheduler.dart';
import 'package:scheduler/utilities/drawer_courses.dart';
//import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatelessWidget {
  Home({super.key});
  //final nextfriday = nextFriday(DateTime.now());
  //final nextfriday = nextFriday(DateTime(2023, 11, 6));

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
      body: CalendarScreen(),
      /*body: Container(
          child: SfCalendar(
            view: CalendarView.week,
            headerHeight: 0,
            minDate: nextfriday.subtract(Duration(days: 4)),
            /*(now == DateTime.saturday || now == DateTime.sunday)
                ? DateTime(2023, 11, 13)
                : DateTime(2023, 11, 6),*/
            maxDate: nextfriday.add(Duration(hours: 22)),
            /*(now == DateTime.saturday || now == DateTime.sunday)
                ? DateTime(2023, 11, 17)
                : DateTime(2023, 11, 10),*/
            timeSlotViewSettings: const TimeSlotViewSettings(
              startHour: 6,
              endHour: 22,
              nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday],
              numberOfDaysInView: 5,
            ),
            firstDayOfWeek: 1,
          ),
        )*/
    );
  }
}

DateTime nextFriday(DateTime fechaActual) {
  // Obtener el día de la semana actual (0 para domingo, 1 para lunes, ..., 6 para sábado)
  int diaSemanaActual = fechaActual.weekday;

  // Calcular la cantidad de días hasta el próximo viernes (considerando que el viernes es el día 5)
  int diasHastaViernes = (5 - diaSemanaActual + 7) % 7;

  // Sumar la cantidad de días calculada a la fecha actual para obtener el próximo viernes
  DateTime proximoViernes = fechaActual.add(Duration(days: diasHastaViernes));
  DateTime fechaRedondeada =
      DateTime(proximoViernes.year, proximoViernes.month, proximoViernes.day);

  return fechaRedondeada;
}
