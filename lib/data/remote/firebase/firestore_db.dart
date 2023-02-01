import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_exam/data/model/note.dart';

class FirestoreDb {
  final String? uid;
  FirestoreDb({
    this.uid,
  });

  final CollectionReference noteCollection =
      FirebaseFirestore.instance.collection('notes');

  Future<List<Note>> getCurrentUserNotes() async {
    return await noteCollection
        .where('id', isEqualTo: uid)
        .orderBy('dateCreated')
        .get()
        .then(_noteFromSnapshot);
  }

  List<Note> _noteFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Note.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
