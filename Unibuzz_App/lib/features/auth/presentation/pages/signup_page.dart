import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../services/auth_service.dart';
import '../widgets/glass_button.dart';
import '../widgets/glass_text_field.dart';
import '../widgets/custom_chip.dart';
import '../widgets/modern_background.dart';
import 'verification_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final PageController _pageController = PageController();
  final _authService = AuthService();
  bool _isLoading = false;
  int _currentStep = 0;

  // Controllers
  final _emailController = TextEditingController(); 
  final _personalEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _prnController = TextEditingController();
  final _mobileController = TextEditingController();
  final _divisionController = TextEditingController();
  final _departmentController = TextEditingController();
  final _semesterController = TextEditingController();
  final _passoutYearController = TextEditingController();
  
  DateTime? _selectedDate;
  final List<String> _selectedInterests = [];
  
  final List<String> _departments = [
    'Computer Engineering',
    'IT',
    'Mechanical',
    'Civil',
    'Electronics',
    'AI & DS'
  ];

  final List<String> _interestsList = [
    'Coding',
    'Design',
    'Music',
    'Sports',
    'Gaming',
    'Photography',
    'Robotics',
    'Debate',
    'Dance'
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _prnController.dispose();
    _mobileController.dispose();
    _divisionController.dispose();
    _departmentController.dispose();
    _semesterController.dispose();
    _passoutYearController.dispose();
    _personalEmailController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      _pageController.nextPage(
        duration: 500.ms,
        curve: Curves.easeOutQuart,
      );
      setState(() => _currentStep++);
    } else {
      _signup();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: 500.ms,
        curve: Curves.easeOutQuart,
      );
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.accent,
              onPrimary: AppColors.background,
              surface: AppColors.primary,
              onSurface: AppColors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _signup() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    final userData = {
      'name': _nameController.text.trim(),
      'prn': _prnController.text.trim(),
      'dob': _selectedDate?.toIso8601String(),
      'mobile': _mobileController.text.trim(),
      'college_email': _emailController.text.trim(),
      'personal_email': _personalEmailController.text.trim(),
      'department': _departmentController.text.trim(),
      'division': _divisionController.text.trim(),
      'current_semester': int.tryParse(_semesterController.text.trim()) ?? 1,
      'pass_out_year': int.tryParse(_passoutYearController.text.trim()) ?? 2026,
      'interests': _selectedInterests,
      'role': 'student',
    };

    try {
      await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        userData: userData,
      );
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VerificationPage(email: _emailController.text.trim()),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        String errorMsg = e.toString();
        // Friendly error for the common Supabase misconfig
        if (errorMsg.contains('Failed host lookup')) {
            errorMsg = 'Setup Error: Supabase URL is missing/invalid in constants.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg)),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return AnimatedContainer(
          duration: 300.ms,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: _currentStep == index ? 24 : 6,
          decoration: BoxDecoration(
            color: _currentStep >= index ? AppColors.accent : Colors.white24,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModernBackground(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header
            Text(
              'CREATE ACCOUNT',
              style: GoogleFonts.racingSansOne(
                fontSize: 28,
                color: AppColors.white,
                letterSpacing: 1.2,
              ),
            ).animate().fadeIn().slideY(begin: -0.2, end: 0),
            
            const SizedBox(height: 10),
            _buildStepIndicator(),
            const SizedBox(height: 20),
            
            // Form Area (Glass Card style)
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GlassContainer.frostedGlass(
                     width: double.infinity,
                     height: MediaQuery.of(context).size.height * 0.65,
                     borderRadius: BorderRadius.circular(24),
                     borderColor: AppColors.glassBorder.withValues(alpha: 0.2),
                     frostedOpacity: 0.05,
                     blur: 15,
                     gradient: LinearGradient(
                       colors: [
                         Colors.white.withValues(alpha: 0.05),
                         Colors.white.withValues(alpha: 0.02),
                       ],
                       begin: Alignment.topLeft,
                       end: Alignment.bottomRight,
                     ),
                     padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildStep1(),
                              _buildStep2(),
                              _buildStep3(),
                              _buildStep4(),
                            ],
                          ),
                        ),
                        
                        // Navigation
                        Row(
                          children: [
                            if (_currentStep > 0)
                              Expanded(
                                child: GlassButton(
                                  onPressed: _prevStep,
                                  text: 'BACK',
                                ),
                              ),
                            if (_currentStep > 0) const SizedBox(width: 16),
                            Expanded(
                              child: GlassButton(
                                onPressed: _nextStep,
                                text: _currentStep == 3 ? 'SIGN UP' : 'NEXT',
                                isLoading: _isLoading && _currentStep == 3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                ),
              ),
            ),
            
             TextButton(
              onPressed: () => Navigator.pop(context),
              child: RichText(
                 text: TextSpan(
                   text: "Already have an account? ",
                   style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                   children: const [
                     TextSpan(
                       text: 'Login',
                       style: TextStyle(
                         color: AppColors.accent,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ],
                 ),
               ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassForm(List<Widget> children, String title) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 20),
          ...children.map((c) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: c,
          )),
        ],
      ),
    );
  }

  // Step 1: Credentials
  Widget _buildStep1() {
    return _buildGlassForm([
      GlassTextField(
        controller: _emailController,
        hintText: 'College Email',
        icon: Icons.email_outlined,
      ),
      GlassTextField(
        controller: _passwordController,
        hintText: 'Password',
        obscureText: true,
        icon: Icons.lock_outline,
      ),
      GlassTextField(
        controller: _prnController,
        hintText: 'PRN Number',
        icon: Icons.badge_outlined,
      ),
    ], 'CREDENTIALS');
  }

  // Step 2: Personal Info
  Widget _buildStep2() {
    return _buildGlassForm([
      GlassTextField(
        controller: _nameController,
        hintText: 'Full Name',
        icon: Icons.person_outline,
      ),
      GlassTextField(
        controller: _mobileController,
        hintText: 'Mobile Number',
        icon: Icons.phone_outlined,
      ),
      GlassTextField(
        controller: _personalEmailController,
        hintText: 'Personal Email (Optional)',
        icon: Icons.mail_outline,
      ),
      GestureDetector(
        onTap: () => _selectDate(context),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.glassBorder.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: AppColors.accent),
              const SizedBox(width: 16),
              Text(
                _selectedDate == null
                    ? 'Date of Birth'
                    : DateFormat('dd MMM yyyy').format(_selectedDate!),
                style: TextStyle(
                  color: _selectedDate == null ? Colors.white54 : Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    ], 'PERSONAL INFO');
  }

  // Step 3: Academic Info
  Widget _buildStep3() {
    return _buildGlassForm([
      // Custom Dropdown
      GestureDetector(
        onTap: _showDepartmentPicker,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.glassBorder.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              const Icon(Icons.school_outlined, color: AppColors.accent),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  _departmentController.text.isEmpty
                      ? 'Select Department'
                      : _departmentController.text,
                  style: TextStyle(
                    color: _departmentController.text.isEmpty ? Colors.white54 : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.white54),
            ],
          ),
        ),
      ),
      GlassTextField(
        controller: _divisionController,
        hintText: 'Division (e.g., A)',
        icon: Icons.class_outlined,
      ),
      GlassTextField(
        controller: _semesterController,
        hintText: 'Current Semester',
        icon: Icons.timelapse,
      ),
      GlassTextField(
        controller: _passoutYearController,
        hintText: 'Passout Year',
        icon: Icons.flag_outlined,
      ),
    ], 'ACADEMIC INFO');
  }

  // Step 4: Interests
  Widget _buildStep4() {
    return _buildGlassForm([
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: _interestsList.map((interest) {
          final isSelected = _selectedInterests.contains(interest);
          return CustomChip(
            label: interest,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedInterests.remove(interest);
                } else {
                  _selectedInterests.add(interest);
                }
              });
            },
          );
        }).toList(),
      ),
    ], 'INTERESTS');
  }

  void _showDepartmentPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select Department', 
                style: GoogleFonts.racingSansOne(
                  color: Colors.white, 
                  fontSize: 20,
                  letterSpacing: 1,
                )
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _departments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_departments[index], style: const TextStyle(color: Colors.white70)),
                    onTap: () {
                      setState(() {
                        _departmentController.text = _departments[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
