import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter_course/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/auth_provider.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _showSignInError(BuildContext context, Exception exception) {
    showExceptionAlertDialog(context,
        title: 'Sign In has Failed', exception: exception);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      final user = await auth.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
      //print(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      final user = await auth.SignInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
      //print(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      final user = await auth.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
      //print(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _signInWithEmail(BuildContext context) {
    //Show EmailSignInPage
    final auth = Provider.of<AuthBase>(context, listen: false);

    Navigator.of(context).push(MaterialPageRoute<void>(
        fullscreenDialog: true, builder: (context) => EmailSignInPage()));
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 300,
                child: _buildHeader()),
            /*
            Text('Sign In Options',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                )),
             */
            SizedBox(height: 16),
            SocialSignInButton(
              color: Colors.white,
              assetName: 'images/google-logo.png',
              text: 'Sign In with Goolgle',
              textColor: Colors.black87,
              onPressed: _isLoading ? (){} : () => _signInWithGoogle(context),
            ),
            SizedBox(height: 8),
            SocialSignInButton(
              color: Color(0xFF334D92),
              assetName: 'images/facebook-logo.png',
              text: 'Sign In with Facebook',
              textColor: Colors.white,
              onPressed: _isLoading ? (){} : () => _signInWithFacebook(context),
            ),
            SizedBox(height: 8),
            SignInButton(
                text: "Sign In with Email",
                textColor: Colors.white,
                color: Color(0xFF00796B),
                onPressed: _isLoading ? (){} : () => _signInWithEmail(context)),
            Text('or',
                style: TextStyle(fontSize: 18, color: Colors.black87),
                textAlign: TextAlign.center),
            SignInButton(
                text: "Go Anonymous",
                textColor: Colors.black,
                color: Color(0xFFDCE775),
                onPressed: _isLoading ? (){} : () => _signInAnonymously(context)),

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
      ),
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }else{
      return
      Text('Sign In Options',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ));
    }

  }
}
