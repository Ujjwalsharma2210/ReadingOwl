import 'package:flutter/material.dart';
import 'package:reading_owl/res/colors.dart';
import 'package:reading_owl/res/custom_widgets.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: textColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryItem(context, 'cat1', () {}),
                  CategoryItem(context, 'cat1', () {}),
                  CategoryItem(context, 'cat1', () {}),
                  CategoryItem(context, 'cat1', () {}),
                  CategoryItem(context, 'cat1', () {}),
                  CategoryItem(context, 'cat1', () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Writers',
                style: TextStyle(
                  color: textColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Work in progress',
                style: TextStyle(
                  color: textColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
