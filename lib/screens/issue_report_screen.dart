import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reading_owl/res/custom_widgets.dart';
import 'package:reading_owl/res/data_structures.dart';
import 'package:reading_owl/screens/start_writing_screen.dart';

class IssueReportScreen extends StatefulWidget {
  const IssueReportScreen({super.key});

  @override
  State<IssueReportScreen> createState() => _IssueReportScreenState();
}

class _IssueReportScreenState extends State<IssueReportScreen> {
  TextEditingController issueController = TextEditingController();

  void reportIssue(Issue issue) async {
    var dbRef = FirebaseFirestore.instance.collection('issues').doc();
    final json = issue.toJson();
    await dbRef.set(json);
    issueController.clear();
    Navigator.pop(context);
    showToast(context, 'Reported successfully', 'success');
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.3;
    return Scaffold(
      backgroundColor: black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TitleText(context, 'Report bug or make suggestions'),
            SizedBox(
              height: height,
            ),
            TextInputField(context, issueController, 'What is the issue?'),
            Text(
              'These reports are completely anonymous.\nThankyou for helping',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                final issue = Issue(issueDescription: issueController.text);
                reportIssue(issue);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'REPORT',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
