// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

const themeColor = Color(0xffFD7F2C);

Widget reusetextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      // Text(
      //   text,
      //   style: TextStyle(
      //     color: Colors.white,
      //     fontSize: 16,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      SizedBox(
        height: 10,
      ),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        height: 50,
        child: TextField(
          controller: controller,
          obscureText: isPasswordType,
          enableSuggestions: isPasswordType
          ?false
          :true,
          autocorrect: !isPasswordType,
          keyboardType: isPasswordType
              ? TextInputType.visiblePassword
              : TextInputType.emailAddress,
          // keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 16),
              prefixIcon: Icon(
                icon,
                color: Color(0xffFD7F2C),
              ),
              hintText: text,
              hintStyle: TextStyle(
                color: Colors.black38,
              )),
        ),
      ),
    ],
  );
}

Widget buildForgotPassBtn() {
  return Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 0),
    child: TextButton(
      onPressed: () => print("forgot password pressed"),
      child: Text(
        'Forgot Password?',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget signupLoginBtn(BuildContext context, bool islogin, Function onTap) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5),
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Color(0xffFD7F2C);
          }
          return Colors.white;
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
      onPressed: () {
        onTap();
      },
      child: Text(
        islogin ? 'LOGIN' : 'SIGN UP',
        style: TextStyle(
          color: Color(0xffFD7F2C),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget formInputField(
    {required String hintText,
    TextInputType textInputType = TextInputType.name, required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextField(
      // focusNode: focusNode,
      textInputAction: TextInputAction.done,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
          hintText: 'Enter $hintText',
          labelText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    ),
  );
}

Widget makeDismissible(BuildContext context,{required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );


// mic

voiceSearch (BuildContext context)async{
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(builder: (context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AvatarGlow(
            endRadius: 75.0,
            animate: true,
            duration: Duration(milliseconds: 2000),
            glowColor: themeColor,
            repeat: true,
            repeatPauseDuration: Duration(microseconds: 100),
            showTwoGlows: true,
            child: CircleAvatar(
              backgroundColor: themeColor,
              radius: 40,
              child: Icon(Icons.mic,color: Colors.white,size: 30,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Speak Now...',style: TextStyle(inherit: false,fontSize: 16,color: Colors.black54),),
          )
        ],
      ),
    );
});

overlayState?.insert(overlayEntry);  
await Future.delayed(Duration(seconds: 6));
overlayEntry.remove();
        
}
