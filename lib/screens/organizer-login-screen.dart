import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ungcamp_signup/models/auth-details.dart';
import 'package:ungcamp_signup/models/routes.dart';
import 'package:ungcamp_signup/screens/sidebar-drawer.dart';

class OrganizerLogin extends StatefulWidget {
  const OrganizerLogin({Key key}) : super(key: key);

  @override
  _OrganizerLoginState createState() => _OrganizerLoginState();
}

class _OrganizerLoginState extends State<OrganizerLogin> {

  final _auth = FirebaseAuth.instance;

  User _currentUser;
  bool _isCurrentUserOrganizer = false;

  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
    _isCurrentUserOrganizer = _currentUser != null && _currentUser.email != kAnonymousUserEmail;
  }

  void loginAsOrganizer() {
    try {
      _auth.signInWithEmailAndPassword(email: _email, password: _password);
      _isCurrentUserOrganizer = true;
      Navigator.popAndPushNamed(context, kEventsRoute);
    } catch (error) {
      // TODO: Add proper error handling for logging in
      print('Error happened while logging in');
      print(error);
    }
  }

  void signOutAsOrganizer() {
    // By signing in as the anonymous user, we automatically sign out as Organizer.
    _auth.signInWithEmailAndPassword(email: kAnonymousUserEmail, password: kAnonymousUserPassword);
    _isCurrentUserOrganizer = false;
    Navigator.popAndPushNamed(context, kEventsRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ungcamp - Organizer'),
      ),
      drawer: SidebarDrawer(),
      body: Center(
        child: Column(
          children:[
            Visibility(
              visible: !_isCurrentUserOrganizer,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('This is for Organizers only'),
                  Text('If you are an Organizer, please login'),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => this._email = value,
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) => this._password = value,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () => loginAsOrganizer(),
                    child: Text('Log in'),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isCurrentUserOrganizer,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('You are already an Organizer'),
                  Text('Want to log out?'),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () => signOutAsOrganizer(),
                    child: Text('Sign out'),
                  ),
                ],
              )
            ),
          ]
        ),
      ),
    );
  }

}

