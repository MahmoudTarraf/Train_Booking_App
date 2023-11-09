import 'package:flutter/material.dart';

class ElectronicWallet extends StatefulWidget {
  const ElectronicWallet({required this.eWalletHandler, super.key});
  final Function eWalletHandler;

  @override
  State<ElectronicWallet> createState() => _ElectronicWalletState();
}

class _ElectronicWalletState extends State<ElectronicWallet> {
  String _passWord = '';
  String _passWords = '';
  bool showPass = true;
  Widget _enterElectronicWallet() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        maxLength: 8,
        obscureText: showPass,
        validator: (value) {
          _passWords = value as String;
          if (_passWords.isEmpty) {
            return 'E_Wallet must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          _passWord = _passWords;
          widget.eWalletHandler(_passWord);
        },
        decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showPass = !showPass;
                });
              },
              icon: showPass
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
            icon: const Icon(Icons.wallet),
            hintText: 'Enter Electronic Wallet',
            label: const Text(
              'Enter Electronic Wallet',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            hintStyle: const TextStyle(fontSize: 22)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _enterElectronicWallet();
  }
}
