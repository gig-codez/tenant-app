// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import '/tools/Reload.dart';
import 'Observers/IntervalObserver.dart';
import 'exports/exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [],
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('android12splash');
  // iOS settings
  // initialize the plugin. app_icon needs to be a added as a drawable resource to the Android head project

  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  // initialization settings for both Android and iOS
  InitializationSettings initializationSettings = const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin);

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {});

  Bloc.observer = const Observer();
  runApp(
    ReloadApp(
      child: MultiBlocProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MainController()),
          ChangeNotifierProvider(create: (_) => LoaderController()),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.splash,
            theme: ThemeData().copyWith(
              primaryColor: Colors.orange.shade500,
              colorScheme:
                  ColorScheme.fromSeed(seedColor: Colors.orange.shade300),
              useMaterial3: true,
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                      .apply(
                bodyColor: ThemeData().brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                displayColor: ThemeData().brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            routes: Routes.routes,
          );
        }),
      ),
    ),
  );
}
