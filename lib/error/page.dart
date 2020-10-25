import 'package:epicture/blocs/common/state.dart';
import 'package:flutter/material.dart';

class PageErrorWidget extends StatelessWidget {
  final ErrorState error;
  final VoidCallback onPressed;

  PageErrorWidget({
    @required this.error,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error.message),
          TextButton(
            onPressed: onPressed,
            child: Text("Retry"),
          ),
        ],
      ),
    );
  }
}
