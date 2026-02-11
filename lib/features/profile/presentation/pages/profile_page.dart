import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/user_info_card.dart';
import '../widgets/profile_stats.dart';
import '../widgets/my_events_section.dart';
import '../widgets/interests_section.dart';
import '../widgets/account_actions_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Sticky Glass Header
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.background.withOpacity(0.9), // Fallback
            elevation: 0,
            expandedHeight: 80,
            collapsedHeight: 80,
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: AppColors.background.withOpacity(0.6),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, top: 40),
                  child: const Text(
                    'PROFILE',
                    style: TextStyle(
                      fontFamily: 'Racing Sans One',
                      color: Colors.white,
                      fontSize: 24,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: const [
                SizedBox(height: 20),
                UserInfoCard(),
                ProfileStats(),
                MyEventsSection(),
                SizedBox(height: 20),
                InterestsSection(),
                SizedBox(height: 10),
                AccountActionsList(),
                SizedBox(height: 100), // Navigation spacing
              ],
            ),
          ),
        ],
      ),
    );
  }
}
