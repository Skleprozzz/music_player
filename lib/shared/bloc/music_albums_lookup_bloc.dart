import 'package:bloc/bloc.dart';

import 'package:flutter_advanced_ui/shared/data/music_data_repository.dart';
import 'package:flutter_advanced_ui/shared/model/album.dart';

import 'music_data_states.dart';

class LookupAlbums {
  final String artistId;

  const LookupAlbums({
    required this.artistId,
  });
}

class AlbumsLoaded extends MusicDataState {
  final List<Album> albums;

  const AlbumsLoaded({
    required this.albums,
  });
}

class MusicAlbumsLookupBloc extends Bloc<LookupAlbums, MusicDataState> {
  final MusicDataRepository repository;

  MusicAlbumsLookupBloc({
    required this.repository,
  }) : super(DataEmpty()) {
    on<LookupAlbums>(
      (event, emit) async {
        emit(DataLoading());
        final albums = await repository.getAlbumsByArtist(event.artistId);
        emit(AlbumsLoaded(albums: albums));
      },
    );
  }
}
