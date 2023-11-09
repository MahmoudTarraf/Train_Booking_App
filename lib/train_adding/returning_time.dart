// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReturningTime extends StatefulWidget {
  final Function returningTimeHandler;
  const ReturningTime({Key? key, required this.returningTimeHandler})
      : super(key: key);

  @override
  _ReturningTimeState createState() => _ReturningTimeState();
}

class _ReturningTimeState extends State<ReturningTime> {
  TimeOfDay? _selectedTime;

  void _selectTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (newTime != null) {
      setState(() {
        _selectedTime = newTime;
      });
      widget.returningTimeHandler(_selectedTime!.format(context));
    }
  }

  Widget _enterReturningTime(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton.icon(
        onPressed: () => _selectTime(context),
        label: Text(
          _selectedTime?.format(context) ?? 'Enter Returning Time',
          style: const TextStyle(fontSize: 21),
        ),
        icon: const Icon(Icons.access_time_sharp, size: 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _enterReturningTime(context);
  }
}
