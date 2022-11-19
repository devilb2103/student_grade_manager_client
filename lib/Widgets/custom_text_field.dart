import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  String hintText;
  final String? initialValue;

  CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.initialValue});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    if (widget.initialValue != null) {
      widget.controller.text = widget.initialValue.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      controller: widget.controller,
      decoration: InputDecoration(
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent, width: 0.3),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent, width: 0.75),
          ),
          border: InputBorder.none,
          hintText: widget.hintText,
          fillColor: Colors.white),
    );
  }
}
