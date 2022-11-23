import 'package:flutter/material.dart';

void main() {
  runApp(const SquareApp());
}

class SquareApp extends StatelessWidget {
  const SquareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Square App',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Number Shapes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int input = 0;
  String? error = 'Please type a number';

  void showAlertDialog(BuildContext context, int number) {
    String result = 'Number is not perfect square or cubic';
    if (checkCube(number) && checkSquare(number)) {
      result = 'Number is a perfect square and a perfect cube';
    } else if (checkSquare(number)) {
      result = 'Number is perfect square';
    } else if (checkCube(number)) {
      result = 'Number is a perfect cube';
    }
    // set up the button
    final Widget okButton = TextButton(
      child: const Text('OK'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    final AlertDialog alert = AlertDialog(
      title: const Text('Result'),
      content: Text(result),
      actions: <Widget>[
        okButton,
      ],
    );

    // show the dialog
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool checkSquare(int x) {
    int left = 1;
    int right = x;
    while (left <= right) {
      final int mid = (left + right) ~/ 2;
      if (mid * mid == x) {
        return true;
      }
      if (mid * mid < x) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }
    return false;
  }

  bool checkCube(int x) {
    int left = 1;
    int right = x;
    while (left <= right) {
      final int mid = (left + right) ~/ 2;

      if (mid * mid * mid == x) {
        return true;
      }
      if (mid * mid * mid < x) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Shapes'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'Input your number',
              style: TextStyle(fontSize: 36),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Input your number',
                errorText: error,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (String number) {
                setState(() {
                  if (number.isEmpty) {
                    error = 'Please type a number';
                  } else {
                    input = int.tryParse(number)!;
                    error = null;
                  }
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlertDialog(context, input);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
