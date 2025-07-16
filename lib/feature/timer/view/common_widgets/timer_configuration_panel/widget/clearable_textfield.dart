import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClearableTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const ClearableTextField({
    super.key,
    required this.controller,
    this.hintText = 'Таймер',
  });

  @override
  State<ClearableTextField> createState() => _ClearableTextFieldState();
}

class _ClearableTextFieldState extends State<ClearableTextField> {
  late final FocusNode _focusNode;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    widget.controller.clear();
    _focusNode = FocusNode();
    widget.controller.addListener(_updateClearButton);
    _focusNode.addListener(_updateClearButton);
  }

  void _updateClearButton() {
    final hasText = widget.controller.text.isNotEmpty;
    final hasFocus = _focusNode.hasFocus;
    final shouldShow = hasText && hasFocus;

    if (_showClearButton != shouldShow) {
      setState(() => _showClearButton = shouldShow);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            cursorColor: CupertinoColors.activeOrange,
            cursorWidth: 1.5,
            cursorHeight: 25,
            textAlign: TextAlign.end,
            style: const TextStyle(color: Color.fromARGB(255, 167, 165, 165), fontSize: 16),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 17, color: const Color.fromARGB(255, 89, 89, 89)),
            ),
          ),
        ),
        if (_showClearButton)
          GestureDetector(
            onTap: () {
              widget.controller.clear();
            },
            child: SizedBox(
                width: 21,
                child: Icon(
                  CupertinoIcons.clear_thick_circled,
                  color: const Color.fromARGB(255, 92, 92, 92),
                )),
          )
      ],
    );
  }
}
