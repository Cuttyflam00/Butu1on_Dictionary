import 'package:butu1on_dictionary/utils/reusable_widget.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: const [
                  Color(0x66FD7F2C),
                  Color(0x99FD7F2C),
                  Color(0xccFD7F2C),
                  Color(0xffFD7F2C),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 120,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Image.asset('assets/splash_logo.png'),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Our Mission',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: themeColor,
                              ),
                            ),
                            Divider(
                              color: Colors.blue,
                              indent: 10,
                              endIndent: 10,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '        Our mission is to revive and enrich the culture and language of Butuan. Also to provide an efficient means to learn, practice and explore Butuanon Language.',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 10),
                            Text(
                              '        In Butu1on Dictionary, we are passionate about growing the number of Butuanon Speakers not just in Butuan City, but preferably in the whole country.',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'OUR STORY',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: themeColor,
                              ),
                            ),
                            Divider(
                              color: Colors.blue,
                              indent: 10,
                              endIndent: 10,
                            ),
                            SizedBox(height: 20),
                            Text(
                              '        Founded in 2023, Butu1on Dictionary was built by an excellent team of graduating BSIT students of Caraga State University. Together, they recognize the need for an immediate action to the alarming decrease in numbers of Butuanon Speakers in Butuan City. The solution they develop is Butu1on Dictionary, an online and offline mobile dictionary built to provide efficient features in learning the language.',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 10),
                            Text(
                              '    In Butu1on Dictionary, we are passionate about growing the number of Butuanon Speakers not just in Butuan City, but preferably in the whole country.',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        thickness: 5,
                        color: Colors.white,
                      ),
                      Divider(
                        thickness: 5,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Our Team',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/ace.jpg'),
                        radius: 100,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Jonace P. Yamba',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        'BSIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/danna.png'),
                        radius: 100,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Danna Mae D. Buniel',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        'BSIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/raiza.jpg'),
                        radius: 100,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Ann Raiza S. Yamson',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        'BSIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 50,),
                        Divider(
                        thickness: 5,
                        color: Colors.white,
                      ),
                        Divider(
                        indent: 20,
                        endIndent: 20,
                        thickness: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
