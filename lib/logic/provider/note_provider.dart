import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:map_exam/data/model/note.dart';
import 'package:map_exam/data/remote/firebase/firestore_db.dart';

class NoteProvider with ChangeNotifier {
  String? userUid;
  List<Note> notes;
  bool showContent;
  // List<bool> showOptions;
  String mode;
  NoteProvider({
    this.userUid,
    this.notes = const [],
    this.showContent = true,
    // this.showOptions = const [],
    this.mode = '',
  });

  Future initialize() async {
    notes = await fetchNotes();
    // showOptions = List.filled(notes.length, false);
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

  void toggleShowOptions(int index) {
    for (var i = 0; i < notes.length; i++) {
      if (i == index) {
        notes[i].showOption = !notes[i].showOption;
      } else {
        notes[i].showOption = false;
      }
    }
    notifyListeners();
  }

  Future deleteNote(int index) async {
    try {
      await FirestoreDb().deleteNote(notes[index].documentID!);
      // notes = await fetchNotes();
      notes.removeWhere(
          (element) => element.documentID == notes[index].documentID);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future addNote(Note note) async {
    try {
      DocumentReference docref = await FirestoreDb().addNote(note);
      notes.add(note.copyWith(documentID: docref.id));
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future updateNote(Note note) async {
    try {
      await FirestoreDb().updateNote(note);
      int index =
          notes.indexWhere((element) => element.documentID == note.documentID);
      notes[index] = note;
    } on Exception catch (e) {
      print(e);
      // TODO
    }
    notifyListeners();
  }

  void setMode(String mode) {
    this.mode = mode;
  }

  // String getAppbarTitle() {
  //   if (mode == 'View') {
  //     return 'View Note';
  //   } else if (mode == 'Edit') {
  //     return 'Edit Note';
  //   } else {
  //     return 'Add Note';
  //   }
  // }

  Future refreshData() async {}
}
