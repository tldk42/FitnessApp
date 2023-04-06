import 'package:fitness_app/components/main_app_screen/tabbed_layout_component.dart';
import 'package:fitness_app/db/login_info_storage.dart';
import 'package:fitness_app/db/user_data_storage.dart';
import 'package:fitness_app/db/user_device_info_storage.dart';
import 'package:fitness_app/providers/live_transactions_provider.dart';
import 'package:fitness_app/providers/tab_navigation_provider.dart';
import 'package:fitness_app/providers/user_login_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fitness_app/screens/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'utilities/make_api_request.dart';

// void main() => runApp(const FitnessApp());

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserLoginStateProvider(),
      ),
      ChangeNotifierProvider(create: (_) => TabNavigationProvider()),
      //   ChangeNotifierProxyProvider<UserLoginStateProvider, LiveTransactionsProvider>(
      //       create: (BuildContext context) => LiveTransactionsProvider(), update: (context, userLoginAuthKey, liveTransactions) =>
      // liveTransactions!..update(userLoginAuthKey)),
    ],
    child: FitnessApp(),
  ));
}

class FitnessApp extends StatefulWidget {
  const FitnessApp({Key? key}) : super(key: key);

  @override
  State<FitnessApp> createState() => _FitnessAppState();
}

class _FitnessAppState extends State<FitnessApp> {
  DeviceInfoStorage deviceInfoStorage = DeviceInfoStorage();
  UserDataStorage userDataStorage = UserDataStorage();
  LoginInfoStorage loginInfoStorage = LoginInfoStorage();
  bool? _previousllyInstalled;
  bool? _isLoggedIn;
  Map<String, dynamic>? _loggedInUserData = {'tldk423': 'lbgs8589--'};

  void _checkForPreviousInstallations() async {
    final previousllyInstalledStatus = await deviceInfoStorage.wasUsedBefore;
    setState(() {
      _previousllyInstalled = previousllyInstalledStatus;
    });
  }

  void _getLoggedInUserData() async {
    final loginData = await loginInfoStorage.getPersistentLoginData;
    final loggedInUserAuthKey = loginData['authToken'];
    final loggedInUserId = loginData['member_id'];
    bool loginStatus = false;

    if (loggedInUserAuthKey == null || loggedInUserId == null) {
      loginStatus = false;
    } else {
      Provider.of<UserLoginStateProvider>(context, listen: false)
          .setAuthKeyValue(loggedInUserAuthKey);
    }
    setState(() {
      _isLoggedIn = loginStatus;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _checkForPreviousInstallations();

    _getLoggedInUserData();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitnessApp',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.manropeTextTheme(Theme.of(context).textTheme),
      ),
      home: Builder(
        builder: (context) {
          if (_previousllyInstalled == true) {
            FlutterNativeSplash.remove();
            return LoginScreen();
          } else {
            FlutterNativeSplash.remove();
            if (_loggedInUserData != null) {
              return TabbedLayoutComponent(userData: _loggedInUserData!);
            }
            return LoginScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<bool> fetchUserId(String authKey, String userId) async {
    final dataReceived = await getData(urlPath: 'user/path', authKey: authKey);
    if (dataReceived.keys.join().toLowerCase().contains("error")) {
      return false;
    } else {
      bool userIsSaved =
          await UserDataStorage().saveUserData(dataReceived['user']);

      if (userIsSaved) {
        //? in case user is valid
        if (mounted) {
          setState(() {
            _loggedInUserData = dataReceived['user'];
          });
        }
      }

      return userIsSaved;
    }
  }
}

// class FitnessApp extends StatelessWidget {
//   const FitnessApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark().copyWith(
//         textTheme: const TextTheme(
//           bodyText1: TextStyle(color: Colors.black54),
//         ),
//       ),
//       home: const TabbedLayoutComponent(
//         userData: {"empty": "empty"},
//       ),
//       // initialRoute: ActivityScreen.id ,
//       // routes: {
//       //   ActivityScreen.id: (context) => const ActivityScreen(),
//       //   LoginScreen.id: (context) => const LoginScreen(),
//       //   RegistrationScreen.id: (context) => const RegistrationScreen(),
//       //   ChatScreen.id: (context) => const ChatScreen()
//       // },
//     );
//   }
// }
