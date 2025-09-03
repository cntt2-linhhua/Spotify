import 'package:get_it/get_it.dart';
import 'package:shopify/data/respository/auth/auth_responsitory_impl.dart';
import 'package:shopify/data/respository/song/song_repository.impl.dart';
import 'package:shopify/data/sources/auth/auth_firebase_service.dart';
import 'package:shopify/data/sources/song/song_firebase_service.dart';
import 'package:shopify/domain/respository/auth/auth.dart';
import 'package:shopify/domain/respository/song/song.dart';
import 'package:shopify/domain/usecases/auth/get_user.dart';
import 'package:shopify/domain/usecases/auth/signin.dart';
import 'package:shopify/domain/usecases/auth/signup.dart';
import 'package:shopify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:shopify/domain/usecases/song/get_favorite_song.dart';
import 'package:shopify/domain/usecases/song/get_news_songs.dart';
import 'package:shopify/domain/usecases/song/get_play_list.dart';
import 'package:shopify/domain/usecases/song/is_favorite_song.dart';
import 'package:shopify/presentation/home/bloc/play_list_cubit.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencise() async {
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImp()
  );

  sl.registerSingleton<SongFirebaseService>(
    SongFirebaseServiceImpl()
  );

  sl.registerSingleton<AuthRespository>(
    AuthResponsitoryImpl()
  );

  sl.registerSingleton<SongsRepository>(
    SongRespositoryImpl()
  );

  sl.registerSingleton<SignupUseCase>(
    SignupUseCase()
  );

  sl.registerSingleton<SigninUseCase>(
    SigninUseCase()
  );

  sl.registerSingleton<GetNewsSongsUseCase>(
    GetNewsSongsUseCase()
  );

  sl.registerSingleton<GetPlayListUseCase>(
    GetPlayListUseCase()
  );

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
    AddOrRemoveFavoriteSongUseCase()
  );

  sl.registerSingleton<IsFavoriteSongUseCase>(
    IsFavoriteSongUseCase()
  );

  sl.registerSingleton<GetUserUseCase>(
    GetUserUseCase()
  );

  sl.registerSingleton<GetFavoriteSongsUseCase>(
    GetFavoriteSongsUseCase()
  );

  sl.registerLazySingleton<PlayListCubit>(() => PlayListCubit());
  sl.registerLazySingleton<SongPlayerCubit>(
    () => SongPlayerCubit(sl<PlayListCubit>()),
  );
}
