import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ungcamp_signup/authentication/authentication.dart';
import 'package:ungcamp_signup/models/routes.dart';
import 'package:ungcamp_signup/screens/sidebar-drawer.dart';

class OrganizerLogin extends StatefulWidget {
  const OrganizerLogin({Key? key}) : super(key: key);

  @override
  _OrganizerLoginState createState() => _OrganizerLoginState();
}

class _OrganizerLoginState extends State<OrganizerLogin> {

  final _auth = Authentication();

  late String _email;
  late String _password;

  @override
  void initState() {
    super.initState();
  }

  void loginAsOrganizer() {
    try {
      _auth.signInUser(email: _email, password: _password);
      Navigator.popAndPushNamed(context, kOrganizerOverviewRoute);
    } catch (error) {
      // TODO: Add proper error handling for logging in
      print('Error happened while logging in');
      print(error);
    }
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
            Column(
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
          ]
        ),
      ),
    );
  }
}

