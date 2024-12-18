class NotesModal {
  final int? id;
  final String creationTime;
  final String notebookName;
  final String content;

  NotesModal({this.id, required this.creationTime,required this.notebookName, required this.content});

  Map<String, dynamic> toMap() {
    return {'id': id, 'creationTime': creationTime,'notebookName':notebookName, 'content': content};
  }

  factory NotesModal.fromMap(Map<String, dynamic> map) {
    return NotesModal(
      id: map['id'],
      creationTime: map['creationTime'],
      notebookName:map['notebookName'],
      content: map['content'],
    );
  }
}