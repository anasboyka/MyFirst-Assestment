import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final dynamic id;
  String? title;
  String? content;
  DateTime? dateCreated;
  bool showOption;
  DocumentSnapshot? snapshot;
  DocumentReference? reference;
  String? documentID;

  Note({
    this.id = 0,
    this.title = '',
    this.content = '',
    this.dateCreated,
    this.showOption = false,
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

  Note copyWith({
    dynamic id,
    String? title,
    String? content,
    DateTime? dateCreated,
    bool? showOption,
    DocumentSnapshot? snapshot,
    DocumentReference? reference,
    String? documentID,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      dateCreated: dateCreated ?? this.dateCreated,
      showOption: showOption ?? this.showOption,
      snapshot: snapshot ?? this.snapshot,
      reference: reference ?? this.reference,
      documentID: documentID ?? this.documentID,
    );
  }
}
