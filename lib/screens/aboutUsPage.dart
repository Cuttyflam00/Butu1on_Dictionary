import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Center(
        // child: Image.asset('assets/drawerbanner.png'),
      ),
  );
}