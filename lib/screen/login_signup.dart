import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_page/PaletteColors/palette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_page/main_app_ui/schoolManagement.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isMale = true;
  bool isSignupScreen = true;
  bool isRememberMe = false;
  late String loginEmail;
  late String signupEmail;
  late String loginPassword;
  late String signupPassword;
  late String username;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/background.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Color(0xFF3b5999).withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: isSignupScreen ? "Welcome To " : null,
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 2,
                            color: Colors.yellow[700],
                          ),
                          children: [
                            TextSpan(
                              text: isSignupScreen
                                  ? "Smart Study"
                                  : "Welcome Back",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[700],
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(height: 7),
                    Text(
                      isSignupScreen
                          ? "Signup To Continue"
                          : "Login To Continue",
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Trick to add the shadow for the submit button
          buildCurvedButton(true),
          //Main Container for login and signup
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            curve: Curves.bounceInOut,
            top: isSignupScreen ? 200 : 230,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              height: isSignupScreen ? 380 : 250,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Login".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: !isSignupScreen
                                      ? Palette.textColor1
                                      : Palette.textColor1,
                                ),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Signup".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSignupScreen
                                      ? Palette.activeColor
                                      : Palette.textColor1,
                                ),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildLoginSection(),
                  ],
                ),
              ),
            ),
          ),
          //Code to add curved submit button
          buildCurvedButton(false),
          //Bottom Login Buttons
          Positioned(
            top: MediaQuery.of(context).size.height - 100,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Text(isSignupScreen ? "Or Signup With" : "Or Login With"),
                Container(
                  margin: EdgeInsets.only(
                    right: 20,
                    left: 20,
                    top: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      facebookButton(FontAwesomeIcons.facebook, "Facebook",
                          Palette.facebookColor),
                      facebookButton(
                        FontAwesomeIcons.google,
                        "Google",
                        Palette.googleColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildLoginSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          //Add textfield for sign in here
          Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                onChanged: (value) {
                  loginEmail = value;
                },
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Palette.textColor1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(35.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Email",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Palette.textColor1,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                onChanged: (value) {
                  loginPassword = value;
                },
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Palette.textColor1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(35.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Password",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Palette.textColor1,
                  ),
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: Palette.textColor2,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  Text(
                    "Remember Me",
                    style: TextStyle(
                      fontSize: 12,
                      color: Palette.textColor1,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 12,
                    color: Palette.textColor1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          //Add text field for signup here
          Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                onChanged: (value) {
                  signupEmail = value;
                },
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Palette.textColor1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(35.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Email",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Palette.textColor1,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                onChanged: (value) {
                  signupPassword = value;
                },
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Palette.textColor1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(35.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Password",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Palette.textColor1,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              //Male Selector
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMale = true;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: isMale ? Palette.textColor2 : Colors.transparent,
                        border: Border.all(
                          width: 1,
                          color:
                              isMale ? Colors.transparent : Palette.textColor1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        CupertinoIcons.person,
                        color: isMale ? Colors.white : Palette.iconColor,
                      ),
                    ),
                    Text(
                      "Male",
                      style: TextStyle(color: Palette.textColor1),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 25),
              //Female Selector
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMale = false;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          color:
                              isMale ? Colors.transparent : Palette.textColor2,
                          border: Border.all(
                              width: 1,
                              color: isMale
                                  ? Palette.textColor1
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(15)),
                      child: Icon(
                        Icons.person_outline,
                        color: isMale ? Palette.iconColor : Colors.white,
                      ),
                    ),
                    Text(
                      "Female",
                      style: TextStyle(color: Palette.textColor1),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "By pressing 'Submit' you agree to our ",
                style: TextStyle(color: Palette.textColor2),
                children: [
                  TextSpan(
                    //recognizer: ,
                    text: "term & conditions",
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextButton facebookButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        side: BorderSide(width: 1, color: Colors.grey),
        minimumSize: Size(155, 40),
        primary: Colors.white,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 5,
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget buildCurvedButton(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? 535 : 430,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              if (showShadow)
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
            ],
          ),
          child: !showShadow
              // ignore: deprecated_member_use
              ? Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFFB74D),
                        Color(0xFFEF5350),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        spreadRadius: 1.5,
                        blurRadius: 10,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () async {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: signupEmail, password: signupPassword);
                        if (newUser != null) {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new SchoolManagement(),
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.arrowRight,
                      color: Colors.white,
                    ),
                  ),
                )
              : Center(),
        ),
      ),
    );
  }
}
