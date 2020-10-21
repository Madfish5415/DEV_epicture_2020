import 'package:epicture/models/account.dart';
import 'package:flutter/material.dart';

class AccountCardWidget extends StatelessWidget {
  final AccountModel account;

  AccountCardWidget({
    @required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(account.coverUrl),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AccountAvatar(url: account.avatarUrl),
            Expanded(child: _AccountInformation(account: account)),
          ],
        ),
      ),
    );
  }
}

class _AccountAvatar extends StatelessWidget {
  final String url;

  _AccountAvatar({
    @required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(url),
      radius: 40,
    );
  }
}

class _AccountInformation extends StatelessWidget {
  final AccountModel account;

  _AccountInformation({
    @required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          account.username,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        Text(
          account.biography ?? "No biography",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "${account.reputation} - ${account.reputationName}",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
