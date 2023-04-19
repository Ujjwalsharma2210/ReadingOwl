import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

Widget SideDrawer(BuildContext context, String email) {
  return Drawer(
    backgroundColor: darkGrey,
    child: ListView(
      children: [
        DrawerHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Signed In as',
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
        Divider(
          color: textColor,
        ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, '/StartWritingScreen'),
          title: Text(
            'Start writing',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Report problem',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
            ),
          ),
          onTap: () => Navigator.pushNamed(context, '/IssueReportScreen'),
        ),
        ListTile(
          title: Text(
            'Logout',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
            ),
          ),
          onTap: () {
            FirebaseAuth.instance.signOut();
            // Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
