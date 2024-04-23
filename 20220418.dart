import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bromas App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JokeScreen(),
    );
  }
}

class JokeScreen extends StatefulWidget {
  @override
  _JokeScreenState createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  String joke = '';

  Future<void> fetchJoke() async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        joke = jsonResponse['setup'] + '\n\n' + jsonResponse['punchline'];
      });
    } else {
      setState(() {
        joke = 'Error al cargar la broma';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bromas'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                joke,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchJoke,
                child: Text('Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
