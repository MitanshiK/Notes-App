class TodoModal{
  final int? id;
  final String? content;
  final String? done;

  TodoModal({this.id, required this.content,this.done});

  Map<String, dynamic> toMap() {
    return {'id': id, 'content': content, 'done': done};
  }

  factory TodoModal.fromMap(Map<String, dynamic> map) {
    return TodoModal(
      id: map['id'],
      content: map['content'],
      done: map['done'],
    );
  }
}