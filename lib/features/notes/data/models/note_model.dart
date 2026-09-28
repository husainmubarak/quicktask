class NoteModel {
  final String id;
  final String title;
  final String content;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
  });

  factory NoteModel.fromJson(Map json) {
    return NoteModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }

  Map toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}