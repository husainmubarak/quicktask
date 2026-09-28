class TodoModel {
  final String id;
  final String title;
  final bool isCompleted;

  TodoModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  factory TodoModel.fromJson(Map json) {
    return TodoModel(
      id: json['id'] as String, 
      title: json['title'] as String,
      isCompleted: json['is_completed'] as bool,
    );
  }
  
  Map toJson() {
    return {
      'title': title,
      'is_completed': isCompleted,
    };
  }

  TodoModel copyWith({
    String? id,
    String? title,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}