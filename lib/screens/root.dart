import 'package:epicture/blocs/page.dart';
import 'package:epicture/models/page.dart';
import 'package:epicture/repositories/root_page.dart';
import 'package:epicture/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PageBloc(RootPageRepository()),
      child: BlocBuilder<PageBloc, PageState>(
        builder: (context, state) {
          final List<PageModel> pages = PageBloc.of(context).pages;
          final Function(int) onTap = (index) {
            PageBloc.of(context).add(PageToEvent(index: index));
          };

          return Scaffold(
            body: state.page.builder(context),
            bottomNavigationBar: BottomBarWidget(
              pages,
              pages.indexOf(state.page),
              onTap,
            ),
          );
        },
      ),
    );
  }
}
