// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OnBoardingTime extends StatefulWidget {
  final Function onBoardingTimeHandler;
  const OnBoardingTime({Key? key, required this.onBoardingTimeHandler})
      : super(key: key);

  @override
  _OnBoardingTimeState createState() => _OnBoardingTimeState();
}

class _OnBoardingTimeState extends State<OnBoardingTime> {
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
      widget.onBoardingTimeHandler(_selectedTime!.format(context));
    }
  }

  Widget _enterOnBoardingTime(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton.icon(
        onPressed: () => _selectTime(context),
        label: Text(
          _selectedTime?.format(context) ?? 'Enter OnBoarding Time',
          style: const TextStyle(fontSize: 21),
        ),
        icon: const Icon(Icons.access_time_sharp, size: 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _enterOnBoardingTime(context);
  }
}
