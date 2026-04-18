import 'package:flutter/material.dart';
import 'package:simple_expense_calculator/Page%20Designs/add_expense_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AddExpensePage(),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton:FloatingActionButton.extended(
        foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 30, 109, 170),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          onPressed: _incrementCounter,
          tooltip: 'Add Expense',
          icon: Icon(Icons.add),
          label: const Text('Add Expense', 
            style: TextStyle(fontSize: 17, 
                    fontWeight: FontWeight.w500
                    ),
        ),
      ),
    );
  }
}
