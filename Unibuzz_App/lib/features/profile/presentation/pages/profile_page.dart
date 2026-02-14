import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      body: Stack(
        children: [
          // Ambient glows
          Positioned(
            top: -60,
            left: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -30,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.06),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                expandedHeight: 80,
                collapsedHeight: 80,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.6),
                            Colors.black.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
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
                  children: [
                    const SizedBox(height: 20),
                    const UserInfoCard(),
                    const ProfileStats(),
                    const MyEventsSection(),
                    const SizedBox(height: 20),
                    const InterestsSection(),
                    const SizedBox(height: 10),
                    const AccountActionsList(),
                    const SizedBox(height: 100),
                  ].animate(interval: 80.ms)
                   .fade(duration: 400.ms)
                   .slideY(begin: 0.05, end: 0, curve: Curves.easeOut),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
