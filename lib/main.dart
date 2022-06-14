import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/models/homescreen_model.dart';
import 'package:todo/screens/hangman_home.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomescreenModel>(
            create: (context) => HomescreenModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme:
                GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)),
        home: HomeScreen(),
      ),
    );
  }
}
