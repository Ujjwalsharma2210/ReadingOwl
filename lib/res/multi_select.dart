import 'package:flutter/material.dart';

Color deepGrey = Colors.grey.shade900;
Color textColor = Colors.grey.shade500;

class MultiSelect extends StatefulWidget {
  final List<String> listItems;
  const MultiSelect({super.key, required this.listItems});

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> selectedItems = [];

  void itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedItems.add(itemValue);
      } else {
        selectedItems.remove(itemValue);
      }
    });
  }

  void cancel() {
    Navigator.pop(context);
  }

  void submit() {
    Navigator.pop(context, selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: deepGrey,
      title: Text(
        'Select what you like.',
        style: TextStyle(color: textColor),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.listItems
              .map((e) => CheckboxListTile(
                    value: selectedItems.contains(e),
                    onChanged: (isChecked) => itemChange(e, isChecked!),
                    title: Text(
                      e,
                      style: TextStyle(color: textColor),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: cancel,
          child: const Text('Cancle'),
        ),
        ElevatedButton(
          onPressed: submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
