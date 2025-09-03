import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopify/core/configs/assets/app_images.dart';
import 'package:shopify/core/configs/assets/app_vectors.dart';
import 'package:shopify/core/configs/constants/contanst.dart';
import 'package:shopify/core/configs/theme/app_color.dart';
import 'package:shopify/presentation/home/widgets/news_songs.dart';
import 'package:shopify/presentation/home/widgets/play_list.dart';
import 'package:shopify/presentation/profile/pages/profile.dart';
import 'package:shopify/common/helpers/is_dark_mode.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: false,
              elevation: 0,
              expandedHeight: 175,
              scrolledUnderElevation: 0,
              backgroundColor: context.isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
              leading: Icon(Icons.search, color: context.isDarkMode ? Colors.white : AppColors.darkGrey),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                    );
                  },
                  icon: Icon(Icons.more_vert, color: context.isDarkMode ? Colors.white : AppColors.darkGrey),
                ),
              ],
              title: SvgPicture.asset(AppVectors.logo, height: 32),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _homeTopCard(),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            _tabs(),
            const SizedBox(height: 20),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  NewsSongs(),
                  Center(child: Text("Albums")),
                  Center(child: Text("Artists")),
                  Center(child: Text("Podcasts")),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const PlayList(),
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return SizedBox(
      height: 118,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SvgPicture.asset(
              AppVectors.homeTopCard,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              AppImages.homeArtist,
              height: 183,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabs() {
    return Transform.translate(
      offset: const Offset(-16, 0),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        dividerColor: Colors.transparent,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        tabAlignment: TabAlignment.start,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        tabs: List.generate(Constants.tabs.length, (index) {
          return Text(
            Constants.tabs[index],
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          );
        }),
      ),
    );
  }
}
