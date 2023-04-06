import 'package:fitness_app/providers/user_login_state_provider.dart';
import 'package:flutter/cupertino.dart';

class LiveTransactionsProvider with ChangeNotifier {
  late UserLoginStateProvider _userLoginStateProvider;

  List<dynamic> _successfulTransactionInQueue = [];
  List<String> _unreadTransactionList = [];
}
