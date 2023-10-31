class Note {
  int? id; // Make 'id' nullable
  String title;
  String content;

  Note({this.id, required this.title, required this.content});

  // Add more fields for formatting options if needed

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}
