import 'package:flutter/material.dart';
import 'package:ungcamp_signup/screens/sidebar-drawer.dart';

class MyTickets extends StatelessWidget {
  const MyTickets({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ungcamp - My tickets'),
      ),
      drawer: SidebarDrawer(),
    );
  }
}
