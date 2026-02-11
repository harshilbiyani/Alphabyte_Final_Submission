import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/mock_notification_data.dart';
import '../widgets/notification_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = MockNotificationData.notifications;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Sticky Glass Header
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.background.withOpacity(0.9),
            elevation: 0,
            expandedHeight: 80,
            collapsedHeight: 80,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: AppColors.background.withOpacity(0.6),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 60, top: 40), // offset for back button
                  child: const Text(
                    'NOTIFICATIONS',
                    style: TextStyle(
                      fontFamily: 'Racing Sans One',
                      color: Colors.white,
                      fontSize: 22,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            actions: [
               IconButton(
                 icon: const Icon(Icons.check_circle_outline, color: Colors.white54),
                 tooltip: "Mark all as read",
                 onPressed: () {
                    // TODO: Implement mark all logic
                    ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text("All notifications marked as read"))
                    );
                 },
               )
            ],
          ),

          // List or Empty State
          if (notifications.isEmpty)
             SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.notifications_off_outlined, size: 60, color: Colors.white24),
                    const SizedBox(height: 20),
                    Text(
                      "You're all caught up 🎉",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
             )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final note = notifications[index];
                    return NotificationCard(notification: note)
                        .animate()
                        .fadeIn(delay: (50 * index).ms)
                        .slideX(begin: 0.1, end: 0);
                  },
                  childCount: notifications.length,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }
}
