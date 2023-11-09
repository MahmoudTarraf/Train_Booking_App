import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OfferWidgetNew extends StatelessWidget {
  final Function trainHandler;
  OfferWidgetNew({super.key, required this.trainHandler});
  String _offerWidgetNew = '';
  Widget _enterOfferWidgetNew(BuildContext context) {
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
            return 'Offer Percent must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          _offerWidgetNew = value as String;
          int temp = int.parse(_offerWidgetNew);
          trainHandler(temp);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.numbers),
          hintText: 'Offer Percent',
          hintStyle: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _enterOfferWidgetNew(context);
  }
}
