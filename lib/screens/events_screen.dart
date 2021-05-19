import 'package:flutter/material.dart';
import 'package:ungcamp_signup/authentication/authentication.dart';
import 'package:ungcamp_signup/screens/sidebar-drawer.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {

  final _auth = Authentication();

  @override
  void initState() {
    super.initState();
    var currentUser = _auth.getCurrentUser();
    if (currentUser == null) {
      _auth.signInAnonymousUser();
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
