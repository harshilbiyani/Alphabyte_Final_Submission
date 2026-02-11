import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../events/presentation/pages/event_participation_page.dart';
import '../../../home/data/mock_home_data.dart';
import 'discover_event_card.dart';

enum _DragMode { none, card, details }

class DiscoverSwipeDeck extends StatefulWidget {
  final List<EventModel> events;

  const DiscoverSwipeDeck({super.key, required this.events});

  @override
  State<DiscoverSwipeDeck> createState() => _DiscoverSwipeDeckState();
}

class _DiscoverSwipeDeckState extends State<DiscoverSwipeDeck>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  double _dragDx = 0;
  double _detailsProgress = 0;
  double _deckWidth = 1;
  _DragMode _dragMode = _DragMode.none;
  bool _advanceOnComplete = false;

  late final AnimationController _settleController;
  late final AnimationController _detailsController;
  Animation<double>? _dragAnimation;
  Animation<double>? _detailsAnimation;

  @override
  void initState() {
    super.initState();
    _settleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _detailsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
  }

  @override
  void dispose() {
    _settleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _animateCardTo(double target, {bool advance = false}) {
    _settleController.stop();
    _dragAnimation?.removeListener(_onDragAnimate);
    _advanceOnComplete = advance;
    _dragAnimation = Tween<double>(begin: _dragDx, end: target).animate(
      CurvedAnimation(parent: _settleController, curve: Curves.easeOutCubic),
    )..addListener(_onDragAnimate);

    _settleController
      ..reset()
      ..forward().whenComplete(() {
        if (!mounted) return;
        if (_advanceOnComplete) {
          _advanceOnComplete = false;
          if (_currentIndex < widget.events.length - 1) {
            setState(() {
              _currentIndex += 1;
              _dragDx = 0;
            });
          } else {
            setState(() => _dragDx = 0);
          }
        }
      });
  }

  void _onDragAnimate() {
    if (!mounted) return;
    setState(() {
      _dragDx = _dragAnimation?.value ?? 0;
    });
  }

  void _animateDetailsTo(double target) {
    _detailsController.stop();
    _detailsAnimation?.removeListener(_onDetailsAnimate);
    _detailsAnimation =
        Tween<double>(begin: _detailsProgress, end: target).animate(
          CurvedAnimation(
            parent: _detailsController,
            curve: Curves.easeOutCubic,
          ),
        )..addListener(_onDetailsAnimate);

    _detailsController
      ..reset()
      ..forward();
  }

  void _onDetailsAnimate() {
    if (!mounted) return;
    setState(() {
      _detailsProgress = _detailsAnimation?.value ?? 0;
    });
  }

  void _onDragStart(DragStartDetails details) {
    if (_settleController.isAnimating || _detailsController.isAnimating) return;
    if (_detailsProgress > 0) {
      _dragMode = _DragMode.details;
    } else {
      _dragMode = _DragMode.none;
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_deckWidth <= 0) return;
    final delta = details.primaryDelta ?? 0;
    if (_dragMode == _DragMode.none) {
      if (delta.abs() < 1) return;
      _dragMode = delta < 0 ? _DragMode.card : _DragMode.details;
    }

    setState(() {
      if (_dragMode == _DragMode.card) {
        final canAdvance = _currentIndex < widget.events.length - 1;
        final resistance = canAdvance ? 1.0 : 0.35;
        _dragDx = (_dragDx + delta * resistance).clamp(-_deckWidth * 1.1, 0);
      } else {
        _detailsProgress = (_detailsProgress + delta / _deckWidth).clamp(
          0.0,
          1.0,
        );
      }
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_deckWidth <= 0) return;

    if (_dragMode == _DragMode.card) {
      final progress = (-_dragDx / _deckWidth).clamp(0.0, 1.0);
      if (progress > 0.22 && _currentIndex < widget.events.length - 1) {
        HapticFeedback.lightImpact();
        _animateCardTo(-_deckWidth * 1.1, advance: true);
      } else {
        _animateCardTo(0);
      }
    } else if (_dragMode == _DragMode.details) {
      final shouldOpen = _detailsProgress > 0.35;
      if (shouldOpen) {
        HapticFeedback.selectionClick();
      }
      _animateDetailsTo(shouldOpen ? 1.0 : 0.0);
    }

    _dragMode = _DragMode.none;
  }

  void _closeDetails() {
    _animateDetailsTo(0.0);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 60, color: Colors.white24),
            const SizedBox(height: 16),
            Text(
              'No events here yet - check other vibes',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    final current = widget.events[_currentIndex];
    final hasNext = _currentIndex < widget.events.length - 1;
    final next = hasNext ? widget.events[_currentIndex + 1] : current;

    return LayoutBuilder(
      builder: (context, constraints) {
        _deckWidth = constraints.maxWidth;
        final dragProgress = (-_dragDx / _deckWidth).clamp(0.0, 1.0);
        final glowBoost = 0.35 + dragProgress * 0.6;

        return Column(
          children: [
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragStart: _onDragStart,
                onHorizontalDragUpdate: _onDragUpdate,
                onHorizontalDragEnd: _onDragEnd,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (hasNext)
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 64),
                          child: Transform.translate(
                            offset: Offset(
                              24 * (1 - dragProgress),
                              10 * (1 - dragProgress),
                            ),
                            child: Transform.scale(
                              scale: 0.94 + 0.04 * dragProgress,
                              child: DiscoverEventCard(
                                event: next,
                                glowStrength: 0.2 + dragProgress * 0.3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 60),
                        child: Transform.translate(
                          offset: Offset(_dragDx, 0),
                          child: Transform.rotate(
                            angle: -0.05 * dragProgress,
                            child: DiscoverEventCard(
                              event: current,
                              glowStrength: glowBoost,
                              showHints: _detailsProgress == 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_detailsProgress > 0)
                      Positioned.fill(
                        child: _DetailsOverlay(
                          event: current,
                          progress: _detailsProgress,
                          onClose: _closeDetails,
                          onParticipate: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EventParticipationPage(event: current),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _DeckIndicator(count: widget.events.length, index: _currentIndex),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

class _DetailsOverlay extends StatelessWidget {
  final EventModel event;
  final double progress;
  final VoidCallback onClose;
  final VoidCallback onParticipate;

  const _DetailsOverlay({
    required this.event,
    required this.progress,
    required this.onClose,
    required this.onParticipate,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final panelWidth = width * 0.86;
    final slideOffset = (1 - progress) * width;

    return Stack(
      children: [
        Opacity(
          opacity: 0.35 * progress,
          child: Container(color: Colors.black),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Transform.translate(
            offset: Offset(slideOffset, 0),
            child: SizedBox(
              width: panelWidth,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(28),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(22, 20, 22, 24 + bottomInset),
                    decoration: BoxDecoration(
                      color: AppColors.glassBackground.withOpacity(0.6),
                      border: Border.all(
                        color: AppColors.glassBorder,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: onClose,
                            icon: const Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          event.title,
                          style: const TextStyle(
                            fontFamily: 'Racing Sans One',
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _DetailsRow(
                          icon: Icons.calendar_today,
                          text: event.date,
                        ),
                        const SizedBox(height: 8),
                        _DetailsRow(
                          icon: Icons.location_on,
                          text: event.department,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          event.description,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children: [
                            _TagChip(text: event.category),
                            _TagChip(text: event.department),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: onParticipate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'PARTICIPATE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailsRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailsRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  final String text;

  const _TagChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _DeckIndicator extends StatelessWidget {
  final int count;
  final int index;

  const _DeckIndicator({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: isActive ? 18 : 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
