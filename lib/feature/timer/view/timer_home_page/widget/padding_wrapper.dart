import 'package:flutter/cupertino.dart';

class PaddingWrapper extends StatelessWidget {
  final Widget child;

  const PaddingWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 10, right: 10), child: child,);
  }
}