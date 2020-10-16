import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/user.dart';

class UserRepository {
  UserModel _user;

  Future<UserModel> login() async {
    if (_user == null) {
      final String url = await ImgurClient.login();
      final Uri uri = Uri.parse(url.replaceFirst("#", "?"));

      _user = UserModel.fromMap(uri.queryParameters);
    }

    return _user;
  }

  Future<void> logout() async {
    _user = null;
  }
}
