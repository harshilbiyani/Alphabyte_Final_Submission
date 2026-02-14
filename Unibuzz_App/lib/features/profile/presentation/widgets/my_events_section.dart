import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/mock_profile_data.dart';
import '../../../home/data/mock_home_data.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyEventsSection extends StatefulWidget {
  const MyEventsSection({super.key});

  @override
  State<MyEventsSection> createState() => _MyEventsSectionState();
}

class _MyEventsSectionState extends State<MyEventsSection> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['Registered', 'Attended', 'Past'];

  @override
  Widget build(BuildContext context) {
    List<EventModel> events;
    switch (_selectedTabIndex) {
      case 0:
        events = MockProfileData.registeredEvents;
        break;
      case 1:
        events = MockProfileData.attendedEvents;
        break;
      case 2:
        events = MockProfileData.pastEvents;
        break;
      default:
        events = [];
    }

    return Column(
      children: [
        // Glass tab bar
        GlassContainer(
          borderRadius: BorderRadius.circular(20),
          blur: 8,
          opacity: 0.06,
          color: Colors.white,
          child: Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: List.generate(_tabs.length, (index) {
                final isSelected = _selectedTabIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTabIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        _tabs[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white60,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),

        // List
        SizedBox(
          height: 140,
          child: events.isEmpty
              ? Center(
                  child: Text(
                    "No events found",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: events.length,
                  itemBuilder: (context, index) =>
                      _buildMiniEventCard(events[index])
                          .animate()
                          .fade(delay: (60 * index).ms, duration: 400.ms)
                          .slideX(begin: 0.08, end: 0, curve: Curves.easeOut),
                ),
        ),
      ],
    );
  }

  Widget _buildMiniEventCard(EventModel event) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 12),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        blur: 8,
        opacity: 0.07,
        color: Colors.white,
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              child: Image.network(
                event.imageUrl,
                width: 80,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: double.infinity,
                    color: Colors.grey[900],
                    child: const Icon(Icons.broken_image, color: Colors.white24, size: 24),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      event.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.date,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _getStatusColor(_selectedTabIndex).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _getStatusColor(_selectedTabIndex).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        _tabs[_selectedTabIndex].toUpperCase(),
                        style: TextStyle(
                          color: _getStatusColor(_selectedTabIndex),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFC6FF33);
      case 1:
        return AppColors.primary;
      case 2:
        return Colors.grey;
      default:
        return Colors.white;
    }
  }
}
