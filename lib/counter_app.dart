import 'package:flutter/material.dart';
import 'package:shared_preference_project/services/shared_preference_service.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int count = 0;

  Future<void> incrementCounter() async {
    count++;
    await PreferenceService.setValue('counter', count);
    setState(() {});
  }

  Future<void> decrementCounter() async {
    count--;
    await PreferenceService.setValue('counter', count);
    setState(() {});
  }

  @override
  void initState() {
    count = PreferenceService.getInt('counter');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
      ),
      body: Center(
        child: Text(
          '$count',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 50,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                incrementCounter();
              },
              label: const Text('INCREMENT'),
              icon: const Icon(Icons.add),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                decrementCounter();
              },
              label: const Text('DECREMENT'),
              icon: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
