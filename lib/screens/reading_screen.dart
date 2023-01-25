import 'package:flutter/material.dart';

import '../res/data_structures.dart';
import 'package:reading_owl/res/colors.dart';

class ReadingScreen extends StatelessWidget {
  final Blog blog;
  const ReadingScreen({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Text(
              blog.title,
              style: TextStyle(
                color: textColor,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(
              color: textColor,
            ),
            Text(
              blog.content,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
              ),
            ),
            Divider(
              color: textColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'By ${blog.author}',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Icon(
                  Icons.remove_red_eye_sharp,
                  color: textColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  blog.reads.toString(),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
