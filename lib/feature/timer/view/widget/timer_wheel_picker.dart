import 'package:flutter/material.dart';


class TimerWheelPicker extends StatefulWidget {
  final void Function(int hours, int minutes, int seconds) onChanged;

  const TimerWheelPicker({
    super.key,
    required this.onChanged,
  });

  @override
  State<TimerWheelPicker> createState() => _TimerWheelPickerState();
}

class _TimerWheelPickerState extends State<TimerWheelPicker> {

  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  final FixedExtentScrollController _hController = FixedExtentScrollController();
  final FixedExtentScrollController _minController = FixedExtentScrollController();
  final FixedExtentScrollController _secController = FixedExtentScrollController();

  void _update(){
    widget.onChanged(_hours, _minutes, _seconds);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
        // color: Colors.amber
        ),
        width: 600,
        height: 250,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 350,
                height: 25,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 68, 65, 65),
                  borderRadius: BorderRadius.circular(4)
                ),
                ),
            ),
            Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWheelPicker(
                  _hController,
                  24,
                  'ч',
                  (val) {
                    _hours = val;
                    _update();
                  },
                ),
                _buildWheelPicker(
                  _minController,
                  60,
                  'мин',
                  (val) {
                    _minutes = val;
                    _update();
                  },
                ),
                _buildWheelPicker(
                  _secController,
                  60,
                  'с',
                  (val) {
                    _seconds = val;
                    _update();
                  },
                ),      
              ],
            ),
          ),
          ]
        ),
      ),
    );
  }
}


Widget _buildWheelPicker(
  ScrollController controller,
  int maxvalue,
  String unit,
  ValueChanged<int> onSelected,
   ) {
  return SizedBox(
    width: 100,
    height: 250,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 25,
          height: 250,
          child: ListWheelScrollView(
            onSelectedItemChanged: onSelected,
            controller: controller,
            diameterRatio: 0.7,
            physics: const FixedExtentScrollPhysics(),
            itemExtent: 27,
            children: List.generate(
              maxvalue,
              (index) => Text(
                '$index',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        SizedBox(
          width: 30,
          child: Text(unit,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        )
      ],
    ),
  );
}