import 'package:nyumbayo_app/helpers/session_manager.dart';

import '/exports/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    BlocProvider.of<UserAccountController>(context).getUserData();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      BlocProvider.of<UserAccountController>(context).getUserData();
      checkUserSession();
    });
    super.initState();
  }

  void checkUserSession() async {
    bool userSession = await SessionManager().isTokenExpired();
    InternetConnectionChecker.createInstance().hasConnection.then((value) {
      if (value == false) {
        Routes.routeUntil(context, Routes.offline);
      } else {
        if (userSession) {
          Routes.routeUntil(context, Routes.login);
        } else {
          Routes.routeUntil(context, Routes.dashboard);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserAccountController>(context).getUserData();

    return FutureBuilder(
      future: SessionManager().isTokenExpired(),
      builder: (context, s) {
        return // s.connectionState == ConnectionState.waiting
            Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1.8,
                  child: Image.asset("assets/images/house.png"),
                ),
                const Space(space: 0.05),
                SpinKitDualRing(color: Theme.of(context).primaryColor),
                const Space(space: 0.05),
                Text(
                  s.data ?? false
                      ? "Loading user authentication"
                      : "Loading user session",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
