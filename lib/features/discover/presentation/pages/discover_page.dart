import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/data/mock_home_data.dart';
import '../widgets/discover_swipe_deck.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    final events = [...MockHomeData.urgentEvents, ...MockHomeData.feedEvents];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Text(
                'DISCOVER',
                style: TextStyle(
                  fontFamily: 'Racing Sans One',
                  color: Colors.white,
                  fontSize: 26,
                  letterSpacing: 1.6,
                ),
              ),
            ),
            Expanded(child: DiscoverSwipeDeck(events: events)),
          ],
        ),
      ),
    );
  }
}
