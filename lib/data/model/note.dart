import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final dynamic id;
  String? title;
  String? content;
  DateTime? dateCreated;
  DocumentSnapshot? snapshot;
  DocumentReference? reference;
  String? documentID;

  Note({
    this.id = 0,
    this.title = '',
    this.content = '',
    this.dateCreated,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  Note.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          content: json['content'],
          dateCreated: json['dateCreated']?.toDate(),
        );

  factory Note.fromFirestore(DocumentSnapshot snapshot) {
    dynamic map = snapshot.data() as Map<String, dynamic>;
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      dateCreated: map['dateCreated']?.toDate(),
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'dateCreated': dateCreated
      };
}
