abstract class UserEvent {
  const UserEvent();
}

class UserInitializeEvent extends UserEvent {
  const UserInitializeEvent();
}

class UserLogInEvent extends UserEvent {
  const UserLogInEvent();
}

class UserLogOutEvent extends UserEvent {
  const UserLogOutEvent();
}
