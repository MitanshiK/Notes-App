class NotebookModal {
  final int? id;
  final String background;
  final String title;
  
  NotebookModal({this.id, required this.background, required this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'background': background, 'title': title};
  }

  factory NotebookModal.fromMap(Map<String, dynamic> map) {
    return NotebookModal(
      id: map['id'],
      background: map['background'],
      title: map['title'],
    );
  }
}