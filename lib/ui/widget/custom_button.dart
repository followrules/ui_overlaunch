import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final VoidCallback onPressed;

  const CustomButton(this.text, {super.key, required this.enabled, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? Colors.green : Colors.grey,
        foregroundColor: Colors.white,
        minimumSize: const Size(160, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}
