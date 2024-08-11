import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/login_controller.dart';
import 'package:book_wallert/services/auth_api_services.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({super.key});
  final AuthApiService authService = AuthApiService();

  @override
  State<LoadingScreen> createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isConnected = false;
  bool _hasLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkConnectivityAndLogin();
  }

  Future<void> _checkConnectivityAndLogin() async {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) async {
      // Check if there's at least one type of connectivity
      bool hasConnection = results.any((result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi);

      if (hasConnection) {
        _isConnected = true;
        if (!_hasLoggedIn) {
          await _attemptLogin();
        }
      } else {
        _isConnected = false;
        _navigateToMainScreen();
      }
    });
  }

  Future<void> _attemptLogin() async {
    for (int i = 0; i < 3; i++) {
      if (_isConnected) {
        await LoginController.loginWithToken(context);
        if (Navigator.of(context).canPop()) {
          _hasLoggedIn = true;
          return;
        }
      }
      await Future.delayed(Duration(seconds: 2));
    }
    _navigateToMainScreen();
  }

  void _navigateToMainScreen() {
    if (!_hasLoggedIn) {
      Navigator.pushNamed(context, '/MainScreen');
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildProgressIndicator(),
            const SizedBox(height: 20),
            const Text(
              "Loading, please wait...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
