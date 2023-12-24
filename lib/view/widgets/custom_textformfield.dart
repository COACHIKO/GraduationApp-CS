import 'package:flutter/material.dart';

class CustomWeightInput extends StatefulWidget {
  final bool isComplete;
  final String hintText;
  final Function(String)? onChanged;

  const CustomWeightInput({
    Key? key,
    required this.isComplete,
    required this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomWeightInputState createState() => _CustomWeightInputState();
}

class _CustomWeightInputState extends State<CustomWeightInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 15,
        color: widget.isComplete ? Colors.white : const Color(0xFF959595),
      ),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
          fontSize: 20,
          color: widget.isComplete ? Colors.white : const Color(0xFF959595),
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
