import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_sports_data.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../shared/widgets/registration_status_bar.dart';

class SportsCard extends StatelessWidget {
  final SportsEventModel event;
  final VoidCallback? onTap;

  static const Color _accent = Color(0xFFFFB800);

  const SportsCard({super.key, required this.event, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: BorderRadius.circular(18),
        opacity: .08,
        blur: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image header
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              child: Stack(
                children: [
                  Image.network(
                    event.imageUrl,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 140,
                      color: _accent.withOpacity(.12),
                      child: Center(child: Icon(Icons.sports, color: _accent.withOpacity(.5), size: 40)),
                    ),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(.75)],
                        ),
                      ),
                    ),
                  ),
                  // Sport badge
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _accent.withOpacity(.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(_sportIcon(event.sport), color: Colors.black87, size: 13),
                          const SizedBox(width: 4),
                          Text(event.sport, style: GoogleFonts.poppins(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                  // LIVE badge
                  if (event.isLive)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 7, height: 7,
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 5),
                            Text('LIVE', style: GoogleFonts.poppins(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ).animate(onPlay: (c) => c.repeat(reverse: true)).fade(begin: 1, end: .5, duration: 800.ms),
                    ),
                  // Title
                  Positioned(
                    bottom: 10,
                    left: 12,
                    right: 12,
                    child: Text(
                      event.title,
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, height: 1.2),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.description,
                    style: GoogleFonts.poppins(color: Colors.white.withOpacity(.65), fontSize: 12, height: 1.4),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Ticket-style info row
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.04),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(.06)),
                    ),
                    child: Row(
                      children: [
                        _ticketInfo(Icons.calendar_today_rounded, event.date),
                        _divider(),
                        _ticketInfo(Icons.groups_rounded, event.teamSize),
                        _divider(),
                        _ticketInfo(Icons.emoji_events_rounded, event.prizePool),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Registration progress
                  RegistrationStatusBar(
                    filled: event.registeredTeams,
                    total: event.maxTeams,
                    color: _accent,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, color: _accent, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.venue,
                          style: GoogleFonts.poppins(color: Colors.white.withOpacity(.55), fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (event.fee > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _accent.withOpacity(.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '₹${event.fee.toInt()}',
                            style: GoogleFonts.poppins(color: _accent, fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.withOpacity(.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('Free', style: GoogleFonts.poppins(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: .05, end: 0, duration: 400.ms);
  }

  Widget _divider() => Container(width: 1, height: 28, color: Colors.white.withOpacity(.08), margin: const EdgeInsets.symmetric(horizontal: 8));

  Widget _ticketInfo(IconData icon, String text) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: _accent, size: 16),
          const SizedBox(height: 4),
          Text(text, style: GoogleFonts.poppins(color: Colors.white.withOpacity(.7), fontSize: 10), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  IconData _sportIcon(String sport) {
    switch (sport) {
      case 'Cricket':
        return Icons.sports_cricket_rounded;
      case 'Football':
        return Icons.sports_soccer_rounded;
      case 'Basketball':
        return Icons.sports_basketball_rounded;
      case 'Badminton':
        return Icons.sports_tennis_rounded;
      case 'Athletics':
        return Icons.directions_run_rounded;
      case 'Chess':
        return Icons.psychology_rounded;
      default:
        return Icons.sports_rounded;
    }
  }
}
