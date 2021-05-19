import 'package:firebase_auth/firebase_auth.dart';
import 'package:ungcamp_signup/authentication/auth-details.dart';

class Authentication {

  final _auth = FirebaseAuth.instance;

  Authentication();

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  void signOut() {
    // By signing in as the anonymous user, we automatically sign out as Organizer.
    signInAnonymousUser();
  }

  void signInAnonymousUser() {
    _auth.signInWithEmailAndPassword(email: kAnonymousUserEmail, password: kAnonymousUserPassword);
  }

  void signInUser({required String email, required String password}) {
    _auth.signInWithEmailAndPassword(
        email: kAnonymousUserEmail,
        password: kAnonymousUserPassword
    );
  }

  bool isCurrentUserAnonymous() {
    return _auth.currentUser != null && _auth.currentUser!.email != kAnonymousUserEmail;
  }
}