import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Countdown timer widget showing days, hours, minutes, seconds.
class CountdownTimer extends StatefulWidget {
  final DateTime deadline;
  final Color color;
  final double fontSize;

  const CountdownTimer({
    super.key,
    required this.deadline,
    this.color = AppColors.error,
    this.fontSize = 11,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateRemaining());
  }

  void _updateRemaining() {
    final now = DateTime.now();
    setState(() {
      _remaining = widget.deadline.isAfter(now) ? widget.deadline.difference(now) : Duration.zero;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_remaining == Duration.zero) {
      return Text('Ended', style: TextStyle(color: widget.color, fontSize: widget.fontSize, fontWeight: FontWeight.w700));
    }
    final d = _remaining.inDays;
    final h = _remaining.inHours % 24;
    final m = _remaining.inMinutes % 60;
    final s = _remaining.inSeconds % 60;

    String text;
    if (d > 0) {
      text = '${d}d ${h}h ${m}m';
    } else if (h > 0) {
      text = '${h}h ${m}m ${s}s';
    } else {
      text = '${m}m ${s}s';
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer_rounded, color: widget.color, size: widget.fontSize + 2),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: widget.color,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.w700,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
