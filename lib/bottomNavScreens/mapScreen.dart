import 'package:flutter/material.dart';
import 'package:fluttersociallogin/api_constants.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              api_constants.motivityLogo,
              height: 75,
              width: 200,
            ),
          ),
          Text("Welcome to maps"),
        ],
      ),
    );
  }
}
