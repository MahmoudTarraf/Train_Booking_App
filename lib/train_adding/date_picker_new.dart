import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerNew extends StatefulWidget {
  const DatePickerNew({super.key, required this.dateHandler});

  @override
  State<DatePickerNew> createState() => _DatePickerNewState();
  final Function dateHandler;
}

class _DatePickerNewState extends State<DatePickerNew> {
  DateTime _selectedDate = DateTime.now();

  bool showPick = true;

  void _showDatePickerNew() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then(
      (value) {
        if (value == null) {
          return;
        }
        setState(() {
          showPick = false;
          _selectedDate = value;

          String dateForm = DateFormat.yMd().format(_selectedDate);
          widget.dateHandler(dateForm);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String dateForm = DateFormat.yMd().format(_selectedDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'Trip Date :',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 150,
          child: ElevatedButton(
            style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(
                Colors.black,
              ),
              backgroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
            ),
            onPressed: _showDatePickerNew,
            child: Row(
              children: [
                showPick
                    ? const Text(
                        'Pick',
                        style: TextStyle(fontSize: 22),
                      )
                    : Text(
                        dateForm,
                        style: const TextStyle(fontSize: 24),
                      ),
                showPick
                    ? const SizedBox(
                        width: 40,
                      )
                    : Container(),
                showPick
                    ? const Icon(
                        Icons.edit_calendar,
                        size: 30,
                        color: Colors.teal,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
