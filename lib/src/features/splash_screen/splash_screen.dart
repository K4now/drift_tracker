import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:drift_tracker/routes/app_router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
@RoutePage()
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    // await Future.delayed(Duration(seconds: 2)); // имитация времени загрузки

 
      if (user != null) {
        context.router.replaceAll([const HomeRoute()]);
      } else {
        context.router.replaceAll([const LoginRoute()]);
      }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
