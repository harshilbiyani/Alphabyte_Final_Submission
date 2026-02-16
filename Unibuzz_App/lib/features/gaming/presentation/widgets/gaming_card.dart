import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_gaming_data.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../shared/widgets/registration_status_bar.dart';

class GamingCard extends StatelessWidget {
  final GamingEventModel event;
  final VoidCallback? onTap;

  static const Color _accent = Color(0xFF7B2FFF);
  static const Color _neonGreen = Color(0xFF39FF14);

  const GamingCard({super.key, required this.event, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _accent.withOpacity(.35), width: 1.5),
          boxShadow: [
            BoxShadow(color: _accent.withOpacity(.12), blurRadius: 20, spreadRadius: 0),
          ],
        ),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(18),
          opacity: .1,
          blur: 18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: Stack(
                  children: [
                    Image.network(
                      event.imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 150,
                        color: _accent.withOpacity(.15),
                        child: Center(child: Icon(Icons.sports_esports_rounded, color: _accent.withOpacity(.5), size: 40)),
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withOpacity(.8)],
                          ),
                        ),
                      ),
                    ),
                    // Game + Platform badges
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: _accent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(event.game, style: GoogleFonts.poppins(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.5),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: _neonGreen.withOpacity(.5)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(_platformIcon(event.platform), color: _neonGreen, size: 12),
                                const SizedBox(width: 3),
                                Text(event.platform, style: GoogleFonts.poppins(color: _neonGreen, fontSize: 10, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // LIVE
                    if (event.isLive)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(color: Colors.redAccent.withOpacity(.5), blurRadius: 10)],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(width: 7, height: 7, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
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
                      child: Text(event.title, style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, height: 1.2)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.description,
                      style: GoogleFonts.poppins(color: Colors.white.withOpacity(.6), fontSize: 12, height: 1.4),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    // Stats row — RGB glow style
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _accent.withOpacity(.06),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _accent.withOpacity(.15)),
                      ),
                      child: Row(
                        children: [
                          _stat('🏆', event.prizePool),
                          _div(),
                          _stat('👥', event.mode),
                          _div(),
                          _stat('⚔️', event.format.split(' ').first),
                          _div(),
                          _stat('💰', event.fee > 0 ? '₹${event.fee.toInt()}' : 'Free'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    RegistrationStatusBar(
                      filled: event.registeredTeams,
                      total: event.maxTeams,
                      color: _accent,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_rounded, color: _accent, size: 13),
                        const SizedBox(width: 5),
                        Text(event.date, style: GoogleFonts.poppins(color: Colors.white.withOpacity(.55), fontSize: 11)),
                        const Spacer(),
                        Icon(Icons.access_time_rounded, color: _accent, size: 13),
                        const SizedBox(width: 5),
                        Text(event.time, style: GoogleFonts.poppins(color: Colors.white.withOpacity(.55), fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: .05, end: 0, duration: 400.ms);
  }

  Widget _div() => Container(width: 1, height: 24, color: _accent.withOpacity(.15), margin: const EdgeInsets.symmetric(horizontal: 6));

  Widget _stat(String emoji, String text) {
    return Expanded(
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 3),
          Text(text, style: GoogleFonts.poppins(color: Colors.white.withOpacity(.7), fontSize: 10), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  IconData _platformIcon(String platform) {
    switch (platform) {
      case 'PC':
        return Icons.computer_rounded;
      case 'Mobile':
        return Icons.phone_android_rounded;
      case 'Console':
        return Icons.gamepad_rounded;
      default:
        return Icons.devices_rounded;
    }
  }
}
