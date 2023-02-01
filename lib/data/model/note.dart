class Note {
  final dynamic id;
  String? title;
  String? content;
  DateTime? dateCreated;

  Note({
    this.id = 0,
    this.title = '',
    this.content = '',
    this.dateCreated,
  });

  Note.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          content: json['content'],
          dateCreated: json['dateCreated']?.toDate(),
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'dateCreated': dateCreated
      };
}
