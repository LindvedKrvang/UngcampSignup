import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungcamp_signup/models/auth-details.dart';
import 'package:ungcamp_signup/screens/sidebar-drawer.dart';

class Events extends StatefulWidget {
  const Events({Key key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    var currentUser = _auth.currentUser;
    if (currentUser == null) {
      _auth.signInWithEmailAndPassword(
          email: kAnonymousUserEmail,
          password: kAnonymousUserPassword
      );
      print(_auth.currentUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ungcamp - Events overview'),
      ),
      drawer: SidebarDrawer(),
    );
  }
}
