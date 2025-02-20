import 'package:flutter/material.dart';
import 'package:demo_project/provider/register_provider.dart';
import 'package:demo_project/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
      ],
      child: MaterialApp(
        title: "New App",
        home: MyLoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
