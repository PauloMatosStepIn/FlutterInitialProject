import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

abstract class AuthBase {
  User? get currentUser;
  Future<User?> signInAnonymously();
  Future<void> signOut();
}

class Auth implements AuthBase{

  final _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> signInAnonymously() async {
    final userCredentials = await _firebaseAuth.signInAnonymously();
    return userCredentials?.user;
  }
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    return;
  }
}