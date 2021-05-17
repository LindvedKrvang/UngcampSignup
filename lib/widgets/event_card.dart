import 'package:flutter/material.dart';
import 'package:ungcamp_signup/models/event.dart';

class EventCard extends StatelessWidget {

  final UcEvent event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: ListTile(
        leading: Icon(
          Icons.event,
          size: 40.0,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${event.type} d. ${event.atDate} kl. ${event.atTime}'),
            Text(event.title),
          ],
        ),
        subtitle: Text('v/ ${event.author} - ${event.maxParticipants} pladser'),
        isThreeLine: true,
      ),
    );
  }
}
