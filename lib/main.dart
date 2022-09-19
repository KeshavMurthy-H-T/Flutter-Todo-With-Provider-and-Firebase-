import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/LoginController.dart';
import 'package:todo/controller/TaskController.dart';
import 'package:todo/pages/SplashPage.dart';
import 'package:todo/service/auth.dart';
import 'package:todo/utils/ColorConstants.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LoginController()),
    ChangeNotifierProvider(create: (context) => TaskController()),
    Provider(create: (context) => AuthMethods(FirebaseAuth.instance)),
    StreamProvider(
        create: (context) => context.read<AuthMethods>().authState,
        initialData: null)
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo Task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: primaryColor, 
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: accentColor)),
        home: const SplashPage());
  }
}
