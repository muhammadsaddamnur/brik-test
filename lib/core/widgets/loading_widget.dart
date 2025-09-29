import 'package:flutter/material.dart';
import 'package:store/core/utils/colors_util.dart';

class LoadingWidget extends StatefulWidget {
  final double? height;
  final String? asset;

  const LoadingWidget({super.key, this.height, this.asset});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(scale: _scaleAnimation.value, child: child);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorsUtil.yellow,
        ),
        width: widget.height ?? MediaQuery.of(context).size.width / 5,
        height: widget.height ?? MediaQuery.of(context).size.width / 5,
      ),
    );
  }
}
