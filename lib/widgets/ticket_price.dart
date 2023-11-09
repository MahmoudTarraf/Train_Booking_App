import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TicketPrice extends StatelessWidget {
  final Function trainHandler;
  TicketPrice({super.key, required this.trainHandler});
  String _ticketPrice = '';
  Widget _enterTicketPrice(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ticket Price must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          _ticketPrice = value as String;
          int temp = int.parse(_ticketPrice);
          trainHandler(temp);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.numbers),
          hintText: 'Ticket Price',
          hintStyle: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _enterTicketPrice(context);
  }
}
