import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_page/main_app_ui/schoolManagement.dart';

//Run | Debug
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginSignupUI());
}

class LoginSignupUI extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login Signup UI",
      routes: <String, WidgetBuilder>{
        //SchoolManagement.id: (context) => SchoolManagement(),
        '/': (context) => SchoolManagement(),
        // change the route name of your second page here, if there is one :)
      },
      initialRoute: SchoolManagement.id,
    );
  }
}
