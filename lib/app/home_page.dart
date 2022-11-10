import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.auth, required this.onSignOut}) : super(key: key);

  final AuthBase auth;

  final VoidCallback onSignOut;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 18,
              ),
            ),
            onPressed: _signOut,
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
