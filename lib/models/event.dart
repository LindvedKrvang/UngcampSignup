class Event {

  final String organizerId;
  String title;
  String type;
  String description;
  String author;
  String atTime;
  String atDate;
  int maxParticipants;

  Event({
    required this.organizerId,
    required this.title,
    required this.type,
    required this.description,
    required this.author,
    required this.atTime,
    required this.atDate,
    required this.maxParticipants
  });
}