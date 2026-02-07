import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/data/mock_home_data.dart';
import '../widgets/discover_event_card.dart';
import '../widgets/interest_filter_tabs.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String _selectedTab = 'All';

  List<EventModel> get _filteredEvents {
    final allEvents = [...MockHomeData.urgentEvents, ...MockHomeData.feedEvents];

    if (_selectedTab == 'All') {
        return allEvents;
    }
    
    return allEvents.where((e) {
         if (_selectedTab == 'Technical') return ['Tech', 'Workshop', 'Guest Lectures'].contains(e.category);
         if (_selectedTab == 'Non-Technical') return !['Tech', 'Workshop', 'Guest Lectures', 'Sports', 'Gaming'].contains(e.category);
         if (_selectedTab == 'Sports') return e.category == 'Sports';
         if (_selectedTab == 'Gaming') return e.category == 'Gaming';
         if (_selectedTab == 'Guest Lectures') return e.category == 'Guest Lectures';
         if (_selectedTab == 'Cultural') return ['Cultural', 'Music', 'Entertainment'].contains(e.category);
         return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Sort logic: Sort by date or interest? 
    // Requirement says "Explore interested and not interested".
    // Let's put Interested ones first visually but mixed in feed? 
    // For now, simple list.
    
    final events = _filteredEvents;

    return Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
            // Sticky Header
            SliverAppBar(
            backgroundColor: AppColors.background.withOpacity(0.9),
            elevation: 0,
            pinned: true,
            floating: true,
            expandedHeight: 120, // Enough for Discover + Tab Bar
            flexibleSpace: FlexibleSpaceBar(
                background: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent),
                ),
                titlePadding: const EdgeInsets.only(left: 20, bottom: 60),
                title: const Text(
                'DISCOVER',
                style: TextStyle(
                    fontFamily: 'Racing Sans One',
                    color: Colors.white,
                    fontSize: 24,
                    letterSpacing: 1.5,
                ),
                ),
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                    height: 50,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InterestFilterTabs(
                        selectedTab: _selectedTab,
                        onTabSelected: (val) => setState(() => _selectedTab = val),
                    ),
                ),
            ),
            ),

            // Empty State or List
            if (events.isEmpty)
            SliverFillRemaining(
                child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Icon(Icons.search_off, size: 60, color: Colors.white24),
                    const SizedBox(height: 16),
                    Text(
                        "No events here yet — check other vibes 👀",
                        style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 16,
                        ),
                    ),
                    ],
                ),
                ),
            )
            else
            SliverList(
                delegate: SliverChildBuilderDelegate(
                (context, index) {
                    if (index == events.length) return const SizedBox(height: 100); // Bottom padding
                    return DiscoverEventCard(event: events[index]);
                },
                childCount: events.length + 1,
                ),
            ),
        ],
        ),
    );
  }
}
