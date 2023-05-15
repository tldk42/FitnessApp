import 'package:fitness_app/providers/user_login_state_provider.dart';
import 'package:flutter/cupertino.dart';

class LiveUpdateProvider with ChangeNotifier {
  late UserLoginStateProvider _userLoginStateProvider;

  List<dynamic> _successfulUpdatenQueue = [];
  List<String> _unreadUpdateList = [];
  int _updateRequests = 0;

  LiveUpdateProvider();

  List<dynamic> get successfulUpdateInQueue => _successfulUpdatenQueue;

  int get unreadUpdate => _unreadUpdateList.length;

  int get updateRequests => _updateRequests;

  void update(UserLoginStateProvider userLoginStateProvider) {
    _userLoginStateProvider = userLoginStateProvider;
  }



}
