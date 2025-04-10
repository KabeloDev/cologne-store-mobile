import 'package:cologne_store_mobile_app/Pages/splash_screen.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only initialize Firebase if it hasn't been initialized already
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "",
        appId: "1:643912346356:android:c855afb900a259c9588ca1",
        messagingSenderId: "643912346356",
        projectId: "cologne-store",
      ),
    );
  } catch (e) {
    print('Firebase already initialized');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmailProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}
