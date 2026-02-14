import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/page_transitions.dart';
import '../../data/mock_notification_data.dart';
import '../../../events/presentation/pages/event_participation_page.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final Color accentColor = _getAccentColor(notification.type);
    final IconData icon = _getIcon(notification.type);
    final bool isUnread = notification.isUnread;

    return GestureDetector(
      onTap: () {
        if (notification.linkedEvent != null) {
          Navigator.push(
            context,
            SlideUpRoute(page: EventParticipationPage(event: notification.linkedEvent!)),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(16),
          blur: 10,
          opacity: isUnread ? 0.1 : 0.05,
          color: isUnread ? accentColor : Colors.white,
          border: Border.all(
            color: isUnread
                ? accentColor.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.05),
            width: isUnread ? 1.2 : 1,
          ),
          boxShadow: isUnread
              ? [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Left accent strip
                if (isUnread)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    width: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withValues(alpha: 0.5),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: accentColor.withValues(alpha: 0.2)),
                        ),
                        child: Icon(icon, color: accentColor, size: 20),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    notification.title,
                                    style: TextStyle(
                                      color: isUnread
                                          ? Colors.white
                                          : Colors.white70,
                                      fontWeight: isUnread
                                          ? FontWeight.bold
                                          : FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  notification.time,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.4),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              notification.message,
                              style: TextStyle(
                                color: isUnread
                                    ? Colors.white.withValues(alpha: 0.9)
                                    : Colors.white.withValues(alpha: 0.5),
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getAccentColor(NotificationType type) {
    switch (type) {
      case NotificationType.newEvent:
        return AppColors.primary;
      case NotificationType.endingSoon:
        return AppColors.accent;
      case NotificationType.reminder:
        return const Color(0xFF00E5FF);
    }
  }

  IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.newEvent:
        return Icons.celebration_outlined;
      case NotificationType.endingSoon:
        return Icons.timer_outlined;
      case NotificationType.reminder:
        return Icons.calendar_today_outlined;
    }
  }
}
