// ignore_for_file: unused_field, use_build_context_synchronously

import 'dart:io';
import 'package:thefinaltest/screens/splash_screen.dart';

import '../data/auth.dart';
import '../screens/log_in_screen.dart';
import 'package:provider/provider.dart';
import '../main.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = '/profile';
  //final ImagePicker _picker = ImagePicker();
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _fullName = '';
  String? _fname = '';
  String? _lname = '';
  String? _phoneNumber = '';
  String? _birthday = '';
  int _balance = 0;
  String? _email = '';
  String? _eWallet = '';
  bool _isEditing = false;
  TextEditingController _eWalletController = TextEditingController();
  bool isInitialized = false;
  bool isEditing = false;
  bool _isWidgetShowing = false;
  bool _isTextButtonShowing = true;
  File? _imageFile;
  String? _savedImagePath;
  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _savedImagePath = pickedFile.path;
      });
    }

    _saveImage();
  }

  Future<void> _saveImage() async {
    if (_imageFile == null) {
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    const fileName = 'my_image.png';
    final file = File('${directory.path}/$fileName');

    try {
      await file.writeAsBytes(await _imageFile!.readAsBytes());
      setState(() {
        _savedImagePath = file.path;
        _isTextButtonShowing = !_isTextButtonShowing;
        _isWidgetShowing = !_isWidgetShowing;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Error saving image!'),
            content: const Text('Try again later'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text(
                  'Okay',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _loadImage() async {
    final directory = await getApplicationDocumentsDirectory();
    const fileName = 'my_image.png';
    final file = File('${directory.path}/$fileName');
    if (await file.exists()) {
      setState(() {
        _savedImagePath = file.path;
      });
    }
  }

  Future<void> getData() async {
    final userData =
        await Provider.of<Auth>(context, listen: false).getUserData();
    Provider.of<Auth>(context, listen: false)
        .setBalance(userData['Balance'] as int);
    if (userData.isEmpty) {
      Navigator.of(context).pushReplacementNamed(LogIn.routeName);
    }
    _email = userData['Email'] as String?;
    _fname = userData['First name'] as String?;
    _lname = userData['Last name'] as String?;
    _balance = userData['Balance'] as int;
    _birthday = userData['Birthday'] as String?;
    _eWallet = userData['Electronic Wallet'] as String?;
    _phoneNumber = userData['Phone Number'] as String?;
  }

  bool isFirst = true;
  @override
  void didChangeDependencies() async {
    if (isFirst) {
      setState(() {
        isInitialized = true;
      });
      await getData();

      _eWalletController = TextEditingController(text: _eWallet);
      _loadImage();
      setState(() {
        isInitialized = false;
      });
    }
    isFirst = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _fullName = '$_fname $_lname';
    return isInitialized
        ? const SplashScreen()
        : Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/profile_pic2.jpg'),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'Edit your Profile !',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _savedImagePath != null
                            ? CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    FileImage(File(_savedImagePath!)),
                              )
                            : const CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    AssetImage('assets/images/moon.jpeg'),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: _isTextButtonShowing,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isWidgetShowing = !_isWidgetShowing;
                                      _isTextButtonShowing =
                                          !_isTextButtonShowing;
                                    });
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                        color: Colors.yellow, fontSize: 24),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.yellow,
                                  onPressed: () {
                                    setState(() {
                                      _isWidgetShowing = !_isWidgetShowing;
                                      _isTextButtonShowing =
                                          !_isTextButtonShowing;
                                    });
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              ]),
                        ),
                        Visibility(
                          visible: _isWidgetShowing,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      color: Colors.yellow,
                                      size: 33,
                                    ),
                                    Text(
                                      'From Gallery',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 19),
                                    ),
                                  ],
                                ),
                                onPressed: () => _getImage(ImageSource.gallery),
                              ),
                              const SizedBox(
                                height: 30,
                                child: VerticalDivider(
                                  color: Color.fromARGB(255, 21, 93, 153),
                                  thickness: 5,
                                ),
                              ),
                              TextButton(
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      color: Colors.yellow,
                                      size: 33,
                                    ),
                                    Text(
                                      'From Camera',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 19),
                                    ),
                                  ],
                                ),
                                onPressed: () => _getImage(ImageSource.camera),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Name:',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.amber),
                            ),
                            Text(
                              _fullName,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Phone Number:',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.amber),
                            ),
                            Text(
                              _phoneNumber!,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildTextField(
                            'E_Wallet:', _eWallet!, _eWalletController),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Balance:',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.amber),
                            ),
                            Text(
                              _balance.toString(),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Email:',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.amber),
                            ),
                            Text(
                              _email!,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (!_isEditing)
                              TextButton.icon(
                                onPressed: () {
                                  // Switch to editing mode
                                  setState(() {
                                    _isEditing = true;
                                  });
                                },
                                icon: const Icon(Icons.edit),
                                label: const Text('Edit'),
                                style: const ButtonStyle(
                                    iconSize: MaterialStatePropertyAll(30),
                                    textStyle: MaterialStatePropertyAll(
                                      TextStyle(fontSize: 23),
                                    ),
                                    foregroundColor: MaterialStatePropertyAll(
                                        Colors.yellow)),
                              ),
                            if (_isEditing)
                              TextButton.icon(
                                onPressed: () async {
                                  await Provider.of<Auth>(context,
                                          listen: false)
                                      .updateUserWallet(
                                          _eWalletController.text);
                                  _eWallet = _eWalletController.text;
                                  setState(() {
                                    //_eWallet = _eWallet!.text;
                                    _isEditing = false;
                                  });
                                },
                                icon: const Icon(Icons.save),
                                label: const Text('Save'),
                                style: const ButtonStyle(
                                    textStyle: MaterialStatePropertyAll(
                                        TextStyle(fontSize: 23)),
                                    iconSize: MaterialStatePropertyAll(30),
                                    foregroundColor: MaterialStatePropertyAll(
                                        Colors.yellow)),
                              ),
                            const SizedBox(
                              width: 40,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 40,
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await Provider.of<Auth>(context, listen: false)
                                    .signOut();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    AuthChecker.routeName, (route) => false);
                              },
                              child: const Text(
                                'LogOut',
                                style:
                                    TextStyle(fontSize: 24, color: Colors.red),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await Provider.of<Auth>(context, listen: false)
                                    .signOut();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    AuthChecker.routeName, (route) => false);
                              },
                              icon: const Icon(Icons.logout_outlined),
                              color: Colors.red,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget _buildTextField(
      String label, String value, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 20, color: Colors.amber)),
          if (_isEditing)
            SizedBox(
              width: 200,
              child: TextField(
                maxLength: 8,
                style: const TextStyle(color: Colors.black),
                controller: controller,
                decoration: InputDecoration(
                  hintText: value,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
              ),
            )
          else
            Text(value,
                style: const TextStyle(fontSize: 20.0, color: Colors.white)),
        ],
      ),
    );
  }
}

/*class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, size.height);
    path.close();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height * 0.5);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}*/
