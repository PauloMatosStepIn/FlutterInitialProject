import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter_course/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.auth});

  final AuthBase auth;

  Future<void> _signInAnonymously() async {
    try {
      final user = await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final user = await auth.SignInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      final user = await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    //Show EmailSignInPage
    Navigator.of(context).push(MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(auth: auth,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        centerTitle: true,
        elevation: 5.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[300],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Sign In Options',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              )),
          SizedBox(height: 16),
          SocialSignInButton(
            color: Colors.white,
            assetName: 'images/google-logo.png',
            text: 'Sign In with Goolgle',
            textColor: Colors.black87,
            onPressed: _signInWithGoogle,
          ),
          SizedBox(height: 8),
          SocialSignInButton(
            color: Color(0xFF334D92),
            assetName: 'images/facebook-logo.png',
            text: 'Sign In with Facebook',
            textColor: Colors.white,
            onPressed: _signInWithFacebook,
          ),
          SizedBox(height: 8),
          SignInButton(
              text: "Sign In with Email",
              textColor: Colors.white,
              color: Color(0xFF00796B),
              onPressed: () => _signInWithEmail(context)),
          Text('or',
              style: TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center),
          SignInButton(
              text: "Go Anonymous",
              textColor: Colors.black,
              color: Color(0xFFDCE775),
              onPressed: _signInAnonymously),

          // ElevatedButton(
          //   onPressed: null,
          //   child: Text('Disabled'),
          // ),
          // ElevatedButton (
          //   child: Text('Sign In with Google',
          //   style: TextStyle(
          //     color: Colors.indigo
          //   ),
          //   ),
          //   onPressed: _signInWithGoogle,
          //   style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.white,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(5.0),
          //     ),
          // ),
          // ),
          // SizedBox(height: 8),
          // Container(color: Colors.deepOrange, child: SizedBox(height: 50)),
          // SizedBox(height: 8),
          // Container(color: Colors.red, child: SizedBox(height: 50)),
          // SizedBox(height: 8),
          // CustomElevatedButton(
          //   child: Text('Sign In with Facebook',
          //     style: TextStyle(
          //         color: Colors.black87
          //     ),
          //   ),
          //   onPressed: _signInWithGoogle,
          //   borderRadius: 5.0,
          //   backgroundColor: Colors.white
          // ),
          // SizedBox(height: 8),
          // SignInButton(
          //     text: "Sign In with Google",
          //     color: Colors.white,
          //     textColor: Colors.black87,
          //     onPressed: () {}),
          // SizedBox(height: 8),
          // SignInButton(
          //     text: "Sign In with Facebook",
          //     color: Color(0xFF334D92),
          //     textColor: Colors.white,
          //     onPressed: () {}),
          // SizedBox(height: 8),
          // SignInButton(
          //     text: "Sign In with Email",
          //     textColor: Colors.white,
          //     color: Color(0xFF00796B),
          //     onPressed: () {}),
          // Text('or',
          //     style: TextStyle(fontSize: 18, color: Colors.black87),
          //     textAlign: TextAlign.center),
          // SignInButton(
          //     text: "Go Anonymous",
          //     textColor: Colors.black,
          //     color: Color(0xFFDCE775),
          //     onPressed: () {}),
          // SizedBox(height: 8),
          // CustomElevatedButton(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: <Widget>[
          //         Image.asset('images/google-logo.png'),
          //         Text('Sign In with Goolgle',
          //             style: TextStyle(fontSize: 14, color: Colors.black87),
          //             textAlign: TextAlign.center),
          //         Opacity(
          //             opacity: 0.0,
          //             child: Image.asset('images/google-logo.png')),
          //       ],
          //     ),
          //     onPressed: () {},
          //     backgroundColor: Colors.white),
          // // Image.asset('images/google-logo.png'),
        ],
      ),
    );
  }
}
