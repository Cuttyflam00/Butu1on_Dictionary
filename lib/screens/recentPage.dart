// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Recent'),
          // backgroundColor: Color(0xfffd7f2c),
          // flexibleSpace: ClipRRect(
          //   child: Container(
          //     decoration: BoxDecoration(
          //         gradient: LinearGradient(colors: const [
          //       Color(0x66FD7F2C),
          //       Color(0x99FD7F2C),
          //       Color(0xccFD7F2C),
          //       Color(0xffFD7F2C),
          //     ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          //   ),
          // ),
        ),
        body: Center(
            // child: Image.asset('assets/drawerbanner.png'),
            ),
      );
}
