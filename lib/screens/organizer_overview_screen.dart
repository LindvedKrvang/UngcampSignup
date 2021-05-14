import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungcamp_signup/models/auth-details.dart';
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
  List<Event> _events = [
    Event(
      organizerId: 'someId',
      title: 'Retfærdiggørelse / Helliggørelse',
      type: 'Morgenmøde',
      description: 'Dette møde handler om forskellen på retfærdiggørelse og helliggørelse',
      author: 'Daniel Præstholm',
      atDate: '12/05',
      atTime: '10:00',
      maxParticipants: 500
    )
  ];

  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

  void signOutAsOrganizer() {
    // By signing in as the anonymous user, we automatically sign out as Organizer.
    _auth.signInWithEmailAndPassword(email: kAnonymousUserEmail, password: kAnonymousUserPassword);
    Navigator.popAndPushNamed(context, kEventsRoute);
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
                onSave: (event) {
                  setState(() {
                    _events.add(event);
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
                    return EventCard(event: _events[index]);
                  },
                  itemCount: _events.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
