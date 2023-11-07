import 'package:flutter/material.dart';

class CoursesTile extends StatelessWidget {
  final String courseName;

  const CoursesTile({
    super.key,
    required this.courseName,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 15, right: 15),
      child: Container(
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            //Icon(Icons.question_mark_rounded),
            const Icon(Icons.question_mark_rounded),
            const SizedBox(
              width: 20,
            ),
            Text(
              courseName,
              style: const TextStyle(
                fontSize: 27,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
