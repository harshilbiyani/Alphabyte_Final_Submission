import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_session_data.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class SessionCard extends StatelessWidget {
  final SessionModel session;
  final VoidCallback? onTap;

  static const Color _accent = Color(0xFF00BCD4);

  const SessionCard({super.key, required this.session, this.onTap});

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
              // Top row: Category + Featured + Mode
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _accent.withOpacity(.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _accent.withOpacity(.3)),
                    ),
                    child: Text(
                      session.category,
                      style: GoogleFonts.poppins(color: _accent, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (session.isFeatured)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 12),
                          const SizedBox(width: 3),
                          Text('Featured', style: GoogleFonts.poppins(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _modeColor(session.mode).withOpacity(.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(session.mode, style: GoogleFonts.poppins(color: _modeColor(session.mode), fontSize: 10, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Title
              Text(
                session.title,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700, height: 1.2),
                maxLines: 2,
              ),
              const SizedBox(height: 6),
              Text(
                session.description,
                style: GoogleFonts.poppins(color: Colors.white.withOpacity(.6), fontSize: 12, height: 1.4),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14),
              // Speaker row
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: _accent.withOpacity(.2),
                    child: Text(
                      session.speaker.isNotEmpty ? session.speaker[0] : 'S',
                      style: GoogleFonts.poppins(color: _accent, fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(session.speaker, style: GoogleFonts.poppins(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                        Text(session.speakerTitle, style: GoogleFonts.poppins(color: Colors.white.withOpacity(.5), fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Tags
              if (session.tags.isNotEmpty)
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: session.tags.map((tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withOpacity(.08)),
                    ),
                    child: Text('#$tag', style: GoogleFonts.poppins(color: _accent.withOpacity(.7), fontSize: 10)),
                  )).toList(),
                ),
              const SizedBox(height: 14),
              // Bottom info
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.04),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _info(Icons.calendar_today_rounded, session.date),
                    _info(Icons.access_time_rounded, session.time),
                    _info(Icons.timer_outlined, session.duration),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Seats + fee
              Row(
                children: [
                  Icon(Icons.event_seat_rounded, color: _accent, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    '${session.seatsLeft} seats left',
                    style: GoogleFonts.poppins(
                      color: session.seatsLeft < 20 ? Colors.redAccent : Colors.white.withOpacity(.6),
                      fontSize: 12,
                      fontWeight: session.seatsLeft < 20 ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  if (session.fee > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _accent.withOpacity(.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('₹${session.fee.toInt()}', style: GoogleFonts.poppins(color: _accent, fontSize: 12, fontWeight: FontWeight.w700)),
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
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: .05, end: 0, duration: 400.ms);
  }

  Widget _info(IconData icon, String text) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _accent.withOpacity(.7), size: 13),
          const SizedBox(width: 4),
          Flexible(
            child: Text(text, style: GoogleFonts.poppins(color: Colors.white.withOpacity(.6), fontSize: 10.5), overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Color _modeColor(String mode) {
    switch (mode) {
      case 'Online':
        return Colors.greenAccent;
      case 'Hybrid':
        return Colors.amber;
      default:
        return _accent;
    }
  }
}
