import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

class _HomePageState extends State<HomePage> {
  String advice = "Random Advice";

  @override
  Widget build(BuildContext context) {
    // starts
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Advice'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                advice,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: fetchAdvice,
                child: const Text('get advice'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchAdvice() async {
    final response =
        await http.get(Uri.parse("https://api.adviceslip.com/advice"));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      setState(() {
        advice = result["slip"]["advice"];
      });
    } else {
      setState(() {
        advice = 'Failed to fetch advice';
      });
    }
  }
}
