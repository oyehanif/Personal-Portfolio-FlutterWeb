import 'package:flutter/material.dart';
import 'package:oyehanif/globles/app_images.dart';

class AnimatedProfileWidget extends StatefulWidget {
   AnimatedProfileWidget({super.key, this.size = 450});

  double size;

  @override
  State<AnimatedProfileWidget> createState() => _AnimatedProfileWidgetState();
}

class _AnimatedProfileWidgetState extends State<AnimatedProfileWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..repeat(reverse: true);

    _animation = Tween(begin: const Offset(0, 0.05), end: const Offset(0, 0.0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage(AppImages.profile)),
          borderRadius: const BorderRadius.all(Radius.circular(450)),
          // color: Colors.redAccent,
        ),
      ),
    );
  }
}
