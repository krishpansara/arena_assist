import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme.dart';
import '../providers/sos_provider.dart';

class SOSButton extends ConsumerStatefulWidget {
  final String eventId;
  final String eventTitle;
  
  const SOSButton({
    super.key,
    required this.eventId,
    required this.eventTitle,
  });

  @override
  ConsumerState<SOSButton> createState() => _SOSButtonState();
}

class _SOSButtonState extends ConsumerState<SOSButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _triggerSOS();
      }
    });
  }

  Future<void> _triggerSOS() async {
    HapticFeedback.heavyImpact();
    
    // Show a "Processing..." feedback if desired, or skip to success/fail
    try {
      await ref.read(sosProvider.notifier).triggerSOS(widget.eventId, widget.eventTitle);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('SOS Alert Triggered! Authorities notified.'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('StateError: ', '')),
            backgroundColor: AppColors.surfaceBright,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        HapticFeedback.lightImpact();
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        if (_controller.status != AnimationStatus.completed) {
          _controller.reverse();
        }
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        if (_controller.status != AnimationStatus.completed) {
          _controller.reverse();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: _controller.value,
                  backgroundColor: AppColors.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.error),
                  strokeWidth: 6,
                ),
              );
            },
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _isPressed ? 90 : 100,
            height: _isPressed ? 90 : 100,
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.error,
                width: 2,
              ),
              boxShadow: _isPressed ? [] : [
                BoxShadow(
                  color: AppColors.error.withValues(alpha: 0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.error,
                  size: 32,
                ),
                const SizedBox(height: 4),
                Text(
                  'SOS',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
