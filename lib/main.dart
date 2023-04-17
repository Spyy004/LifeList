import 'package:flutter/material.dart';
import 'package:lifelist/constants/index.dart';
import 'package:lifelist/services/index.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appVersion = packageInfo.version;
  dbService = DBService();
  await dbService.initIsar();
  isUserCreated = await dbService.isUserCreated();
  runApp(const LifeList());
}

class LifeList extends StatelessWidget {
  const LifeList({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OnboardingService>(
            create: (context) => OnboardingService()),
        ChangeNotifierProvider<UserService>(create: (context) => UserService()),
        ChangeNotifierProvider(create: (context) => BucketService()),
        ChangeNotifierProvider(create: (context) => TaskService()),
        ChangeNotifierProvider(create: (context) => BucketListService()),
        ChangeNotifierProvider(create: (context) => SettingsService())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme,
        theme: theme: ThemeData(
          primaryColor: Colors.blueGrey[900], // sets the primary color of the app
          accentColor: Colors.blue, // sets the accent color of the app
          scaffoldBackgroundColor: Colors.grey[200], // sets the background color of the app
          backgroundColor: Colors.grey[100], // sets the color of the app's canvas
          cardColor: Colors.white, // sets the color of the card widgets
          textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 16.0, color: Colors.black), // sets the text style of the body text
            bodyText2: TextStyle(fontSize: 14.0, color: Colors.black54), // sets the text style of the secondary body text
            headline6: TextStyle(fontSize: 20.0, color: Colors.blueGrey[900]), // sets the text style of the app bar title
          ),
        ),
        themeMode: ThemeMode.system,
        initialRoute: isUserCreated ? HOME : ONBOARDING,
        routes: routes,
      ),
    );
  }
}
