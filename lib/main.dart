import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Main entry point of the application
void main() {
  runApp(MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// A stateful widget for the home page
class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // Increment counter function
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var unusedVariable = 'This variable is unused';
    int redundantVariable = _counter;
    var someDynamicValue; // Violates data type assertions

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            _buildCounterText(),
            _buildIncrementButton(), // Using helper methods for widgets
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // Direct setState used
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  // Helper method for counter text
  Widget _buildCounterText() {
    return Text(
      '$_counter', // Should handle potential errors with value propagation
      style: Theme.of(context).textTheme.headline4,
    );
  }

  // Helper method for increment button
  Widget _buildIncrementButton() {
    return ElevatedButton(
      onPressed: _incrementCounter,
      child: Text('Increment'), // Violates error handling propagation
    );
  }

  // Unused method for demonstration purposes
  void unusedMethod() {
    // This method does nothing and should be removed
  }
}

// Example of a BLoC class violating SOLID principles
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    emit(state + 1);
  }
}

// Error-prone method without proper error handling
String fetchData() {
  return 'data';
}
