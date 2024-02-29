import 'package:flutter/material.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  String displayText = "0";
  String inputString = "";

  void buttonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case "C":
          inputString = "";
          displayText = "0";
          break;
        case "=":
          // Implement your calculation logic here
          // Example (replace with your preferred method):
          double result = double.tryParse(inputString) ?? 0;
          displayText = result.toString();
          inputString = displayText;
          break;
        default:
          inputString += buttonText;
          displayText = inputString;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Calculator"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.bottomRight,
              child: Text(
                displayText,
                style: const TextStyle(fontSize: 32.0),
              ),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => buttonPressed("7"),
                child: Text("7"),
              ),
              ElevatedButton(
                onPressed: () => buttonPressed("8"),
                child: Text("8"),
              ),
              ElevatedButton(
                onPressed: () => buttonPressed("9"),
                child: Text("9"),
              ),
              ElevatedButton(
                onPressed: () => buttonPressed("/"),
                child: Text("/"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => buttonPressed("4"),
                child: Text("4"),
              ),
              ElevatedButton(
                onPressed: () => buttonPressed("5"),
                child: Text("5"),
              ),
              ElevatedButton(
                onPressed: () => buttonPressed("6"),
                child: Text("6"),
              ),
              ElevatedButton(
                onPressed: () => buttonPressed("*"),
                child: Text("*"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => buttonPressed("1"),
                child: Text("1"),
              ),
              ElevatedButton(
                onPressed: () => buttonPressed("2"),
                child: Text("2"),
              ),
              ElevatedButton(
                onPressed: () => buttonPressed("3"),
                child: Text("3"),
              ),
              ElevatedButton(
                onPressed: () => buttonPressed("-"),
                child: Text("-"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => buttonPressed("0"),
                child: Text("0"),
              ),
              ElevatedButton(
                onPressed: () => buttonPressed("."),
                child: Text("."),
              ),
              ElevatedButton(
                onPressed: () => buttonPressed("C"),
                child: Text("C"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
              ElevatedButton(
                onPressed: () => buttonPressed("="),
                child: Text("="),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
