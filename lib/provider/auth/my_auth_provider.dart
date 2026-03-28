import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knot/main.dart';
import 'package:knot/models/user_model.dart';
import 'package:knot/utils/route_helper.dart';
import 'package:knot/utils/show_messages.dart';

class MyAuthProvider with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  bool loading = false;
  UserModel? currentUser;

  MyAuthProvider() {
    nextScreen();
  }

  void nextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    if (auth.currentUser == null) {
      Navigator.pushReplacementNamed(
          navigatorKey.currentContext!, RouteHelper.login);
    } else {
      await _loadUser();
      Navigator.pushReplacementNamed(
          navigatorKey.currentContext!, RouteHelper.home);
    }
  }

  Future<void> _loadUser() async {
    try {
      final uid = auth.currentUser?.uid;
      if (uid == null) return;

      final doc = await db.collection('users').doc(uid).get();

      if (doc.exists && doc.data() != null) {
        currentUser = UserModel.fromMap(doc.data()!);
        notifyListeners();
      }
    } catch (e) {
      showMsg(e.toString());
    }
  }

  void login(String email, String password) async {
    _loading(true);
    try {
      await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      await _loadUser();

      Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!, RouteHelper.home, (value) => false);
    } on FirebaseAuthException catch (e) {
      showMsg(e.message);
    } catch (e) {
      showMsg(e.toString());
    } finally {
      _loading(false);
    }
  }

  void register(String name, String email, String password) async {
    _loading(true);
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      UserModel user = UserModel(
        result.user!.uid,
        name,
        email,
        DateTime.now(),
      );

      await db.collection('users').doc(result.user!.uid).set(user.toMap());

      currentUser = user;
      notifyListeners();

      Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!, RouteHelper.home, (value) => false);
    } on FirebaseAuthException catch (e) {
      showMsg(e.message);
    } catch (e) {
      showMsg(e.toString());
    } finally {
      _loading(false);
    }
  }

  void forgotPassword(String email) async {
    _loading(true);
    try {
      await auth.sendPasswordResetEmail(email: email.trim());
      showMsg('Password reset email sent', false);
      Navigator.pop(navigatorKey.currentContext!);
    } on FirebaseAuthException catch (e) {
      showMsg(e.message);
    } catch (e) {
      showMsg(e.toString());
    } finally {
      _loading(false);
    }
  }

  void updateName(String name) async {
    _loading(true);
    try {
      final uid = auth.currentUser?.uid;
      if (uid == null) {
        showMsg('Not logged in');
        return;
      }

      await db.collection('users').doc(uid).update({'name': name});

      currentUser = UserModel(
        currentUser!.id,
        name,
        currentUser!.email,
        currentUser!.createdAt,
      );
      notifyListeners();

      showMsg('Profile updated', false);
      Navigator.pop(navigatorKey.currentContext!);
    } catch (e) {
      showMsg(e.toString());
    } finally {
      _loading(false);
    }
  }

  void logout() async {
    _loading(true);
    try {
      await auth.signOut();
      currentUser = null;
      Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!, RouteHelper.login, (value) => false);
    } on FirebaseAuthException catch (e) {
      showMsg(e.message);
    } catch (e) {
      showMsg(e.toString());
    } finally {
      _loading(false);
    }
  }

  Future<void> reloadUser() async {
    await _loadUser();
  }

  _loading(bool value) {
    loading = value;
    notifyListeners();
  }
}