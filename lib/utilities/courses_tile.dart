import 'package:flutter/material.dart';

class CoursesTile extends StatelessWidget {
  final String courseName;

  CoursesTile({
    super.key, 
    required this.courseName, 
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 15, right: 15),
      child: Container(
        padding: EdgeInsets.all(18.0),
        child: Row(
          
          children: [            //Icon(Icons.question_mark_rounded),
            Icon(Icons.question_mark_rounded),
            SizedBox(width: 20,),
            Text(
              this.courseName,
              style: TextStyle(
                fontSize: 27,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white, 
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

