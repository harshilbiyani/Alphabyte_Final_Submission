import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';
import '../../data/mock_hackathon_data.dart';
import '../../../shared/widgets/filter_sort_bar.dart';
import '../../../shared/widgets/empty_state_widget.dart';
import '../widgets/hackathon_card.dart';

class HackathonPage extends StatefulWidget {
  const HackathonPage({super.key});

  @override
  State<HackathonPage> createState() => _HackathonPageState();
}

class _HackathonPageState extends State<HackathonPage> {
  static const _accent = Color(0xFF00FF87);
  String _modeFilter = 'All';
  String _sortBy = 'Date';
  String _searchQuery = '';
  final _searchController = TextEditingController();

  static const _modeFilters = ['All', 'Online', 'Offline', 'Hybrid'];
  static const _sortOptions = ['Date', 'Prize Pool', 'Team Size', 'Popularity'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<HackathonModel> get _filtered {
    var list = MockHackathonData.hackathons.where((h) {
      if (_modeFilter != 'All' && h.mode != _modeFilter) return false;
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        return h.title.toLowerCase().contains(q) ||
            h.organizer.toLowerCase().contains(q) ||
            h.tracks.any((t) => t.toLowerCase().contains(q));
      }
      return true;
    }).toList();

    // Sort
    switch (_sortBy) {
      case 'Date':
        list.sort((a, b) => a.startDate.compareTo(b.startDate));
        break;
      case 'Prize Pool':
        // Reverse so highest prize first
        list.sort((a, b) => _parseAmount(b.prizePool).compareTo(_parseAmount(a.prizePool)));
        break;
      case 'Team Size':
        list.sort((a, b) => a.maxTeamSize.compareTo(b.maxTeamSize));
        break;
      case 'Popularity':
        list.sort((a, b) => b.registeredTeams.compareTo(a.registeredTeams));
        break;
    }

    // Put live ones first
    list.sort((a, b) {
      if (a.isLive && !b.isLive) return -1;
      if (!a.isLive && b.isLive) return 1;
      return 0;
    });

    return list;
  }

  int _parseAmount(String s) {
    return int.tryParse(s.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient glow
          Positioned(
            top: -100,
            left: -80,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(shape: BoxShape.circle, color: _accent.withValues(alpha: 0.08)),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: -60,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(shape: BoxShape.circle, color: _accent.withValues(alpha: 0.04)),
              ),
            ),
          ),
          const Positioned.fill(
            child: IgnorePointer(child: ParticleField(particleCount: 8, color: Color(0xFF00FF87), maxSize: 1.5, minSize: 0.5)),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                _buildSearchBar(),
                const SizedBox(height: 8),
                FilterSortBar(
                  filters: _modeFilters,
                  selectedFilter: _modeFilter,
                  onFilterSelected: (f) => setState(() => _modeFilter = f),
                  sortOptions: _sortOptions,
                  selectedSort: _sortBy,
                  onSortSelected: (s) => setState(() => _sortBy = s),
                  accentColor: _accent,
                ),
                const SizedBox(height: 10),
                Expanded(child: _buildList()),
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
          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20)),
          Text('> ', style: GoogleFonts.firaCode(color: _accent, fontSize: 20, fontWeight: FontWeight.w700)),
          ShaderMask(
            shaderCallback: (b) => const LinearGradient(colors: [_accent, AppColors.neonCyan]).createShader(b),
            child: Text('HACKATHONS_', style: GoogleFonts.firaCode(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
          ),
          _BlinkingCursor(color: _accent),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: _accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: _accent.withValues(alpha: 0.2))),
            child: Text('${MockHackathonData.hackathons.length}', style: TextStyle(color: _accent, fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(14),
        blur: 10,
        opacity: 0.05,
        color: Colors.white,
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: Colors.white.withValues(alpha: 0.25), size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search hackathons, tracks, organizers...',
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2), fontSize: 13),
                ),
              ),
            ),
            if (_searchQuery.isNotEmpty)
              GestureDetector(
                onTap: () { _searchController.clear(); setState(() => _searchQuery = ''); },
                child: Icon(Icons.close_rounded, color: Colors.white.withValues(alpha: 0.3), size: 16),
              ),
          ],
        ),
      ),
    ).animate().fade(duration: 400.ms, delay: 80.ms);
  }

  Widget _buildList() {
    final items = _filtered;
    if (items.isEmpty) {
      return const EmptyStateWidget(icon: Icons.memory_rounded, title: 'No hackathons found', color: _accent);
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 80, top: 4),
      itemCount: items.length,
      itemBuilder: (context, i) {
        return HackathonCard(hackathon: items[i], onTap: () {})
            .animate().fade(duration: 400.ms, delay: (60 * i).ms).slideY(begin: 0.05, end: 0);
      },
    );
  }
}

/// Blinking cursor for the terminal-style header.
class _BlinkingCursor extends StatefulWidget {
  final Color color;
  const _BlinkingCursor({required this.color});
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600))..repeat(reverse: true);
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Opacity(
        opacity: _ctrl.value,
        child: Container(width: 10, height: 22, margin: const EdgeInsets.only(left: 2), color: widget.color),
      ),
    );
  }
}
