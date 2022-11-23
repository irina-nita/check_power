import 'package:flutter/material.dart';

void main() {
  runApp(const CheckPowerApp());
}

class CheckPowerApp extends StatelessWidget {
  const CheckPowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        canvasColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// Returns appropriate message if a value is a square or a cube.
String checkPower(int? value) {
  if (value == null) {
    return 'You did not enter a number!';
  }
  if (value == 1) {
    return '$value is both';
  }

  int square = 0;
  int cube = 0;

  for (int i = 2; i < value / 2 + 1; i++) {
    if (value == i * i) {
      square = 1;
    }
    if (value == i * i * i) {
      cube = 1;
    }
  }

  if (square == 1 && cube == 0) {
    return '$value is a square!';
  }
  if (square == 0 && cube == 1) {
    return '$value is a cube!';
  }
  if (square == 1 && cube == 1) {
    return '$value is both!';
  }

  return "It's neither!";
}

Future<void> _buildPopupDialog(BuildContext context, int? value) {
  final String message = checkPower(value);
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Square or cube?'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.lightBlue),
            ),
          ),
        ],
      );
    },
  );
}

class _HomePageState extends State<HomePage> {
  String? typeError = '';
  final TextEditingController controller = TextEditingController();
  int? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Square or cube?')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/main_photo.jpg',
            alignment: Alignment.topCenter,
            scale: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Please enter a number',
                errorText: typeError,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    typeError = null;
                  },
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (String input) {
                setState(() {
                  if (input == '') {
                    typeError = null;
                  } else {
                    value = int.tryParse(input);
                    if (value == null) {
                      typeError = 'Enter a valid number';
                    } else {
                      typeError = null;
                    }
                  }
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _buildPopupDialog(context, value);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 107, 140, 147),
            ),
            child: const Text('Check'),
          )
        ],
      ),
    );
  }
}
