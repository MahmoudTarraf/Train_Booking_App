import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.dateHandler});

  @override
  State<DatePicker> createState() => _DatePickerState();
  final Function dateHandler;
}

class _DatePickerState extends State<DatePicker> {
  DateTime _selectedDate = DateTime.now();

  bool showPick = true;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1960),
      lastDate: DateTime(2008),
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
          'Birthday :',
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
            onPressed: _showDatePicker,
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
