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
    return SizedBox(
      width: 300,
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          suffixIcon: _showClearButton
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    widget.controller.clear();
                    },
                  padding: EdgeInsets.zero,
                )
              : null,
        ),
      ),
    );
  }
}

