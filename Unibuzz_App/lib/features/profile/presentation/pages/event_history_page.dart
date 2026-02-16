import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';

class EventHistoryPage extends StatefulWidget {
  const EventHistoryPage({super.key});

  @override
  State<EventHistoryPage> createState() => _EventHistoryPageState();
}

class _EventHistoryPageState extends State<EventHistoryPage> {
  int _selectedTab = 0;
  final _tabs = ['All', 'Attended', 'Missed', 'Upcoming'];

  // Mock event history data
  static final List<Map<String, dynamic>> _events = [
    {
      'title': 'Hackathon 24',
      'date': 'Jan 15, 2026',
      'status': 'attended',
      'role': 'Team Lead',
      'image': 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=300&q=80',
    },
    {
      'title': 'AI Workshop',
      'date': 'Jan 22, 2026',
      'status': 'attended',
      'role': 'Participant',
      'image': 'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=300&q=80',
    },
    {
      'title': 'Neon Night',
      'date': 'Feb 01, 2026',
      'status': 'attended',
      'role': 'Participant',
      'image': 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=300&q=80',
    },
    {
      'title': 'Cultural Fest Opening',
      'date': 'Feb 05, 2026',
      'status': 'missed',
      'role': 'Registered',
      'image': 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=300&q=80',
    },
    {
      'title': 'Debate Championship',
      'date': 'Feb 08, 2026',
      'status': 'attended',
      'role': 'Participant',
      'image': 'https://images.unsplash.com/photo-1475721027785-f74eccf877e2?w=300&q=80',
    },
    {
      'title': 'Code Sprint',
      'date': 'Feb 10, 2026',
      'status': 'attended',
      'role': 'Team Lead',
      'image': 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=300&q=80',
    },
    {
      'title': 'Photography Walk',
      'date': 'Feb 12, 2026',
      'status': 'missed',
      'role': 'Registered',
      'image': 'https://images.unsplash.com/photo-1452587925148-ce544e77e70d?w=300&q=80',
    },
    {
      'title': 'Startup Pitch Night',
      'date': 'Feb 14, 2026',
      'status': 'attended',
      'role': 'Participant',
      'image': 'https://images.unsplash.com/photo-1559136555-9303baea8ebd?w=300&q=80',
    },
    {
      'title': 'Flutter Dev Day',
      'date': 'Feb 20, 2026',
      'status': 'upcoming',
      'role': 'Registered',
      'image': 'https://images.unsplash.com/photo-1551650975-87deedd944c3?w=300&q=80',
    },
    {
      'title': 'Music Jam Night',
      'date': 'Feb 22, 2026',
      'status': 'upcoming',
      'role': 'Registered',
      'image': 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=300&q=80',
    },
    {
      'title': 'E-Sports Tournament',
      'date': 'Feb 25, 2026',
      'status': 'upcoming',
      'role': 'Team Lead',
      'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=300&q=80',
    },
    {
      'title': 'Open Mic Night',
      'date': 'Feb 28, 2026',
      'status': 'upcoming',
      'role': 'Registered',
      'image': 'https://images.unsplash.com/photo-1516280440614-37939bbacd81?w=300&q=80',
    },
  ];

  List<Map<String, dynamic>> get _filteredEvents {
    if (_selectedTab == 0) return _events;
    final status = ['all', 'attended', 'missed', 'upcoming'][_selectedTab];
    return _events.where((e) => e['status'] == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: -60,
            right: -40,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.10),
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: IgnorePointer(
              child: ParticleField(particleCount: 8, color: Colors.white, maxSize: 1.0, minSize: 0.5),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildTabs(),
                const SizedBox(height: 16),
                Expanded(child: _buildEventList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          ),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.white, AppColors.accent],
            ).createShader(bounds),
            child: Text(
              'EVENT HISTORY',
              style: GoogleFonts.racingSansOne(color: Colors.white, fontSize: 20, letterSpacing: 1.0),
            ),
          ),
          const Spacer(),
          Text(
            '${_events.length} events',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13),
          ),
          const SizedBox(width: 16),
        ],
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(_tabs.length, (i) {
          final selected = _selectedTab == i;
          final count = i == 0
              ? _events.length
              : _events.where((e) => e['status'] == ['all', 'attended', 'missed', 'upcoming'][i]).length;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedTab = i);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? AppColors.accent : Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected ? AppColors.accent : Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _tabs[i],
                      style: TextStyle(
                        color: selected ? Colors.black : Colors.white60,
                        fontSize: 13,
                        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$count',
                      style: TextStyle(
                        color: selected ? Colors.black54 : Colors.white30,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildEventList() {
    final events = _filteredEvents;
    if (events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy_rounded, color: Colors.white.withValues(alpha: 0.15), size: 56),
            const SizedBox(height: 12),
            Text('No events found', style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 14)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const BouncingScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return _buildEventCard(event, index);
      },
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event, int index) {
    final statusColor = _statusColor(event['status']);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(18),
        blur: 10,
        opacity: 0.05,
        color: Colors.white,
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.network(
                event['image'],
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 64,
                  height: 64,
                  color: Colors.grey[900],
                  child: const Icon(Icons.broken_image, color: Colors.white24, size: 20),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'],
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${event['date']} • ${event['role']}',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11),
                  ),
                ],
              ),
            ),
            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: statusColor.withValues(alpha: 0.25)),
              ),
              child: Text(
                (event['status'] as String).toUpperCase(),
                style: TextStyle(color: statusColor, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5),
              ),
            ),
          ],
        ),
      ),
    ).animate(delay: (50 * index).ms).fadeIn(duration: 300.ms).slideX(begin: 0.04, end: 0);
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'attended':
        return AppColors.success;
      case 'missed':
        return AppColors.error;
      case 'upcoming':
        return AppColors.neonCyan;
      default:
        return Colors.white54;
    }
  }
}
