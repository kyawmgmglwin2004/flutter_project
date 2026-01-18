import 'package:flutter/material.dart';
import '../controllers/history_controller.dart';

class DisplayTypeSelector extends StatelessWidget {
  final HistoryController controller;

  const DisplayTypeSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _button("時間帯別", controller.loadHourly),
        _button("日別", controller.loadDaily),
        _button("月別", controller.loadMonthly),
      ],
    );
  }

  Widget _button(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(onPressed: onTap, child: Text(text)),
    );
  }
}
