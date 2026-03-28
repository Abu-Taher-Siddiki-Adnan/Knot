import 'package:flutter/material.dart';
import 'package:knot/models/note_model.dart';
import 'package:knot/screens/add_note/add_note_screen.dart';
import 'package:knot/screens/auth/forgot_password_screen.dart';
import 'package:knot/screens/auth/login_screen.dart';
import 'package:knot/screens/auth/register_screen.dart';
import 'package:knot/screens/home/home_screen.dart';
import 'package:knot/screens/splash/splash_screen.dart';
import 'package:knot/screens/update_note/update_note_screen.dart';

import '../screens/settings/edit_profile_screen.dart';
import '../screens/settings/account_screen.dart';

class RouteHelper {
  static String initial = '/';
  static String login = '/login';
  static String register = '/register';
  static const String forgotPassword = '/forgotPassword';
  static String home ='/home';
  static String newNote = '/newNote';
  static const String updateNote = '/updateNote';
  static const String account        = '/account';
  static const String editProfile    = '/editProfile';


  static Map<String, WidgetBuilder> routes() => {
    initial: (context) => SplashScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    home: (context) => HomeScreen(),
    newNote: (context) => AddNoteScreen(),
    account:     (context) => AccountScreen(),
    editProfile: (context) => EditProfileScreen(),
  };

  static onGenerateRoutes(RouteSettings settings){
    switch(settings.name){
      case updateNote:{
        NoteModel note = settings.arguments as NoteModel;
        return MaterialPageRoute(
            builder: (context)=> UpdateNoteScreen(note: note)
        );
      }
      case forgotPassword:{
        String email = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => ForgotPasswordScreen(email: email)
        );
      }
    }
  }
}
