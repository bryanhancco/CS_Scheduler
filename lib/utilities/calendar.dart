import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/database/firebase_operations.dart';
import 'package:scheduler/pages/courses.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<Curso> cursos = <Curso>[];
  List<int> indiceTurnos = [0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: readCourses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshot.data?.forEach((data) {
              cursos.add(Curso.fromJson(data));
            });

            return Scaffold(
              body: SfCalendar(
                view: CalendarView.workWeek,
                initialSelectedDate: DateTime(2023, 11, 10, 12),
                dataSource: CourseDataSource(cursos, indiceTurnos),
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
