import 'package:epicture/models/account.dart';
import 'package:flutter/foundation.dart';

abstract class AccountState {
  const AccountState();
}

class AccountInitialState extends AccountState {
  const AccountInitialState();
}

class AccountLoadingState extends AccountState {
  const AccountLoadingState();
}

class AccountGotState extends AccountState {
  final AccountModel account;

  const AccountGotState({@required this.account});
}

class AccountErrorState extends AccountState {
  final String message;

  const AccountErrorState({this.message});
}
