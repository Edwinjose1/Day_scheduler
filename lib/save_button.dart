
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function() onPressed;

  SaveButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
       backgroundColor: const Color.fromARGB(255, 48, 22, 180),
        foregroundColor:  Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: const Text('Save'),
    );
  }
}
