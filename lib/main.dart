import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mammocare/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // Handle background message here
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Handle Firebase initialization errors
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (error) {
    // Handle error, e.g., log the error, display an error message to the user
    print('Firebase initialization error: $error');
  }

  // Set the background messaging handler early in the initialization process
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late FirebaseMessaging _messaging;

  @override
  void initState() {
    super.initState();
    _messaging = FirebaseMessaging.instance;
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Request notification permission
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    // Get FCM token (check if _messaging is not null)
    String? token = await _messaging.getToken();
    print('FCM Token: $token'); // Send this token to your backend server

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      // Handle message here
    });

    // Remove the splash screen after initialization
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
