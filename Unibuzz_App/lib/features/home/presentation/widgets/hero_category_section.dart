import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

  static const List<CategoryItem> _items = [
    CategoryItem('Hackathons', Icons.memory_rounded),
    CategoryItem('Cultural', Icons.theater_comedy_rounded),
    CategoryItem('Sports', Icons.sports_basketball_rounded),
    CategoryItem('Gaming', Icons.videogame_asset_rounded),
    CategoryItem('Workshops', Icons.handyman_rounded),
    CategoryItem('Guest Lectures', Icons.record_voice_over_rounded),
    CategoryItem('Clubs', Icons.groups_rounded),
    CategoryItem('Fests', Icons.festival_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(24),
        blur: 10,
        opacity: 0.05,
        color: AppColors.background,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        child: Stack(
          children: [
            _NeonAmbientGlow(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore Campus Vibes',
                    style: TextStyle(
                      fontFamily: 'Racing Sans One',
                      color: AppColors.white,
                      fontSize: 28,
                      shadows: [
                        Shadow(
                          color: AppColors.primary.withValues(alpha: 0.6),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const _NeonUnderline(),
                  const SizedBox(height: 18),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 1.05,
                    ),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return HeroCategoryCard(
                        item: item,
                        pulseGlow: index == 0,
                        onTap: () => onCategoryTap(item.label),
                        onLongPress: () => onCategoryLongPress(item.label),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fade(duration: 500.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
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
      duration: const Duration(milliseconds: 1400),
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
    setState(() {
      _pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: _pressed ? 0.96 : 1.0,
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        child: AnimatedBuilder(
          animation: _pulse,
          builder: (context, child) {
            final double pulseValue = widget.pulseGlow ? _pulse.value : 0;
            final double glowBoost = _pressed ? 0.4 : 0.0;
            final double glowOpacity = 0.18 + (pulseValue * 0.18) + glowBoost;
            final double blur = 12 + (pulseValue * 10) + (glowBoost * 10);
            final Color glowColor = _pressed
              ? AppColors.accent.withValues(alpha: 0.7)
              : AppColors.primary.withValues(alpha: glowOpacity);

            return AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _pressed
                      ? AppColors.accent.withValues(alpha: 0.9)
                      : AppColors.primary.withValues(alpha: 0.6),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: glowColor,
                    blurRadius: blur,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 8,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _IconStack(icon: widget.item.icon),
                        const SizedBox(height: 6),
                        Flexible(
                          child: Text(
                            widget.item.label,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              height: 1.05,
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

class _IconStack extends StatelessWidget {
  const _IconStack({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: const Offset(2, 2),
          child: Icon(
            icon,
            size: 26,
            color: AppColors.primary.withValues(alpha: 0.6),
          ),
        ),
        Icon(
          icon,
          size: 26,
          color: AppColors.white,
        ),
        Positioned(
          top: -2,
          right: -2,
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.6),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
      ],
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
      duration: const Duration(milliseconds: 1600),
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
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.8),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class _NeonAmbientGlow extends StatelessWidget {
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
                size: 90,
                color: AppColors.primary.withValues(alpha: 0.25),
              ),
            ),
            Positioned(
              bottom: -10,
              right: 0,
              child: _GlowOrb(
                size: 120,
                color: AppColors.primary.withValues(alpha: 0.18),
              ),
            ),
            Positioned(
              top: 40,
              right: 40,
              child: _GlowOrb(
                size: 18,
                color: AppColors.accent.withValues(alpha: 0.6),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 30,
              child: _GlowOrb(
                size: 12,
                color: AppColors.accent.withValues(alpha: 0.4),
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
            spreadRadius: size * 0.15,
          ),
        ],
      ),
    );
  }
}

class CategoryItem {
  const CategoryItem(this.label, this.icon);

  final String label;
  final IconData icon;
}
