import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knot/main.dart';
import 'package:knot/models/note_model.dart';
import 'package:knot/utils/show_messages.dart';

class NotesProvider with ChangeNotifier {
  List<NoteModel> notes = [];
  bool loading = false;

  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void getNotes() async{
    notes.clear();
    _loading(true);
    try{
      final result = await db.collection('notes')
          .where('user_id',isEqualTo: auth.currentUser!.uid)
          .get();
      for(var doc in result.docs){
        NoteModel note = NoteModel.fromMap(doc.data());
        notes.add(note);
      }
      notifyListeners();
    }on FirebaseException catch(e){
      showMsg(e.message);
    }catch(e){
      showMsg(e.toString());
    }finally{
      _loading(false);
    }
  }

  void addNote(String title, String desc) async{
    _loading(true);
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    try{
      NoteModel note = NoteModel(
          id,
          auth.currentUser!.uid,
          title,
          desc,
          DateTime.now()
      );

      await db.collection('notes').doc(id).set(note.toMap());

      getNotes();

      Navigator.pop(navigatorKey.currentContext!);

    }on FirebaseException catch(e){
      showMsg(e.message);
    } catch(e){
      showMsg(e.toString());
    }finally{
      _loading(false);
    }
  }

  void updateNote(String title, String desc, String noteId) async{
    _loading(true);
    try{
      await db.collection('notes').doc(noteId).update({
        'title': title,
        'desc': desc
      });
      getNotes();
      Navigator.pop(navigatorKey.currentContext!);
    }on FirebaseException catch(e){
      showMsg(e.message);
    } catch(e){
      showMsg(e.toString());
    }finally{
      _loading(false);
    }
  }

  void deleteNote(NoteModel note) async {
    _loading(true);
    try {
      await db.collection('notes').doc(note.id).delete();
      getNotes();
    } on FirebaseException catch (e) {
      showMsg(e.message);
    } catch (e) {
      showMsg(e.toString());
    } finally {
      _loading(false);
    }
  }


  _loading(bool value){
    loading = value;
    notifyListeners();
  }
}
