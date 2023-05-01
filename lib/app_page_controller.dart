import 'package:auth_test/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class AppPageController extends StatefulWidget {
  const AppPageController({Key? key}) : super(key: key);

  @override
  State<AppPageController> createState() => _AppPageControllerState();
}

class _AppPageControllerState extends State<AppPageController> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        }
        return const LoginPage();
      },
    );
    //return Scaffold(
    // body: FutureBuilder(
    //   future: getCurrentUser(),
    //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
    //
    //     if(snapshot.hasData){
    //       if(snapshot.data!){
    //         return const HomePage();
    //       }
    //       return const LoginPage();
    //     }
    //     return const Center(child: CircularProgressIndicator(),);
    //   },
    //
    // ),
    // );
  }

  Future<bool> getCurrentUser() {
    bool isLoggedIn = false;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is not signed in!');
      } else {
        print('User is signed in!');
        isLoggedIn = true;
      }
    });
    return Future.value(isLoggedIn);
  }
}
