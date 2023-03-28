import 'package:fitness_app/db/login_info_storage.dart';
import 'package:fitness_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

Future<bool> _deleteLoggedInUserData() async {
  List<bool> deletionStatus =
      await Future.wait([LoginInfoStorage().deleteFile()]);
  return deletionStatus.first && deletionStatus.last;
}

void showErrorAlert(BuildContext context, Map<String, dynamic> error) {
  Map<String, dynamic> errorTypes = {
    'error': _CommonError(context, error),
    'internetConnectionError': _LocalError(context, error),
    'localDBError': _LocalError(context, error),
    'authenticationError': _CommonError(context, error),
    'apiAuthorizationError': _HazardousError(context, error),
    'corruptedTokenError': _HazardousError(context, error)
  };
  String currentError = error.keys.first;

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text(
              "Error",
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: errorTypes[currentError].errorDescription,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Container(
                height: 48,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blueGrey.shade100,
                        offset: const Offset(0, 4),
                        blurRadius: 5.0)
                  ],
                  gradient: const RadialGradient(
                      colors: [Color(0xff0070BA), Color(0xff1546A0)],
                      radius: 8.4,
                      center: Alignment(-0.24, -0.36)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                    onPressed: errorTypes[currentError].onClose,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('OK')),
              )
            ],
          ));
}

class _CommonError {
  BuildContext context;
  Map<String, dynamic> error;

  _CommonError(this.context, this.error);

  List<Widget> get errorDescription => <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 12),
          child: Text(
            error[error.keys.first],
            textAlign: TextAlign.center,
          ),
        ),
      ];

  void onClose() {
    Navigator.of(context).pop();
  }
}

class _LocalError {
  BuildContext context;
  Map<String, dynamic> error;

  _LocalError(this.context, this.error);

  List<Widget> get errorDescription => <Widget>[
        error.keys.first == 'internetConnectionError'
            ? ColorFiltered(
                colorFilter:
                    const ColorFilter.mode(Color(0xFF0070BA), BlendMode.color),
                child: ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(Colors.grey, BlendMode.saturation),
                  child: Image.asset(
                    'assets/images/notification_assets/no-wifi.png',
                    height: 48,
                    width: 48,
                  ),
                ))
            : Image.asset(
                'assets/images/notification_assets/file-error.png',
                height: 48,
                width: 48,
              ),
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 12),
          child: Text(
            error[error.keys.first],
            textAlign: TextAlign.center,
          ),
        ),
      ];

  void onClose() {
    Navigator.of(context).pop();
  }
}

class _HazardousError {
  BuildContext context;
  Map<String, dynamic> error;

  _HazardousError(this.context, this.error);

  List<Widget> get errorDescription => <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 12),
          child: Text(
            error[error.keys.first],
            textAlign: TextAlign.center,
          ),
        ),
      ];

  void onClose() async {
    final logOutStatus = await _deleteLoggedInUserData();
    if (logOutStatus) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    }
  }
}
