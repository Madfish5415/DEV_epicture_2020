import 'package:epicture/blocs/account/event.dart';
import 'package:epicture/blocs/account/state.dart';
import 'package:epicture/models/account.dart';
import 'package:epicture/models/album.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/repositories/account.dart';
import 'package:epicture/repositories/album.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _repository;
  final AlbumRepository _albumRepository;

  static AccountBloc of(BuildContext context) {
    return BlocProvider.of(context);
  }

  AccountBloc(this._repository, [this._albumRepository])
      : super(AccountInitialState());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    yield AccountLoadingState();

    if (event is AccountGetEvent) {
      yield* _get(event);
    } else if (event is AccountGetFavoritesEvent) {
      yield* _getFavorites(event);
    } else if (event is AccountGetPostsEvent) {
      yield* _getPosts(event);
    }
  }

  Stream<AccountState> _get(AccountGetEvent event) async* {
    try {
      final AccountModel account = await _repository.get(
        name: event.name,
        token: event.token,
      );

      yield AccountGotState(account: account);
    } on Exception catch (e) {
      yield AccountErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }

  Stream<AccountState> _getFavorites(AccountGetFavoritesEvent event) async* {
    try {
      List<GalleryItemModel> favorites = await _repository.favorites(
        name: event.name,
        token: event.token,
      );
      List<GalleryItemModel> completeFavorites = await _getCompleteGallery(
        gallery: favorites,
        token: event.token,
      );

      yield AccountGotFavoritesState(favorites: completeFavorites);
    } on Exception catch (e) {
      yield AccountErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }

  Stream<AccountState> _getPosts(
    AccountGetPostsEvent event,
  ) async* {
    try {
      final List<GalleryItemModel> posts = await _repository.posts(
        name: event.name,
        token: event.token,
      );

      yield AccountGotPostsState(posts: posts);
    } on Exception catch (e) {
      yield AccountErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }

  Future<List<GalleryItemModel>> _getCompleteGallery({
    @required List<GalleryItemModel> gallery,
    @required String token,
  }) async {
    final completeGallery = gallery.map((element) async {
      final dynamic child = element.child;

      if (child is AlbumModel) {
        final album = await _albumRepository.get(id: child.id, token: token);

        return GalleryItemModel(
          child: album,
          type: element.type,
          public: element.public,
          favorites: element.favorites,
          ups: element.ups,
          downs: element.downs,
          score: element.score,
          tags: element.tags,
          vote: element.vote,
        );
      }

      return element;
    });

    return Future.wait(completeGallery);
  }
}
