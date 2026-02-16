import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_club_data.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class ClubCard extends StatelessWidget {
  final ClubModel club;
  final VoidCallback? onTap;

  static const Color _accent = Color(0xFFFF7043);

  const ClubCard({super.key, required this.club, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: BorderRadius.circular(18),
        opacity: .08,
        blur: 16,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo + Name + Category
              Row(
                children: [
                  // Logo
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _accent.withOpacity(.3), width: 1.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.network(
                        club.logoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: _accent.withOpacity(.15),
                          child: Center(
                            child: Text(
                              club.name.isNotEmpty ? club.name[0] : 'C',
                              style: GoogleFonts.poppins(color: _accent, fontSize: 20, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          club.name,
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700, height: 1.2),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _accent.withOpacity(.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(club.category, style: GoogleFonts.poppins(color: _accent, fontSize: 10, fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                            const SizedBox(width: 2),
                            Text(club.rating.toString(), style: GoogleFonts.poppins(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Recruiting badge
                  if (club.isRecruiting)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withOpacity(.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.greenAccent.withOpacity(.3)),
                      ),
                      child: Column(
                        children: [
                          Text('OPEN', style: GoogleFonts.poppins(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.w700)),
                          Text('Join', style: GoogleFonts.poppins(color: Colors.greenAccent.withOpacity(.7), fontSize: 9)),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              // Description
              Text(
                club.description,
                style: GoogleFonts.poppins(color: Colors.white.withOpacity(.6), fontSize: 12, height: 1.4),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              // Tags
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: club.tags.map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white.withOpacity(.08)),
                  ),
                  child: Text(tag, style: GoogleFonts.poppins(color: _accent.withOpacity(.7), fontSize: 10)),
                )).toList(),
              ),
              const SizedBox(height: 12),
              // Stats row
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.04),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _stat(Icons.people_rounded, '${club.memberCount} members'),
                    _stat(Icons.calendar_month_rounded, 'Est. ${club.founded}'),
                    _stat(Icons.person_rounded, club.presidentName),
                  ],
                ),
              ),
              if (club.upcomingEvents.isNotEmpty) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.event_rounded, color: _accent.withOpacity(.7), size: 14),
                    const SizedBox(width: 5),
                    Text('Upcoming: ', style: GoogleFonts.poppins(color: Colors.white.withOpacity(.5), fontSize: 11)),
                    Expanded(
                      child: Text(
                        club.upcomingEvents.join(' • '),
                        style: GoogleFonts.poppins(color: _accent.withOpacity(.8), fontSize: 11, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              if (club.isRecruiting && club.recruitingDeadline.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.timer_rounded, color: Colors.redAccent, size: 14),
                    const SizedBox(width: 5),
                    Text(
                      'Apply by ${club.recruitingDeadline}',
                      style: GoogleFonts.poppins(color: Colors.redAccent.withOpacity(.8), fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: .05, end: 0, duration: 400.ms);
  }

  Widget _stat(IconData icon, String text) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _accent.withOpacity(.6), size: 13),
          const SizedBox(width: 4),
          Flexible(
            child: Text(text, style: GoogleFonts.poppins(color: Colors.white.withOpacity(.55), fontSize: 10), overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
