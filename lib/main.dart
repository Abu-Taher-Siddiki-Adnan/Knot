import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:knot/provider/auth/my_auth_provider.dart';
import 'package:knot/provider/notes/notes_provider.dart';
import 'package:knot/utils/app_theme.dart';
import 'package:knot/utils/route_helper.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final navigatorKey = GlobalKey<NavigatorState>();

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=> MyAuthProvider(), lazy : false),
          ChangeNotifierProvider(create: (context)=> NotesProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routes: RouteHelper.routes(),
          onGenerateRoute: (settings)=> RouteHelper.onGenerateRoutes(settings),
          scaffoldMessengerKey: scaffoldMessengerKey,
          navigatorKey: navigatorKey,
        )
    );
  }
}
