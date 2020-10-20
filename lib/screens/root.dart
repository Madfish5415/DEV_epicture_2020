import 'package:epicture/blocs/page.dart';
import 'package:epicture/models/page.dart';
import 'package:epicture/repositories/root_page.dart';
import 'package:epicture/widgets/navigation/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return PageBloc(RootPageRepository())
          ..add(PageGoToEvent(index: 0));
      },
      child: BlocBuilder<PageBloc, PageState>(
        builder: (context, state) {
          final List<PageModel> pages = PageBloc.of(context).pages;

          if (state is PageGoneToState) {
            return _RootPageGoneTo(
              currentIndex: pages.indexOf(state.page),
              pages: pages,
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _RootPageGoneTo extends StatelessWidget {
  final int currentIndex;
  final List<PageModel> pages;

  _RootPageGoneTo({
    @required this.currentIndex,
    @required this.pages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex].builder(context),
      bottomNavigationBar: BottomBarWidget(
        currentIndex: currentIndex,
        pages: pages,
        onTap: (value) {
          PageBloc.of(context).add(PageGoToEvent(index: value));
        },
      ),
    );
  }
}
