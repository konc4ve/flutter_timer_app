import 'package:flutter/material.dart';

class TimerConfigurationPanel extends StatelessWidget {
  const TimerConfigurationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Название'),
            trailing: const SizedBox(
              width: 300,
              child: ClearableTextField()
            ),
          ),
          const Divider(height: 1, thickness: 0.5,),
          ListTile(
            title: const Text('По окончании'),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Радиус'), 
                Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ClearableTextField extends StatefulWidget {
  final String hintText;

  const ClearableTextField({
    super.key,
    this.hintText = 'Таймер',
  });

  @override
  State<ClearableTextField> createState() => _ClearableTextFieldState();
}

class _ClearableTextFieldState extends State<ClearableTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _controller.addListener(_updateClearButton);
    _focusNode.addListener(_updateClearButton);
  }

  void _updateClearButton() {
    final hasText = _controller.text.isNotEmpty;
    final hasFocus = _focusNode.hasFocus;
    final shouldShow = hasText && hasFocus;
    
    if (_showClearButton != shouldShow) {
      setState(() => _showClearButton = shouldShow);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          suffixIcon: _showClearButton
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () => _controller.clear(),
                  padding: EdgeInsets.zero,
                )
              : null,
        ),
      ),
    );
  }
}

