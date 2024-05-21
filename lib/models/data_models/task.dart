class Task {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  const Task({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      todo: json['todo'] as String,
      completed: json['completed'] as bool,
      userId: json['userId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  Task copyWith({
    int? id,
    String? todo,
    bool? completed,
    int? userId,
  }) {
    return Task(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }
}
