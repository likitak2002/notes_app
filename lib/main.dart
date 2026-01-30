import 'package:database_wscube/db_helper.dart';
import 'package:database_wscube/home_page.dart';
import 'package:database_wscube/provider.dart';
import 'package:database_wscube/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DBProvider(dbHelper: DBHelper.getInstance),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: context.watch<ThemeProvider>().getValue()
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData.dark(
        // colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // home: HomePage(),
    );
  }
}
