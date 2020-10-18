import 'package:epicture/blocs/account/event.dart';
import 'package:epicture/blocs/account/state.dart';
import 'package:epicture/models/account.dart';
import 'package:epicture/repositories/account.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _repository;

  static AccountBloc of(BuildContext context) {
    return BlocProvider.of(context);
  }

  AccountBloc(this._repository) : super(AccountInitialState());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    yield AccountLoadingState();

    if (event is AccountGetEvent) {
      yield* _get(event);
    }
  }

  Stream<AccountState> _get(AccountGetEvent event) async* {
    try {
      final AccountModel account = await _repository.get(name: event.name);

      yield AccountGotState(account: account);
    } on Exception catch (e) {
      yield AccountErrorState(message: e.toString());
    }
  }
}
