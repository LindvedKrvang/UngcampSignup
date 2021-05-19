import 'package:firebase_database/firebase_database.dart';
import 'package:ungcamp_signup/models/event.dart';

const _eventsKey = 'Events';

class Database {

  final _database = FirebaseDatabase.instance.reference();

  void saveUcEvent(UcEvent ucEvent) {
    _database.child(_eventsKey).push().set({
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

  Stream<UcEvent> getUcEventAddedStream() {
    return _database
      .child(_eventsKey)
      .onChildAdded
      .map((event) => UcEvent.fromJson(event.snapshot.key, event.snapshot.value));
  }
}