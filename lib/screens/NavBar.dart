// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:butu1on_dictionary/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'aboutUsPage.dart';
import 'bookmarksPage.dart';
import 'recentPage.dart';
import 'loginPage.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  Widget buildHeader(BuildContext context) => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: const [
          Color(0x66FD7F2C),
          Color(0x99FD7F2C),
          Color(0xccFD7F2C),
          Color(0xffFD7F2C),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        height: 255,
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          child: Column(children: const [
            Image(
              image: AssetImage('assets/drawerlogo.png'),
            ),
          ]),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 2,
          children: [
            Center(
              child: Text(
                'Butu1non Dictionary',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ListTile(
              leading: Icon(Icons.access_time_outlined),
              title: Text('Recent',style: GoogleFonts.poppins(),),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RecentPage(),
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text('Home'),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomePage(),
              )),
            ),
            ListTile(
              leading: Icon(Icons.bookmark_outline_outlined),
              title: Text('Bookmarks'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BookmarksPage(),
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AboutUsPage(),
                ));
              },
            ),
            Divider(),
            SizedBox(
              height: 100,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.redAccent;
                    }
                    return Color(0xffFD7F2C);
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                icon: Text('Login'),
                label: Icon(Icons.login),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
                },
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}
