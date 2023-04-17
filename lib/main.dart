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
        ChangeNotifierProvider(create: (context) => SettingsService()),
        ChangeNotifierProvider(create: (context) => CreateBucketService())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.system,
        initialRoute: isUserCreated ? HOME : ONBOARDING,
        routes: routes,
      ),
    );
  }
}