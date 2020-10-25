import 'package:epicture/blocs/page/event.dart';
import 'package:epicture/blocs/page/state.dart';
import 'package:epicture/models/page.dart';
import 'package:epicture/repositories/page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  final PageRepository _repository;

  static PageBloc of(BuildContext context) {
    return BlocProvider.of(context);
  }

  PageBloc(this._repository) : super(PageInitialState());

  @override
  Stream<PageState> mapEventToState(PageEvent event) async* {
    if (event is PageGoToEvent) {
      yield* _goTo(event);
    }
  }

  Stream<PageState> _goTo(PageGoToEvent event) async* {
    PageState current = state;

    if (current is PageGoneToState) {
      if (event.index == _repository.pages.indexOf(current.page)) return;
    }

    yield PageGoneToState(page: _repository.pages[event.index]);
  }

  List<PageModel> get pages => _repository.pages;
}
