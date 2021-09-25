import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safetynetlk/Screens/auth.dart';
import 'package:provider/provider.dart';
import 'package:safetynetlk/providers/user_model_provider.dart';

import 'models/user_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel>(
            create: (context) => UserModelProvider().userModel,
            initialData: UserModelProvider.emptyUserModel())
      ],
      child: MaterialApp(
          theme: _buildDarkTheme(),
          home: Scaffold(
            body: Builder(
                builder: (context) => Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColorLight
                          ])),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        //Sets the main padding all widgets has to adhere to.
                        child: Login(),
                      ),
                    )),
          )),
    );
  }
}

ThemeData _buildDarkTheme() {
  final baseTheme = ThemeData(
    fontFamily: "Open Sans",
  );
  return baseTheme.copyWith(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF143642),
    primaryColorLight: const Color(0xFF26667d),
    primaryColorDark: const Color(0xFF08161b),
    primaryColorBrightness: Brightness.dark,
  );
}
