import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/data/mock_home_data.dart';
import '../../../events/presentation/pages/event_participation_page.dart';

class DiscoverEventCard extends StatelessWidget {
  final EventModel event;

  const DiscoverEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    // Differentiation Logic
    // Interested Events: Normal brightness, Neon accents
    // Not-Interested Events: Dimmed (0.7 opacity), Reduced glow, Muted outline
    
    final bool isInterested = event.isInterested;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => EventParticipationPage(event: event),
            ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isInterested 
                ? AppColors.primary.withOpacity(0.5) 
                : Colors.white.withOpacity(0.1),
            width: isInterested ? 1.5 : 1,
          ),
          boxShadow: isInterested ? [
             BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ] : [
             BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        // Dim the content if not interested
        foregroundDecoration: isInterested ? null : BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster Image
              Stack(
                children: [
                  Image.network(
                    event.imageUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                     loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                        return Container(
                          height: 160,
                          color: Colors.grey[900],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 160,
                        color: Colors.grey[900],
                        child: const Icon(Icons.broken_image, color: Colors.white30),
                      ),
                  ),
                  
                  // Category Badge (Top Left)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        event.category.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  // Interested Badge (Top Right)
                  if (isInterested)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withOpacity(0.5),
                              blurRadius: 8,
                            )
                          ]
                        ),
                        child: const Icon(Icons.star, size: 14, color: Colors.black),
                      ),
                    ),
                ],
              ),

              // Event Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date & Dept Row
                    Row(
                      children: [
                         Text(
                          event.date.toUpperCase(),
                          style: TextStyle(
                            color: isInterested ? AppColors.primary : Colors.white54,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            event.department,
                             style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Title
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontFamily: 'Racing Sans One',
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // CTA Button
                    SizedBox(
                      width: double.infinity,
                      child: isInterested 
                        ? ElevatedButton(
                            onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context) => EventParticipationPage(event: event),
                                    ),
                                );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                            ),
                            child: const Text("PARTICIPATE NOW", style: TextStyle(fontWeight: FontWeight.bold)),
                          )
                        : OutlinedButton(
                            onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context) => EventParticipationPage(event: event),
                                    ),
                                );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white54,
                              side: const BorderSide(color: Colors.white24),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("VIEW DETAILS"),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
