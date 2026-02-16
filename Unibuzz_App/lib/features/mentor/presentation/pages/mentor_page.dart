import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';
import '../../../../core/widgets/page_transitions.dart';
import '../../data/mock_mentor_data.dart';
import '../widgets/mentor_card.dart';
import '../widgets/mentor_profile_popup.dart';
import 'mentor_request_page.dart';

class MentorPage extends StatefulWidget {
  const MentorPage({super.key});

  @override
  State<MentorPage> createState() => _MentorPageState();
}

class _MentorPageState extends State<MentorPage> with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  final _searchController = TextEditingController();
  late final AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  List<MentorModel> get _filteredMentors {
    if (_searchQuery.isEmpty) return MockMentorData.mentors;
    final q = _searchQuery.toLowerCase();
    return MockMentorData.mentors.where((m) {
      return m.name.toLowerCase().contains(q) ||
          m.profession.toLowerCase().contains(q) ||
          m.department.toLowerCase().contains(q) ||
          m.expertise.any((e) => e.toLowerCase().contains(q));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Ambient glow orbs ──
          Positioned(
            top: -100,
            right: -80,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, child) {
                return ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 90 + (_glowController.value * 20),
                    sigmaY: 90 + (_glowController.value * 20),
                  ),
                  child: child,
                );
              },
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.12),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: -60,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent.withValues(alpha: 0.04),
                ),
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: -40,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.neonCyan.withValues(alpha: 0.05),
                ),
              ),
            ),
          ),
          // ── Floating particles ──
          const Positioned.fill(
            child: IgnorePointer(
              child: ParticleField(
                particleCount: 10,
                color: Colors.white,
                maxSize: 1.5,
                minSize: 0.5,
              ),
            ),
          ),
          // ── Content ──
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                _buildSearchBar(),
                const SizedBox(height: 6),
                _buildMentorCount(),
                const SizedBox(height: 8),
                Expanded(child: _buildMentorGrid()),
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
              colors: [Colors.white, AppColors.primaryLight],
            ).createShader(bounds),
            child: Text(
              'FIND YOUR MENTOR',
              style: GoogleFonts.racingSansOne(color: Colors.white, fontSize: 22, letterSpacing: 1.0),
            ),
          ),
          const Spacer(),
          // Mentor count badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.school_rounded, color: AppColors.accent, size: 14),
                const SizedBox(width: 4),
                Text(
                  '${MockMentorData.mentors.length}',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        blur: 12,
        opacity: 0.06,
        color: Colors.white,
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: Colors.white.withValues(alpha: 0.3), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search by name, skill, or department...',
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.25), fontSize: 13),
                ),
              ),
            ),
            if (_searchQuery.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _searchController.clear();
                  setState(() => _searchQuery = '');
                },
                child: Icon(Icons.close_rounded, color: Colors.white.withValues(alpha: 0.3), size: 18),
              ),
          ],
        ),
      ),
    ).animate().fade(duration: 400.ms, delay: 100.ms).slideY(begin: 0.05, end: 0);
  }

  Widget _buildMentorCount() {
    final mentors = _filteredMentors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          Text(
            _searchQuery.isEmpty ? 'ALL MENTORS' : '${mentors.length} RESULT${mentors.length != 1 ? 'S' : ''}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const Spacer(),
          Container(
            width: 30,
            height: 3,
            decoration: BoxDecoration(
              gradient: AppColors.neonGradient,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentorGrid() {
    final mentors = _filteredMentors;

    if (mentors.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.56,
      ),
      itemCount: mentors.length,
      itemBuilder: (context, index) {
        final mentor = mentors[index];
        return MentorCard(
          mentor: mentor,
          index: index,
          onViewProfile: () => MentorProfilePopup.show(context, mentor),
          onSendRequest: () {
            Navigator.push(
              context,
              SlideUpRoute(page: MentorRequestPage(mentor: mentor)),
            );
          },
        )
            .animate()
            .fade(duration: 400.ms, delay: (80 * index).ms)
            .scaleXY(begin: 0.92, end: 1.0, duration: 400.ms, delay: (80 * index).ms, curve: Curves.easeOutBack);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
            ),
            child: Icon(Icons.search_off_rounded, color: AppColors.primaryLight.withValues(alpha: 0.5), size: 48),
          ),
          const SizedBox(height: 20),
          Text(
            'No mentors found',
            style: GoogleFonts.poppins(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try a different search term',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.25), fontSize: 13),
          ),
        ],
      ).animate().fade(duration: 400.ms).scale(begin: const Offset(0.9, 0.9)),
    );
  }
}
