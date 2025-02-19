import 'package:flutter/material.dart';
import 'package:new_project/provider/register_provider.dart';
import 'package:new_project/ui/auth/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
