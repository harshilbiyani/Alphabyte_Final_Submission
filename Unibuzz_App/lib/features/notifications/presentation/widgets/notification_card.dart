import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/mock_notification_data.dart';
import '../../../events/presentation/pages/event_participation_page.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    // Determine visuals based on type
    final Color accentColor = _getAccentColor(notification.type);
    final IconData icon = _getIcon(notification.type);
    final bool isUnread = notification.isUnread;

    return GestureDetector(
      onTap: () {
        if (notification.linkedEvent != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventParticipationPage(event: notification.linkedEvent!),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUnread ? accentColor.withOpacity(0.5) : Colors.white.withOpacity(0.05),
            width: isUnread ? 1.5 : 1,
          ),
          boxShadow: isUnread
              ? [
                  BoxShadow(
                    color: accentColor.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Unread indicator stripe (optional)
              if (isUnread)
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  width: 4,
                  child: Container(color: accentColor),
                ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon Bubble
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: accentColor.withOpacity(0.2)),
                      ),
                      child: Icon(icon, color: accentColor, size: 20),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Text Content
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
                                    color: isUnread ? Colors.white : Colors.white70,
                                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                notification.time,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.4),
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
                              color: isUnread ? Colors.white.withOpacity(0.9) : Colors.white.withOpacity(0.5),
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
      ).animate(target: isUnread ? 1 : 0).shimmer(delay: 500.ms, duration: 1000.ms, color: accentColor.withOpacity(0.1)),
    );
  }

  Color _getAccentColor(NotificationType type) {
    switch (type) {
      case NotificationType.newEvent:
        return const Color(0xFF7D39EB); // Purple
      case NotificationType.endingSoon:
        return const Color(0xFFC6FF33); // Neon Green/Yellow
      case NotificationType.reminder:
        return const Color(0xFF00E5FF); // Cyan-ish Blue for calm urgency
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
