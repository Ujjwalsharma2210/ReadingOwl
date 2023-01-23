import 'package:flutter/material.dart';

Color black = Colors.black;
Color darkGrey = Colors.grey.withOpacity(0.13);
Color textColor = Colors.grey.shade500;
Color primaryColor = Colors.deepPurple;
Color grey = Colors.grey.shade800;
Color white = Colors.white;

class ReadingScreen extends StatelessWidget {
  final String title;
  final String content;
  final String? author;
  const ReadingScreen({
    super.key,
    required this.title,
    required this.content,
    this.author,
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
              title,
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
              content,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
              ),
            ),
            Divider(
              color: textColor,
            ),
            Text(
              'Written by ' + author!,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
