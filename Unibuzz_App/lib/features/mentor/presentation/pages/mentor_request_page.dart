import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';
import '../../data/mock_mentor_data.dart';
import '../widgets/mentor_thank_you_dialog.dart';

class MentorRequestPage extends StatefulWidget {
  final MentorModel mentor;

  const MentorRequestPage({super.key, required this.mentor});

  @override
  State<MentorRequestPage> createState() => _MentorRequestPageState();
}

class _MentorRequestPageState extends State<MentorRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();
  final _eventNameController = TextEditingController();
  final _problemStatementController = TextEditingController();
  final _teamMembersController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedEventType;
  DateTime? _eventStartDate;
  DateTime? _eventEndDate;

  static const List<String> _eventTypes = [
    'Hackathon',
    'Project Exhibition',
    'Research Paper',
    'Workshop',
    'Competition',
    'Startup Pitch',
    'Other',
  ];

  @override
  void dispose() {
    _teamNameController.dispose();
    _eventNameController.dispose();
    _problemStatementController.dispose();
    _teamMembersController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _eventStartDate = picked;
        } else {
          _eventEndDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      HapticFeedback.heavyImpact();
      MentorThankYouDialog.show(context, widget.mentor.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient glow orbs
          Positioned(
            top: -80,
            right: -60,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.1),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -50,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.neonCyan.withValues(alpha: 0.05),
                ),
              ),
            ),
          ),
          // Particle field
          const Positioned.fill(
            child: IgnorePointer(
              child: ParticleField(particleCount: 6, color: Colors.white, maxSize: 1.0, minSize: 0.5),
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Mentor info strip
                          _buildMentorStrip(),
                          const SizedBox(height: 24),
                          // Form sections
                          _buildSectionLabel('TEAM DETAILS'),
                          const SizedBox(height: 10),
                          _buildGlassField(
                            controller: _teamNameController,
                            label: 'Team Name',
                            hint: 'e.g., Code Crusaders',
                            icon: Icons.groups_rounded,
                            validator: (v) => v == null || v.isEmpty ? 'Team name is required' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildGlassField(
                            controller: _teamMembersController,
                            label: 'Team Members (Name, Dept)',
                            hint: 'e.g., Harsh — CS, Priya — IT, Raj — ENTC',
                            icon: Icons.person_add_rounded,
                            maxLines: 3,
                            validator: (v) => v == null || v.isEmpty ? 'Add team members' : null,
                          ),
                          const SizedBox(height: 24),
                          _buildSectionLabel('EVENT DETAILS'),
                          const SizedBox(height: 10),
                          _buildGlassField(
                            controller: _eventNameController,
                            label: 'Event Name',
                            hint: 'e.g., SIH 2026',
                            icon: Icons.event_rounded,
                            validator: (v) => v == null || v.isEmpty ? 'Event name is required' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildEventTypeDropdown(),
                          const SizedBox(height: 12),
                          _buildDatePickers(),
                          const SizedBox(height: 12),
                          _buildGlassField(
                            controller: _problemStatementController,
                            label: 'Problem Statement',
                            hint: 'Briefly describe the PS or track',
                            icon: Icons.lightbulb_rounded,
                            maxLines: 2,
                            validator: (v) => v == null || v.isEmpty ? 'Problem statement is required' : null,
                          ),
                          const SizedBox(height: 24),
                          _buildSectionLabel('WHY THIS MENTOR?'),
                          const SizedBox(height: 10),
                          _buildGlassField(
                            controller: _descriptionController,
                            label: 'Tell us more',
                            hint:
                                'Describe your project, the problem you\'re solving, and why you\'d like ${widget.mentor.name.split(' ').first} as your mentor...',
                            icon: Icons.edit_note_rounded,
                            maxLines: 6,
                            validator: (v) => v == null || v.length < 20 ? 'Write at least 20 characters' : null,
                          ),
                          const SizedBox(height: 32),
                          // Submit button
                          _buildSubmitButton(),
                          const SizedBox(height: 40),
                        ].animate(interval: 50.ms).fade(duration: 400.ms).slideY(begin: 0.04, end: 0),
                      ),
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
          Expanded(
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.white, AppColors.primaryLight],
              ).createShader(bounds),
              child: Text(
                'MENTOR REQUEST',
                style: GoogleFonts.racingSansOne(color: Colors.white, fontSize: 20, letterSpacing: 1.0),
              ),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildMentorStrip() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(18),
      blur: 12,
      opacity: 0.06,
      color: AppColors.primary,
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.primaryLight, AppColors.primary],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.background,
              ),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.surfaceLight,
                backgroundImage: NetworkImage(widget.mentor.imageUrl),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Requesting mentorship from',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 10),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.mentor.name,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  widget.mentor.profession,
                  style: TextStyle(
                    color: AppColors.primaryLight.withValues(alpha: 0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.school_rounded, color: AppColors.accent, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white54,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildGlassField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(16),
      blur: 10,
      opacity: 0.05,
      color: Colors.white,
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          icon: Icon(icon, color: AppColors.primaryLight.withValues(alpha: 0.6), size: 20),
          border: InputBorder.none,
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.2),
            fontSize: 12,
          ),
          errorStyle: const TextStyle(color: AppColors.error, fontSize: 10),
        ),
      ),
    );
  }

  Widget _buildEventTypeDropdown() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(16),
      blur: 10,
      opacity: 0.05,
      color: Colors.white,
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButtonFormField<String>(
        value: _selectedEventType,
        dropdownColor: AppColors.surface,
        icon: Icon(Icons.expand_more_rounded, color: Colors.white.withValues(alpha: 0.3)),
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          icon: Icon(Icons.category_rounded, color: AppColors.primaryLight.withValues(alpha: 0.6), size: 20),
          border: InputBorder.none,
          labelText: 'Event Type',
          labelStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        validator: (v) => v == null ? 'Select event type' : null,
        items: _eventTypes.map((type) {
          return DropdownMenuItem(
            value: type,
            child: Text(type, style: const TextStyle(fontSize: 13)),
          );
        }).toList(),
        onChanged: (v) => setState(() => _selectedEventType = v),
      ),
    );
  }

  Widget _buildDatePickers() {
    return Row(
      children: [
        Expanded(child: _buildDateTile('Start Date', _eventStartDate, () => _pickDate(true))),
        const SizedBox(width: 10),
        Expanded(child: _buildDateTile('End Date', _eventEndDate, () => _pickDate(false))),
      ],
    );
  }

  Widget _buildDateTile(String label, DateTime? date, VoidCallback onTap) {
    final display = date != null
        ? '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}'
        : 'Select';
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        blur: 10,
        opacity: 0.05,
        color: Colors.white,
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.calendar_today_rounded, color: AppColors.primaryLight.withValues(alpha: 0.6), size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    display,
                    style: TextStyle(
                      color: date != null ? Colors.white : Colors.white.withValues(alpha: 0.25),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: _submitForm,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: AppColors.neonGradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.15),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.send_rounded, color: AppColors.background, size: 20),
            const SizedBox(width: 10),
            Text(
              'Send Request',
              style: GoogleFonts.poppins(
                color: AppColors.background,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 500.ms, delay: 200.ms).scaleXY(begin: 0.95, end: 1.0, curve: Curves.easeOutBack);
  }
}
