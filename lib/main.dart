import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lakukan/theme/style.dart';
import 'pages/intro.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FocusManager.instance.primaryFocus?.unfocus();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //top status bar
        systemNavigationBarColor: Colors.transparent, // navigation bar color, the one Im looking for
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icons' color
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kidvera',
        theme: ThemeData(
          primarySwatch: Colors.blue,
            colorScheme: Theme.of(context).colorScheme.copyWith(
               outline: AppColor.primary,
              primary: AppColor.primary
            )
        ),
        home: const IntroPage(),
      ),
    );
  }
}
