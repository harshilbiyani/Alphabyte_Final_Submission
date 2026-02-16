import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';
import '../../data/mock_profile_data.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late List<String> _selectedInterests;
  bool _saved = false;

  final List<String> _allInterests = [
    'Technical', 'Cultural', 'Sports', 'Gaming', 'Music',
    'Coding', 'Debate', 'Art', 'Dance', 'Photography',
    'Literature', 'Robotics',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: MockProfileData.userName);
    _bioController = TextEditingController(text: 'CS student passionate about building cool stuff 🚀');
    _emailController = TextEditingController(text: MockProfileData.email);
    _phoneController = TextEditingController(text: '+91 98765 43210');
    _selectedInterests = List.from(MockProfileData.interests);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _save() async {
    HapticFeedback.mediumImpact();
    setState(() => _saved = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: -70,
            left: -50,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryLight.withValues(alpha: 0.08),
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
                    padding: const EdgeInsets.all(20),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar
                        _buildAvatarSection(),
                        const SizedBox(height: 28),
                        // Fields
                        _buildInputField('Display Name', _nameController, Icons.person_outline_rounded),
                        const SizedBox(height: 16),
                        _buildInputField('Bio', _bioController, Icons.info_outline_rounded, maxLines: 3),
                        const SizedBox(height: 16),
                        _buildInputField('Email', _emailController, Icons.email_outlined),
                        const SizedBox(height: 16),
                        _buildInputField('Phone', _phoneController, Icons.phone_outlined),
                        const SizedBox(height: 28),
                        // Interests
                        _buildInterestsSection(),
                        const SizedBox(height: 36),
                        // Save
                        _buildSaveButton(),
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
              'EDIT PROFILE',
              style: GoogleFonts.racingSansOne(color: Colors.white, fontSize: 20, letterSpacing: 1.0),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildAvatarSection() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.accent, AppColors.neonCyan, AppColors.primary],
              ),
              boxShadow: [
                BoxShadow(color: AppColors.accent.withValues(alpha: 0.3), blurRadius: 22, spreadRadius: 2),
              ],
            ),
            padding: const EdgeInsets.all(3),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.background, width: 3),
              ),
              child: const Icon(Icons.camera_alt_rounded, color: Colors.black, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, IconData icon, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.0),
        ),
        const SizedBox(height: 8),
        GlassContainer(
          borderRadius: BorderRadius.circular(16),
          blur: 10,
          opacity: 0.05,
          color: Colors.white,
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: Icon(icon, color: AppColors.primaryLight.withValues(alpha: 0.5), size: 20),
              ),
              prefixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 40),
              hintText: 'Enter $label...',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2), fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInterestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'YOUR INTERESTS',
          style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.0),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _allInterests.map((interest) {
            final isSelected = _selectedInterests.contains(interest);
            return GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() {
                  if (isSelected) {
                    _selectedInterests.remove(interest);
                  } else {
                    _selectedInterests.add(interest);
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accent : Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.accent : Colors.white.withValues(alpha: 0.1),
                  ),
                  boxShadow: isSelected
                      ? [BoxShadow(color: AppColors.accent.withValues(alpha: 0.2), blurRadius: 8)]
                      : [],
                ),
                child: Text(
                  interest,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white60,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: _saved ? null : const LinearGradient(colors: [AppColors.accent, Color(0xFFB8E62E)]),
        color: _saved ? AppColors.success : null,
        boxShadow: [
          BoxShadow(
            color: (_saved ? AppColors.success : AppColors.accent).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _saved ? null : _save,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        child: _saved
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text('Saved!', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                ],
              )
            : Text(
                'SAVE CHANGES',
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15, letterSpacing: 0.5),
              ),
      ),
    );
  }
}
