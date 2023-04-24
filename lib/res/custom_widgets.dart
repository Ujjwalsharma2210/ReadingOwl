import 'package:flutter/material.dart';
import 'package:reading_owl/res/colors.dart';
import 'package:reading_owl/res/constants.dart';

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
      height: 50,
    ),
  );
}

Widget CategoryItem(
    BuildContext context, String title, Function categoryTapped) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
    child: GestureDetector(
      onTap: () => categoryTapped,
      child: Container(
        // width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: darkGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget TextInputField(
    BuildContext context, TextEditingController controller, String hintText) {
  Color textColor = Colors.grey.shade500;

  return TextField(
    minLines: 1,
    maxLines: 15,
    controller: controller,
    style: TextStyle(color: textColor, fontSize: 16),
    decoration: InputDecoration(
      fillColor: darkGrey,
      filled: true,
      // border: InputBorder.none,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      label: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          hintText,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      hintStyle: TextStyle(color: textColor, fontSize: 16),
    ),
  );
}

Widget TitleText(BuildContext context, String pageHeading) {
  Color grey = Colors.grey.shade500;
  return Center(
    child: Text(
      pageHeading,
      style: TextStyle(
        color: grey,
        fontSize: 38,
        fontWeight: FontWeight.w600,
      ),
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
      backgroundColor: bgColor,
      content: Text(message),
    ),
  );
}

class CustomButton extends StatelessWidget {
  void Function()? onPress;
  String label;
  CustomButton({super.key, required this.onPress, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          label,
          style: TextStyle(
            fontSize: buttonFontSize,
          ),
        ),
      ),
    );
  }
}
