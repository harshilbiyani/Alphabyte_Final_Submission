import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_fest_data.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class FestCard extends StatelessWidget {
  final FestModel fest;
  final VoidCallback? onTap;

  static const Color _accent = Color(0xFFE040FB);

  const FestCard({super.key, required this.fest, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [BoxShadow(color: _accent.withOpacity(.1), blurRadius: 20)],
        ),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(22),
          opacity: .08,
          blur: 18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Big poster image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                child: Stack(
                  children: [
                    Image.network(
                      fest.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 200,
                        color: _accent.withOpacity(.15),
                        child: Center(child: Icon(Icons.celebration_rounded, color: _accent.withOpacity(.5), size: 50)),
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.3, 1.0],
                            colors: [Colors.transparent, Colors.black.withOpacity(.85)],
                          ),
                        ),
                      ),
                    ),
                    // Live badge
                    if (fest.isLive)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(color: Colors.redAccent.withOpacity(.5), blurRadius: 10)],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                              const SizedBox(width: 6),
                              Text('HAPPENING NOW', style: GoogleFonts.poppins(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ).animate(onPlay: (c) => c.repeat(reverse: true)).fade(begin: 1, end: .6, duration: 1000.ms),
                      ),
                    // Date badge
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _accent.withOpacity(.4)),
                        ),
                        child: Text(
                          '${fest.startDate} – ${fest.endDate}',
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    // Title + tagline overlay
                    Positioned(
                      bottom: 14,
                      left: 14,
                      right: 14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fest.name,
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800, height: 1.1),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            fest.tagline,
                            style: GoogleFonts.poppins(color: _accent, fontSize: 12, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fest.description,
                      style: GoogleFonts.poppins(color: Colors.white.withOpacity(.6), fontSize: 12, height: 1.4),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 14),
                    // Highlights
                    if (fest.highlights.isNotEmpty) ...[
                      Text('Highlights', style: GoogleFonts.poppins(color: Colors.white.withOpacity(.8), fontSize: 13, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: fest.highlights.map((h) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: _accent.withOpacity(.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _accent.withOpacity(.25)),
                          ),
                          child: Text(h, style: GoogleFonts.poppins(color: _accent, fontSize: 11, fontWeight: FontWeight.w500)),
                        )).toList(),
                      ),
                      const SizedBox(height: 14),
                    ],
                    // Schedule preview
                    if (fest.schedule.isNotEmpty) ...[
                      Text('Schedule', style: GoogleFonts.poppins(color: Colors.white.withOpacity(.8), fontSize: 13, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      ...fest.schedule.map((day) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.04),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white.withOpacity(.06)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(day.day, style: GoogleFonts.poppins(color: _accent, fontSize: 12, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text(
                                day.events.join(' → '),
                                style: GoogleFonts.poppins(color: Colors.white.withOpacity(.55), fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(height: 6),
                    ],
                    // Bottom stats
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.04),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          _stat(Icons.location_on_rounded, fest.venue),
                          _stat(Icons.people_rounded, '${fest.expectedFootfall}+ footfall'),
                        ],
                      ),
                    ),
                    if (fest.sponsors.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.handshake_rounded, color: Colors.white.withOpacity(.4), size: 14),
                          const SizedBox(width: 5),
                          Text('Sponsors: ', style: GoogleFonts.poppins(color: Colors.white.withOpacity(.4), fontSize: 11)),
                          Expanded(
                            child: Text(
                              fest.sponsors.join(' • '),
                              style: GoogleFonts.poppins(color: _accent.withOpacity(.6), fontSize: 11, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: .06, end: 0, duration: 500.ms);
  }

  Widget _stat(IconData icon, String text) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _accent.withOpacity(.7), size: 14),
          const SizedBox(width: 5),
          Flexible(
            child: Text(text, style: GoogleFonts.poppins(color: Colors.white.withOpacity(.55), fontSize: 11), overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
