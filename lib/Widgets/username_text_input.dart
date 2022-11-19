import 'package:flutter/material.dart';

class UsernameTextInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const UsernameTextInput(
      {super.key, required this.controller, required this.hintText});

  @override
  State<UsernameTextInput> createState() => _UsernameTextInputState();
}

class _UsernameTextInputState extends State<UsernameTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(21),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
      ),
    );
  }
}
