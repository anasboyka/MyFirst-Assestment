import 'package:flutter/material.dart';

import 'package:map_exam/data/model/note.dart';
import 'package:map_exam/data/remote/firebase/firestore_db.dart';

class NoteProvider with ChangeNotifier {
  String? userUid;
  List<Note> notes;
  bool showContent;
  List<bool> showOptions;
  NoteProvider({
    this.userUid,
    this.notes = const [],
    this.showContent = true,
    this.showOptions = const [],
  });

  Future initialize() async {
    notes = await fetchNotes();
    showOptions = List.filled(notes.length, false);
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

  void toggleContent() {
    showContent = !showContent;
    notifyListeners();
  }

  // void toggleShowOptions(int index) {
  //   showOptions[index] = !showOptions[index];
  //   notifyListeners();
  // }

  void toggleShowOptions(int index) {
    for (var i = 0; i < notes.length; i++) {
      if (i == index) {
        showOptions[i] = !showOptions[i];
      } else {
        showOptions[i] = false;
      }
    }
    notifyListeners();
  }
}
