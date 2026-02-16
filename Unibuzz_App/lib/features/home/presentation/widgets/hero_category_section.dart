import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class HeroCategorySection extends StatelessWidget {
  const HeroCategorySection({
    super.key,
    required this.onCategoryTap,
    required this.onCategoryLongPress,
  });

  final void Function(String category) onCategoryTap;
  final void Function(String category) onCategoryLongPress;

  static const Color _cardAccent = AppColors.primary;
  static const List<CategoryItem> _items = [
    CategoryItem('Hackathons', Icons.memory_rounded, _cardAccent),
    CategoryItem('Cultural', Icons.theater_comedy_rounded, _cardAccent),
    CategoryItem('Sports', Icons.sports_basketball_rounded, _cardAccent),
    CategoryItem('Gaming', Icons.videogame_asset_rounded, _cardAccent),
    CategoryItem('Sessions', Icons.forum_rounded, _cardAccent),
    CategoryItem('Mentors', Icons.school_rounded, _cardAccent),
    CategoryItem('Clubs', Icons.groups_rounded, _cardAccent),
    CategoryItem('Fests', Icons.festival_rounded, _cardAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(28),
        blur: 14,
        opacity: 0.06,
        color: AppColors.background,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
        glowColor: AppColors.primary,
        glowIntensity: 0.08,
        child: Stack(
          children: [
            const _NeonAmbientGlow(),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [AppColors.white, AppColors.primaryLight],
                    ).createShader(bounds),
                    child: Text(
                      'Explore Campus Vibes',
                      style: GoogleFonts.racingSansOne(
                        color: AppColors.white,
                        fontSize: 28,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            color: AppColors.primary.withValues(alpha: 0.7),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const _NeonUnderline(),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.95,
                      mainAxisExtent: 104,
                    ),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return HeroCategoryCard(
                        item: item,
                        pulseGlow: index == 0,
                        onTap: () => onCategoryTap(item.label),
                        onLongPress: () => onCategoryLongPress(item.label),
                      ).animate(delay: (80 * index).ms)
                       .fadeIn(duration: 300.ms)
                       .scaleXY(begin: 0.85, end: 1.0, curve: Curves.easeOutBack);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fade(duration: 500.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOut),
    );
  }
}

class HeroCategoryCard extends StatefulWidget {
  const HeroCategoryCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onLongPress,
    this.pulseGlow = false,
  });

  final CategoryItem item;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool pulseGlow;

  @override
  State<HeroCategoryCard> createState() => _HeroCategoryCardState();
}

class _HeroCategoryCardState extends State<HeroCategoryCard>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;
  late final AnimationController _pulseController;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    _pulse = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );
    if (widget.pulseGlow) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.item.accentColor;

    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: _pressed ? 0.92 : 1.0,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onTap();
        },
        onLongPress: widget.onLongPress,
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        child: AnimatedBuilder(
          animation: _pulse,
          builder: (context, child) {
            final double pulseValue = widget.pulseGlow ? _pulse.value : 0;
            final double glowBoost = _pressed ? 0.45 : 0.0;
            final double glowOpacity = 0.15 + (pulseValue * 0.2) + glowBoost;
            final double blur = 10 + (pulseValue * 12) + (glowBoost * 12);

            return AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: _pressed
                      ? accentColor.withValues(alpha: 0.9)
                      : accentColor.withValues(alpha: 0.35),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withValues(alpha: glowOpacity),
                    blurRadius: blur,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          accentColor.withValues(alpha: _pressed ? 0.15 : 0.06),
                          Colors.black.withValues(alpha: 0.55),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _IconGlow(
                          icon: widget.item.icon,
                          color: accentColor,
                          isPressed: _pressed,
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          child: Text(
                            widget.item.label,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.white.withValues(alpha: 0.9),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              height: 1.1,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _IconGlow extends StatelessWidget {
  const _IconGlow({
    required this.icon,
    required this.color,
    this.isPressed = false,
  });

  final IconData icon;
  final Color color;
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: isPressed ? 0.2 : 0.1),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: isPressed ? 0.4 : 0.15),
            blurRadius: isPressed ? 14 : 8,
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 22,
        color: isPressed ? Colors.white : color,
      ),
    );
  }
}

class _NeonUnderline extends StatefulWidget {
  const _NeonUnderline();

  @override
  State<_NeonUnderline> createState() => _NeonUnderlineState();
}

class _NeonUnderlineState extends State<_NeonUnderline>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (context, child) {
        final double scaleX = 0.85 + (_scale.value * 0.15);
        return Transform.scale(
          scaleX: scaleX,
          alignment: Alignment.centerLeft,
          child: child,
        );
      },
      child: Container(
        width: 140,
        height: 3,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.accent.withValues(alpha: 0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.7),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
      ),
    );
  }
}

class _NeonAmbientGlow extends StatelessWidget {
  const _NeonAmbientGlow();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: -20,
              left: -10,
              child: _GlowOrb(
                size: 80,
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
            Positioned(
              bottom: -15,
              right: -5,
              child: _GlowOrb(
                size: 100,
                color: AppColors.neonCyan.withValues(alpha: 0.1),
              ),
            ),
            Positioned(
              top: 50,
              right: 30,
              child: _GlowOrb(
                size: 14,
                color: AppColors.accent.withValues(alpha: 0.5),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 20,
              child: _GlowOrb(
                size: 10,
                color: AppColors.neonPink.withValues(alpha: 0.35),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: size * 0.8,
            spreadRadius: size * 0.1,
          ),
        ],
      ),
    );
  }
}

class CategoryItem {
  const CategoryItem(this.label, this.icon, this.accentColor);

  final String label;
  final IconData icon;
  final Color accentColor;
}
