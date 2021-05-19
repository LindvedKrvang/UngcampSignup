import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ungcamp_signup/authentication/authentication.dart';
import 'package:ungcamp_signup/database/database.dart';
import 'package:ungcamp_signup/models/event.dart';
import 'package:ungcamp_signup/models/routes.dart';
import 'package:ungcamp_signup/screens/sidebar-drawer.dart';
import 'package:ungcamp_signup/widgets/create_event.dart';
import 'package:ungcamp_signup/widgets/event_card.dart';

class OrganizerOverview extends StatefulWidget {
  const OrganizerOverview({Key? key}) : super(key: key);

  @override
  _OrganizerOverviewState createState() => _OrganizerOverviewState();
}

class _OrganizerOverviewState extends State<OrganizerOverview> {

  final _auth = Authentication();
  final _database = Database();

  late StreamSubscription<UcEvent> _eventsSubscription;

  List<UcEvent> _ucEvents = [];

  @override
  void initState() {
    super.initState();
    _eventsSubscription = _database
        .getUcEventAddedStream()
        .listen((event) {
           setState(() {
             _ucEvents.add(event);
           });
        });
  }

  @override
  void dispose() {
    _eventsSubscription.cancel();
    super.dispose();
  }


  void signOutClicked() {
    _auth.signOut();
    Navigator.popAndPushNamed(context, kEventsRoute);
  }

  void _createEvent(UcEvent ucEvent) {
    _database.saveUcEvent(ucEvent);
    setState(() {
      _ucEvents.add(ucEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Ungcamp - Organizer'),
            Expanded(child: Container()),
            ElevatedButton(
              onPressed: () => signOutClicked(),
              child: Text('Sign out'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent[100]
              ),
            ),
          ],
        ),
      ),
      drawer: SidebarDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add
        ),
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => SingleChildScrollView(
              child: CreateEvent(
                organizerId: _auth.getCurrentUser()!.uid,
                onSave: (ucEvent) {
                  _createEvent(ucEvent);
                  Navigator.pop(context);
              }),
            ),
          isDismissible: false,
          enableDrag: false
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10.0,),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return EventCard(event: _ucEvents[index]);
                  },
                  itemCount: _ucEvents.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
