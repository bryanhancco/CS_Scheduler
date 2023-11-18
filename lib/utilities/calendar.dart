import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/database/firebase_operations.dart';
import 'package:scheduler/pages/courses.dart';
import 'package:scheduler/providers/provider.dart';
import 'package:scheduler/utilities/drawer_courses.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<Curso> cursos = <Curso>[];

  @override
  Widget build(BuildContext context) {
    final boolProvider = Provider.of<BoolProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: readCourses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            cursos.clear();
            snapshot.data?.forEach((data) {
              cursos.add(Curso.fromJson(data));
            });
            if (boolProvider.checked.isEmpty) {
              boolProvider.initCourses(cursos);
            }

            return Scaffold(
              body: SfCalendar(
                view: CalendarView.workWeek,
                initialSelectedDate: DateTime(2023, 11, 10, 12),
                dataSource: CourseDataSource(
                    cursos, boolProvider.turnos, boolProvider.checked),
                firstDayOfWeek: 1,
                timeSlotViewSettings: const TimeSlotViewSettings(
                  startHour: 7,
                  endHour: 21,
                  nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return Courses();
            },
          ));
        },
      ),
    );
  }
}
