import 'package:flutter/material.dart';
import 'package:ungcamp_signup/models/routes.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({Key key}) : super(key: key);

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

  SidebarButton({@required this.title, @required this.navigateToRoute});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
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
            context, navigateToRoute,
            ModalRoute.withName(kHomeRoute)
        )
      ),
    );
  }
}