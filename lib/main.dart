import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_imp/view/login_screen.dart';
import 'package:technical_imp/viewmodel/provider/auth_provider.dart';
import 'package:technical_imp/viewmodel/provider/create_faq_provider.dart';
import 'package:technical_imp/viewmodel/provider/delete_faq_provider.dart';
import 'package:technical_imp/viewmodel/provider/detail_faq_provider.dart';
import 'package:technical_imp/viewmodel/provider/list_faq_provider.dart';
import 'package:technical_imp/viewmodel/provider/update_faq_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ListFaqProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailFaqProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UpdateFaqProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateFaqProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DeleteFaqProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'IMP Technical',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoginScreen()),
    );
  }
}
