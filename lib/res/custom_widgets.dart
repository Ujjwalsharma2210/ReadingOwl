import 'package:flutter/material.dart';

Color black = Colors.black;
Color darkGrey = Color.fromARGB(255, 23, 23, 23);
Color textColor = Colors.grey.shade500;
Color primaryColor = Colors.deepPurple;
Color grey = Colors.grey.shade900;

double? fontSize = 16;

double borderRadius = 12;

final List<String> listItems = [
  'Health',
  'Fitness',
  'Thriller',
  'Comedy',
  'Science Fiction',
  'Crime',
  'History',
  'Science',
  'Biology',
  'Dark Comedy',
  'Mystery',
  'other'
];

LinearGradient linearGradient(BuildContext context) {
  return LinearGradient(
      colors: [black, grey],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter);
}

Widget OwlImage(BuildContext context) {
  return Container(
    child: Image.asset(
      'assets/owl.png',
      height: 150,
    ),
  );
}

Widget TextInputField(
    BuildContext context, TextEditingController controller, String hintText) {
  Color textColor = Colors.grey.shade500;

  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius), color: darkGrey),
        child: TextField(
          minLines: 1,
          maxLines: 8,
          controller: controller,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
            hintStyle: TextStyle(color: textColor, fontSize: 16),
          ),
        ),
      ));
}

Widget TitleText(BuildContext context, String pageHeading) {
  Color grey = Colors.grey.shade500;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Column(
      children: [
        // Divider(color: grey,),
        Text(
          pageHeading,
          style: TextStyle(
            color: grey,
            fontSize: 35,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

void showToast(BuildContext context, String message, String type) {
  Color bgColor;
  if (type == 'success') {
    bgColor = Colors.green;
  } else if (type == 'error') {
    bgColor = Colors.red;
  } else if (type == 'alert') {
    bgColor = Colors.orange;
  } else {
    bgColor = Colors.deepPurple;
  }

  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(message),
      action: SnackBarAction(
          label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
