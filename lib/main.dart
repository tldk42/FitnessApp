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
  Map<String, dynamic>? _loggedInUserData;

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

  Map<int, Color> customColorSwatch = {
    50: Color(0xFFFCECF8),
    100: Color(0xFFF8CEE2),
    200: Color(0xFFF4ADCC),
    300: Color(0xFFF08DB6),
    400: Color(0xFFEC6DA0),
    500: Color(0xFFE84E8A),
    600: Color(0xFFE42E74),
    700: Color(0xFFE00E5E),
    800: Color(0xFFDC0048),
    900: Color(0xFFd80032),
  };


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitnessApp',
      theme: ThemeData(
        primaryColor: Color(0xFF393239),
        primarySwatch: MaterialColor(0xfff975c4, customColorSwatch),
        textTheme: GoogleFonts.manropeTextTheme(Theme.of(context).textTheme),
      ),
      home: Builder(
        builder: (context) {
          if (_previousllyInstalled == false) {
            FlutterNativeSplash.remove();
            return LoginScreen();
          } else {
            FlutterNativeSplash.remove();
            if (_loggedInUserData != null) {
              print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
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
