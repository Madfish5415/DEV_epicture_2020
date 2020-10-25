import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviderBuilderWidget<T extends Cubit<Object>>
    extends StatelessWidget {
  final CreateBloc<T> create;
  final WidgetBuilder builder;

  BlocProviderBuilderWidget({
    @required this.create,
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: create,
      child: Builder(builder: builder),
    );
  }
}
