import 'package:flutter/material.dart';
import 'package:shopify/common/widgets/app_bottom_nav/app_bottom_nav.dart';
import 'package:shopify/presentation/artists/page/artists.dart';
import 'package:shopify/presentation/home/pages/home.dart';
import 'package:shopify/presentation/profile/pages/profile.dart';

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
    Center(child: Text("Favorites")),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
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
