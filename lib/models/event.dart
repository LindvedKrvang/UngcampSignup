class UcEvent {

  final String key;
  late String organizerId;
  late String title;
  late String type;
  late String description;
  late String author;
  late String atTime;
  late String atDate;
  late int maxParticipants;

  UcEvent({
    required this.key,
    required this.organizerId,
    required this.title,
    required this.type,
    required this.description,
    required this.author,
    required this.atTime,
    required this.atDate,
    required this.maxParticipants
  });

  UcEvent.fromJson(this.key, Map data) {
    organizerId = data['organizerId'];
    title = data['title'];
    type = data['type'];
    description = data['description'];
    author = data['author'];
    atTime = data['atTime'];
    atDate = data['atDate'];
    maxParticipants = data['maxParticipants'];
  }
}