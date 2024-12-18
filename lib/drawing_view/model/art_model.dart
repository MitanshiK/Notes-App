class ArtModal {
  final int? id;
  final String artPath;
  final String artName;
  
  ArtModal({this.id, required this.artPath, required this.artName});

  Map<String, dynamic> toMap() {
    return {'id': id, 'artPath': artPath, 'artName': artName};
  }

  factory ArtModal.fromMap(Map<String, dynamic> map) {
    return ArtModal(
      id: map['id'],
      artPath: map['artPath'],
      artName: map['artName'],
    );
  }
}