import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/page_transitions.dart';
import '../../../home/data/mock_home_data.dart';
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
          SlideUpRoute(page: EventParticipationPage(event: event)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14, left: 20, right: 20),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(16),
          blur: 10,
          opacity: 0.08,
          color: isInterested ? AppColors.accent : Colors.white,
          padding: const EdgeInsets.all(12),
          border: Border.all(
            color: isInterested
                ? AppColors.accent.withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.05),
          ),
          boxShadow: isInterested
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
          child: Row(
            children: [
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            event.category.toUpperCase(),
                            style: const TextStyle(
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
                              color: Color(0xFFFF4444),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
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
                    Text(
                      event.date,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isInterested ? AppColors.accent : Colors.transparent,
                  shape: BoxShape.circle,
                  border: isInterested
                      ? null
                      : Border.all(color: Colors.white24),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: isInterested ? Colors.black : Colors.white60,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
