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
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

// A stateless widget for the home page
class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterCubit, int>(
              builder: (context, counter) {
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CounterCubit>().increment();
              },
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

// BLoC class for managing counter state
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    emit(state + 1);
  }
}

// Error-prone method without proper error handling
String fetchData() {
  try {
    // Simulating data fetch, could throw error
    return 'data';
  } catch (e) {
    // Handle error case
    return 'error';
  }
}