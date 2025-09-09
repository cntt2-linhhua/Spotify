import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/common/widgets/app_bottom_nav/app_bottom_nav.dart';
import 'package:shopify/common/widgets/mini_player/mini_player.dart';
import 'package:shopify/presentation/artists/page/artists.dart';
import 'package:shopify/presentation/favorite/page/favorite.dart';
import 'package:shopify/presentation/home/pages/home.dart';
import 'package:shopify/presentation/profile/pages/profile.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_state.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ArtistsPage(),
    FavoritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Tabs
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),

          /// Global MiniPlayer
          BlocBuilder<SongPlayerCubit, SongPlayerState>(
            buildWhen: (_, curr) => curr is SongPlayerLoaded,
            builder: (context, state) {
              final showMiniPlayer = state is SongPlayerLoaded;

              return AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: 0,
                right: 0,
                bottom: showMiniPlayer ? 0 : -80,
                child: const MiniPlayer(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
