import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/colors.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void actionTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Text("Home"),
          Text("Bread"),
          Text("Yam"),
          Text("Nonsense"),
          Text("Still"),
        ],
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: actionTapped,
        currentIndex: _page,
        activeColor: AppColors.primaryColor,
        inactiveColor: AppColors.secondaryColor,
        backgroundColor: AppColors.mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: _page == 0
                ? const Icon(Icons.home)
                : const Icon(Icons.home_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: _page == 2
                ? const Icon(Icons.add_circle)
                : const Icon(Icons.add_circle_outline),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: _page == 3
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_outline),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: _page == 4
                ? const Icon(Icons.person)
                : const Icon(Icons.person_outline),
            label: "",
          ),
        ],
      ),
    );
  }
}
