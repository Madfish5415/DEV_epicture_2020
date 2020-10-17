abstract class AccountEvent {
  const AccountEvent();
}

class AccountGetEvent extends AccountEvent {
  final String name;

  const AccountGetEvent({this.name = "me"});
}
