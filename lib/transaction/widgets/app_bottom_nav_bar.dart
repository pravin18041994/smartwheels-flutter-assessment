import 'package:flutter/material.dart';
import 'package:smartwheels_task/core/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, this.currentIndex = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.card,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: NavigationBar(
          height: 72,
          selectedIndex: currentIndex,
          onDestinationSelected: (_) {},
          backgroundColor: AppColors.card,
          indicatorColor: AppColors.primary.withValues(alpha: 0.15),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.swap_horiz_outlined),
              selectedIcon: Icon(Icons.swap_horiz),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart_outlined),
              selectedIcon: Icon(Icons.bar_chart),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_none),
              selectedIcon: Icon(Icons.notifications),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
