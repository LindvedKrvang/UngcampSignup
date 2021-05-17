import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungcamp_signup/models/auth-details.dart';
import 'package:ungcamp_signup/models/routes.dart';

class SidebarDrawer extends StatelessWidget {
  SidebarDrawer({Key? key}) : super(key: key);

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SidebarButton(
              title: 'Events',
              navigateToRoute: kEventsRoute,
            ),
            SidebarButton(
              title: 'My Tickets',
              navigateToRoute: kMyTicketsRoute,
            ),
            Expanded(
              child: Container(),
            ),
            SidebarButton(
              title: 'For organizers',
              navigateToRoute: kOrganizerLoginRoute,
              navigateToSecondRoute: kOrganizerOverviewRoute,
              shouldNavigateToSecondRoute: _auth.currentUser != null && _auth.currentUser!.email != kAnonymousUserEmail,
            )
          ],
        ),
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {

  final String title;
  final String navigateToRoute;
  final String? navigateToSecondRoute;
  final bool? shouldNavigateToSecondRoute;

  SidebarButton({
    required this.title,
    required this.navigateToRoute,
    this.navigateToSecondRoute,
    this.shouldNavigateToSecondRoute
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[600],
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1.0
          )
        ],
      ),
      child: TextButton(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context, shouldNavigateToSecondRoute != null && shouldNavigateToSecondRoute!
              ? navigateToSecondRoute!
              : navigateToRoute,
            ModalRoute.withName(kHomeRoute)
        )
      ),
    );
  }
}