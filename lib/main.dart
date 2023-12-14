import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // StreamController for StreamBuilder
  final StreamController<int> _streamController = StreamController<int>();

  // Future for FutureBuilder
  Future<String> _futureData = fetchData();

  // Counter for StatefulBuilder
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Builders Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // StreamBuilder Example
            StreamBuilder<int>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                return Text('StreamBuilder: ${snapshot.data ?? 'No data'}');
              },
            ),
            SizedBox(height: 20),
            // FutureBuilder Example
            FutureBuilder<String>(
              future: _futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('FutureBuilder: ${snapshot.data ?? 'No data'}');
                }
              },
            ),
            SizedBox(height: 20),
            // StatefulBuilder Example
            StatefulBuilder(
              builder: (context, setState) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _counter++;
                    });
                  },
                  child: Text('StatefulBuilder: $_counter'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}

// Future simulation function
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Future Data Loaded';
}
