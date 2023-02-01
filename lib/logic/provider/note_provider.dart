import 'package:flutter/material.dart';

import 'package:map_exam/data/model/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note>? notes;
  bool showContent;
  bool showOptions;
  NoteProvider({
    this.notes,
    this.showContent = false,
    this.showOptions = false,
  });
}
