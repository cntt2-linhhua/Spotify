import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shopify/core/configs/constants/app_urls.dart';
import 'package:shopify/domain/entities/song/song.dart';
import 'package:shopify/presentation/home/bloc/play_list_cubit.dart';
import 'package:shopify/presentation/home/bloc/play_list_state.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_state.dart';
import 'package:shopify/core/configs/constants/repeat_mode.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final PlayListCubit playListCubit;

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  SongEntity? currentSong;

  SongPlayerCubit(this.playListCubit) : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
        updateSongPlayer();
      }
    });

    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _onSongComplete();
      }
    });
  }

  void updateSongPlayer() {
    if (currentSong == null) return;
  
    emit(SongPlayerLoaded(
      songDuration: songDuration,
      songPosition: songPosition,
      isPlaying: audioPlayer.playing,
      currentSong: currentSong!,
    ));
  }

  Future<void> loadSong(SongEntity song) async {
    try {
      currentSong = song;
      await audioPlayer.setUrl('${AppUrls.songStorage}${song.artist}.mp3');
      updateSongPlayer();
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    updateSongPlayer();
  }

  void _onSongComplete() {
    final playListState = playListCubit.state;
    if (playListState is PlayListLoaded) {
      switch (playListState.repeatMode) {
        case RepeatMode.off:
          if (playListState.currentIndex < playListState.songs.length - 1) {
            playNextSong();
          }
          break;
        case RepeatMode.all:
          playNextSong(loop: true);
          break;
        case RepeatMode.one:
          replayCurrentSong();
          break;
      }
    }
  }

  void playNextSong({bool loop = false}) {
    final playListState = playListCubit.state;
    if (playListState is PlayListLoaded) {
      int nextIndex = playListState.currentIndex + 1;
      if (nextIndex >= playListState.songs.length) {
        if (loop) {
          nextIndex = 0;
        } else {
          return;
        }
      }
      playListCubit.setCurrentIndex(nextIndex);
      final nextSong = playListState.songs[nextIndex];
      loadSong(nextSong);
    }
  }

  void playPreviousSong() {
    final playListState = playListCubit.state;
    if (playListState is PlayListLoaded && playListState.currentIndex > 0) {
      final prevIndex = playListState.currentIndex - 1;
      playListCubit.setCurrentIndex(prevIndex);
      final prevSong = playListState.songs[prevIndex];
      loadSong(prevSong);
    }
  }

  void replayCurrentSong() {
    audioPlayer.seek(Duration.zero);
    audioPlayer.play();
  }

  void seek(Duration position) {
    // clamp nhẹ để tránh seek vượt duration hoặc âm
    final total = songDuration;
    if (total != Duration.zero && position > total) {
      audioPlayer.seek(total);
    } else if (position < Duration.zero) {
      audioPlayer.seek(Duration.zero);
    } else {
      audioPlayer.seek(position);
    }
    updateSongPlayer();
  }

  // (tuỳ chọn) tiện cho Slider
  void seekToSeconds(int seconds) => seek(Duration(seconds: seconds));

  void updateFavoriteFromPlaylist(SongEntity updatedSong) {
  if (state is! SongPlayerLoaded) return;

  final current = state as SongPlayerLoaded;

  if (current.currentSong.songId == updatedSong.songId) {
    emit(current.copyWith(currentSong: updatedSong));
    print("[SongPlayerCubit] Synced favorite for ${updatedSong.songId}");
  }
}


  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
