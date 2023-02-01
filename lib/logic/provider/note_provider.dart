import 'package:flutter/material.dart';

import 'package:map_exam/data/model/note.dart';
import 'package:map_exam/data/remote/firebase/firestore_db.dart';

class NoteProvider with ChangeNotifier {
  String? userUid;
  List<Note> notes;
  bool showContent;
  bool showOptions;
  NoteProvider({
    this.userUid,
    this.notes = const [],
    this.showContent = true,
    this.showOptions = false,
  });

  Future initialize() async {
    notes = await fetchNotes();
    notifyListeners();
  }

  Future<List<Note>> fetchNotes() async {
    try {
      return await FirestoreDb(uid: userUid).getCurrentUserNotes();
    } on Exception catch (e) {
      print(e);
      // TODO
      return [];
    }
  }
}
