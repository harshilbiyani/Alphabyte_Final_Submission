import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';
import '../../../home/data/mock_home_data.dart';
import 'confirm_participation_page.dart';

class CreateTeamPage extends StatefulWidget {
  final EventModel event;

  const CreateTeamPage({super.key, required this.event});

  @override
  State<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  final _teamNameController = TextEditingController();
  final _searchController = TextEditingController();
  final List<Map<String, String>> _teamMembers = [];
  bool _showSearchResults = false;

  // Mock search results
  final List<Map<String, String>> _allStudents = const [
    {'name': 'Aarav Sharma', 'prn': '1032210101', 'dept': 'Computer Science'},
    {'name': 'Priya Patel', 'prn': '1032210202', 'dept': 'IT'},
    {'name': 'Rohan Mehta', 'prn': '1032210303', 'dept': 'Computer Science'},
    {'name': 'Sneha Joshi', 'prn': '1032210404', 'dept': 'Electronics'},
    {'name': 'Karan Singh', 'prn': '1032210505', 'dept': 'Mechanical'},
    {'name': 'Ananya Reddy', 'prn': '1032210606', 'dept': 'Computer Science'},
    {'name': 'Vikram Desai', 'prn': '1032210707', 'dept': 'IT'},
    {'name': 'Meera Iyer', 'prn': '1032210808', 'dept': 'Computer Science'},
  ];

  @override
  void initState() {
    super.initState();
    // Add self as first member (team leader)
    _teamMembers.add({
      'name': 'Ansh D',
      'prn': '1032210899',
      'dept': 'Computer Science',
      'role': 'Team Leader',
    });
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _getFilteredStudents() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) return [];
    final memberPRNs = _teamMembers.map((m) => m['prn']).toSet();
    return _allStudents.where((s) {
      return !memberPRNs.contains(s['prn']) &&
          (s['name']!.toLowerCase().contains(query) || s['prn']!.contains(query));
    }).toList();
  }

  void _addMember(Map<String, String> student) {
    if (_teamMembers.length >= widget.event.maxTeamSize) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Maximum ${widget.event.maxTeamSize} members allowed'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    HapticFeedback.lightImpact();
    setState(() {
      _teamMembers.add({...student, 'role': 'Member'});
      _searchController.clear();
      _showSearchResults = false;
    });
  }

  void _removeMember(int index) {
    if (index == 0) return; // Can't remove team leader
    HapticFeedback.lightImpact();
    setState(() => _teamMembers.removeAt(index));
  }

  void _proceed() {
    if (_teamNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a team name'), backgroundColor: AppColors.error),
      );
      return;
    }
    if (_teamMembers.length < widget.event.minTeamSize) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Minimum ${widget.event.minTeamSize} members required'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    HapticFeedback.mediumImpact();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmParticipationPage(
          event: widget.event,
          teamName: _teamNameController.text.trim(),
          teamMembers: _teamMembers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient orbs
          Positioned(
            top: -60,
            left: -40,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.neonCyan.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            right: -50,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.06),
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
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event mini card
                        _buildEventMiniCard(),
                        const SizedBox(height: 24),
                        // Team name input
                        _buildTeamNameInput(),
                        const SizedBox(height: 24),
                        // Team size indicator
                        _buildTeamSizeIndicator(),
                        const SizedBox(height: 20),
                        // Search for members
                        _buildMemberSearch(),
                        if (_showSearchResults) ...[
                          const SizedBox(height: 8),
                          _buildSearchResults(),
                        ],
                        const SizedBox(height: 24),
                        // Team members list
                        _buildTeamMembersList(),
                        const SizedBox(height: 32),
                        // Proceed button
                        _buildProceedButton(),
                        const SizedBox(height: 40),
                      ].animate(interval: 60.ms).fade(duration: 400.ms).slideY(begin: 0.04, end: 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white.withValues(alpha: 0.03), Colors.transparent],
            ),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
              ),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.white, AppColors.neonCyan],
                ).createShader(bounds),
                child: Text(
                  'CREATE YOUR TEAM',
                  style: GoogleFonts.racingSansOne(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildEventMiniCard() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(16),
      blur: 10,
      opacity: 0.08,
      color: AppColors.primary,
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.event.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 50,
                height: 50,
                color: Colors.grey[900],
                child: const Icon(Icons.broken_image, color: Colors.white24, size: 20),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event.title,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  '${widget.event.date} • ${widget.event.venue}',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TEAM NAME',
          style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        const SizedBox(height: 8),
        GlassContainer(
          borderRadius: BorderRadius.circular(16),
          blur: 10,
          opacity: 0.06,
          color: Colors.white,
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          child: TextField(
            controller: _teamNameController,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: 'Enter your team name...',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.25), fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(18),
              prefixIcon: Icon(Icons.groups_rounded, color: AppColors.accent.withValues(alpha: 0.6), size: 22),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTeamSizeIndicator() {
    final current = _teamMembers.length;
    final max = widget.event.maxTeamSize;
    final min = widget.event.minTeamSize;
    final isValid = current >= min;

    return GlassContainer(
      borderRadius: BorderRadius.circular(14),
      blur: 8,
      opacity: 0.06,
      color: isValid ? AppColors.accent : AppColors.primary,
      border: Border.all(
        color: isValid
            ? AppColors.accent.withValues(alpha: 0.2)
            : AppColors.primary.withValues(alpha: 0.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle_rounded : Icons.info_outline_rounded,
            color: isValid ? AppColors.accent : AppColors.primaryLight,
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(
            '$current / $max members',
            style: TextStyle(
              color: isValid ? AppColors.accent : Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            isValid ? 'Ready to go!' : 'Min $min required',
            style: TextStyle(
              color: isValid ? AppColors.accent.withValues(alpha: 0.7) : Colors.white38,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ADD TEAM MEMBERS',
          style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        const SizedBox(height: 8),
        GlassContainer(
          borderRadius: BorderRadius.circular(16),
          blur: 10,
          opacity: 0.06,
          color: Colors.white,
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          child: TextField(
            controller: _searchController,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
            onChanged: (value) {
              setState(() => _showSearchResults = value.isNotEmpty);
            },
            decoration: InputDecoration(
              hintText: 'Search by name or PRN...',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.25), fontSize: 13),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              prefixIcon: Icon(Icons.search_rounded, color: AppColors.primaryLight.withValues(alpha: 0.6), size: 20),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _showSearchResults = false);
                      },
                      icon: Icon(Icons.close_rounded, color: Colors.white.withValues(alpha: 0.4), size: 18),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    final results = _getFilteredStudents();
    if (results.isEmpty) {
      return GlassContainer(
        borderRadius: BorderRadius.circular(14),
        blur: 8,
        opacity: 0.04,
        color: Colors.white,
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            'No students found',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13),
          ),
        ),
      );
    }

    return GlassContainer(
      borderRadius: BorderRadius.circular(14),
      blur: 10,
      opacity: 0.04,
      color: Colors.white,
      border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      child: Column(
        children: results.map((student) {
          return InkWell(
            onTap: () => _addMember(student),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        student['name']![0],
                        style: TextStyle(color: AppColors.primaryLight, fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student['name']!,
                          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${student['prn']} • ${student['dept']}',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.add_rounded, color: AppColors.accent, size: 16),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTeamMembersList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'YOUR TEAM',
          style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        const SizedBox(height: 10),
        ...List.generate(_teamMembers.length, (index) {
          final member = _teamMembers[index];
          final isLeader = index == 0;
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: GlassContainer(
              borderRadius: BorderRadius.circular(16),
              blur: 10,
              opacity: isLeader ? 0.08 : 0.04,
              color: isLeader ? AppColors.accent : Colors.white,
              border: Border.all(
                color: isLeader
                    ? AppColors.accent.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.08),
              ),
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isLeader
                            ? [AppColors.accent.withValues(alpha: 0.3), AppColors.accent.withValues(alpha: 0.1)]
                            : [AppColors.primary.withValues(alpha: 0.2), AppColors.primary.withValues(alpha: 0.08)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: isLeader
                          ? Icon(Icons.star_rounded, color: AppColors.accent, size: 20)
                          : Text(
                              member['name']![0],
                              style: TextStyle(
                                color: AppColors.primaryLight,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              member['name']!,
                              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            if (isLeader) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.accent.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'LEADER',
                                  style: TextStyle(color: AppColors.accent, fontSize: 8, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${member['prn']} • ${member['dept']}',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  if (!isLeader)
                    GestureDetector(
                      onTap: () => _removeMember(index),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.close_rounded, color: AppColors.error, size: 16),
                      ),
                    ),
                ],
              ),
            ),
          ).animate(delay: (60 * index).ms).fadeIn(duration: 300.ms).slideX(begin: 0.05, end: 0);
        }),
      ],
    );
  }

  Widget _buildProceedButton() {
    final isValid = _teamMembers.length >= widget.event.minTeamSize &&
        _teamNameController.text.trim().isNotEmpty;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: isValid
            ? const LinearGradient(colors: [AppColors.accent, Color(0xFFB8E62E)])
            : null,
        color: isValid ? null : Colors.white.withValues(alpha: 0.06),
        boxShadow: isValid
            ? [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ]
            : [],
      ),
      child: ElevatedButton(
        onPressed: _proceed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_forward_rounded, color: isValid ? Colors.black : Colors.white38, size: 20),
            const SizedBox(width: 8),
            Text(
              'PROCEED TO CONFIRM',
              style: GoogleFonts.poppins(
                color: isValid ? Colors.black : Colors.white38,
                fontWeight: FontWeight.w800,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
