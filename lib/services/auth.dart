import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

abstract class AuthBase {
  User? get currentUser;

  Stream<User?> authStateChanges();

  Future<User?> signInAnonymously();

  Future<User?> SignInWithGoogle();

  Future<User?> signInWithFacebook();

  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<User?> createUserWithEmailAndPassword(String email, String password);

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInAnonymously() async {
    final userCredentials = await _firebaseAuth.signInAnonymously();
    return userCredentials.user;
  }

  @override
  Future<User?> SignInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredentials = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return userCredentials.user;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google Id Token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign In Aborted By User',
      );
    }
  }

  @override
  Future<User?> signInWithFacebook() async{
    final fb = FacebookLogin();
        final response = await fb.logIn(permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ]);
        switch (response.status){
          case FacebookLoginStatus.success:
            final accessToken = response.accessToken;
            final userCredentials = await _firebaseAuth.signInWithCredential(
              FacebookAuthProvider.credential(accessToken!.token)
            );
            return userCredentials.user;
          case FacebookLoginStatus.cancel:
            throw FirebaseAuthException(
              code: 'ERROR_ABORTED_BY_USER',
              message: 'Sign In Aborted By User',
            );
          case FacebookLoginStatus.error:
            throw FirebaseAuthException(
              code: 'ERROR_FACEBOOK_LOGIN_FAILED',
              message: response.error?.developerMessage,
           );
          default:
           throw UnimplementedError();
        }
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    final userCredentials = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password)
    );
    return userCredentials.user;
  }


  @override
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    final userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password
    );
    return userCredentials.user;
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
    return;
  }
}
