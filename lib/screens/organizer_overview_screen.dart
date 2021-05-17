import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ungcamp_signup/models/auth-details.dart';
import 'package:ungcamp_signup/models/database_constants.dart';
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

  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance.reference();

  late StreamSubscription<Event> _eventsSubscription;

  List<UcEvent> _ucEvents = [];

  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
    _eventsSubscription = _database
        .child(kEventsKey)
        .onChildAdded
        .listen((event) {
          print(event.snapshot.value);
           setState(() {
             _ucEvents.add(UcEvent.fromJson(event.snapshot.key, event.snapshot.value));
           });
        });
  }

  @override
  void dispose() {
    _eventsSubscription.cancel();
    super.dispose();
  }


  void signOutAsOrganizer() {
    // By signing in as the anonymous user, we automatically sign out as Organizer.
    _auth.signInWithEmailAndPassword(email: kAnonymousUserEmail, password: kAnonymousUserPassword);
    Navigator.popAndPushNamed(context, kEventsRoute);
  }

  void _createEvent(UcEvent ucEvent) {
    _database.reference().child(kEventsKey).push().set({
    'organizerId': ucEvent.organizerId,
    'title': ucEvent.title,
    'type': ucEvent.type,
    'description': ucEvent.description,
    'author': ucEvent.author,
    'atTime': ucEvent.atTime,
    'atDate': ucEvent.atDate,
    'maxParticipants': ucEvent.maxParticipants
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
              onPressed: () => signOutAsOrganizer(),
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
                organizerId: _currentUser!.uid,
                onSave: (ucEvent) {
                  _createEvent(ucEvent);
                  setState(() {
                    _ucEvents.add(ucEvent);
                  });
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
