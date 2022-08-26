import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/providers/theme_provider.dart';
import 'package:todos_app/screens/edit_task_screen/edit_task_screen.dart';
import 'package:todos_app/screens/home_screen.dart';
import 'package:todos_app/themes/my_themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      ChangeNotifierProvider(
          create: (context) => AppConfigTheme(),
          child: MyApp()));
}

late AppConfigTheme provider;
void changePref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  provider.changeLang(prefs.getString('appLang')??'en');
  if (prefs.getString('theme') == 'light') {
    provider.changeTheme(ThemeMode.light);
  } else if (prefs.getString('theme') == 'dark') {
    provider.changeTheme(ThemeMode.dark);
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    changePref();
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName:(_)=>HomeScreen(),
        EditTaskScreen.routeName:(_)=>EditTaskScreen()
      },
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.themeMode,
      locale: Locale(provider.locale),
    );
  }
}




