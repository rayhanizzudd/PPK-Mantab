import 'package:first/screens/profile/screen/halamanprofile.dart';
import 'package:first/screens/homepage/views/homepage.dart';
import 'package:first/screens/informasi/screen/maininformation.dart';
import 'package:first/screens/penjadwalan/screen/penjadwalan.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/welcome/views/logreg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCx0JlWLE8mPh1jixILU0BfDeoKJ9gurrs',
    appId: '1:249132826909:android:54776866e54ed3435321f4',
    messagingSenderId: '249132826909',
    projectId: 'mantab-8e9eb',
    storageBucket: 'mantab-8e9eb.appspot.com',
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogRegPage(),
      initialRoute: '/',
      routes: {
        '/home': (context) => Homepage(), 
        '/schedule': (context) => Penjadwalan(),
        '/information': (context) => InformationPage(),
        '/profile': (context) =>
            HalamanProfile(), 
      },
    );
    
  }
}
