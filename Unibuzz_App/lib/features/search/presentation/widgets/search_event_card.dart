import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/data/mock_home_data.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../events/presentation/pages/event_participation_page.dart';

class SearchEventCard extends StatelessWidget {
  final EventModel event;

  const SearchEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    bool isInterested = event.isInterested;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventParticipationPage(event: event),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isInterested 
                ? const Color(0xFFC6FF33).withOpacity(0.3) 
                : Colors.white.withOpacity(0.05),
          ),
          boxShadow: isInterested ? [
             BoxShadow(
              color: const Color(0xFFC6FF33).withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ] : [],
        ),
        child: Row(
          children: [
            // Thumbnail
            Hero(
              tag: 'search_${event.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  event.imageUrl,
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 90,
                    width: 90,
                    color: Colors.grey[900],
                    child: const Icon(Icons.broken_image, color: Colors.white24),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                        ),
                        child: Text(
                          event.category.toUpperCase(),
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (event.isEndingSoon)
                         Text(
                          event.timeLeft,
                          style: const TextStyle(
                            color: Color(0xFFFF4444), // Redish for urgency
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Title
                  Text(
                    event.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // Date
                  Text(
                    event.date,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),

                  // Button/Status
                  const SizedBox(height: 8),
                ],
              ),
            ),
            
            // CTA or Arrow
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isInterested ? const Color(0xFFC6FF33) : Colors.transparent,
                shape: BoxShape.circle,
                border: isInterested ? null : Border.all(color: Colors.white24),
              ),
              child: Icon(
                Icons.arrow_forward,
                color: isInterested ? Colors.black : Colors.white60,
                size: 16,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0),
    );
  }
}
