import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopify/core/configs/theme/app_theme.dart';
import 'package:shopify/firebase_options.dart';
import 'package:shopify/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:shopify/presentation/home/bloc/play_list_cubit.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:shopify/presentation/splash/pages/splash.dart';
import 'package:shopify/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        // Web: dùng storage của trình duyệt
        ? HydratedStorageDirectory.web
        // Mobile/Desktop: bọc đường dẫn thư mục vào HydratedStorageDirectory
        : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path,
          ),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDependencise();
  debugPrint('sl PlayListCubit hash: ${identityHashCode(sl<PlayListCubit>())}');


  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(
          create: (_) => sl<PlayListCubit>()..getPlayList(),
        ),
        BlocProvider(
          create: (context) => SongPlayerCubit(context.read<PlayListCubit>()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
        ),
      )
    );
  }
}
