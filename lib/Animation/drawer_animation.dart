import 'package:fbsocial/custom_widget/drawer.dart';
import 'package:fbsocial/ui/list_builder.dart';
import 'package:flutter/material.dart';

class DrawerAnimationPage extends StatefulWidget {
  const DrawerAnimationPage({super.key});
  @override
  State<DrawerAnimationPage> createState() => _DrawerAnimationPageState();
}

class _DrawerAnimationPageState extends State<DrawerAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  static const double maxSlide = 225;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  late bool _canBeDragged;
  int position = 0;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));

    super.initState();
  }

  void toogle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

//If we start opening or losing the drawer
  void onDragStart(DragStartDetails dragStartDetails) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        dragStartDetails.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController.isCompleted &&
        dragStartDetails.globalPosition.dx > maxDragStartEdge;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void onDragUpdate(DragUpdateDetails dragStartDetails) {
    if (_canBeDragged) {
      double delta = dragStartDetails.primaryDelta! / maxSlide;
      //when animation controller value changes then we rebuild our widget.
      _animationController.value += delta;
    }
  }

  void onDragEnd(DragEndDetails details) {
    double kMinFlingVelocity = 365.0;

    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
      behavior: HitTestBehavior.translucent,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            double slide = maxSlide * _animationController.value;
            double scale = 1 - (_animationController.value * 0.3);
            return Stack(
              children: [
                const MyDrawer(),
                Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: Scaffold(
                        appBar: AppBar(
                            shadowColor: Colors.black,
                            leading: InkWell(
                                onTap: toogle,
                                child: const Icon(Icons.menu,
                                    color: Colors.white)),
                            title: const Text('HEADLINES',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, letterSpacing: 2)),
                            backgroundColor: Colors.black),
                        body: ListBuilder())),
              ],
            );
          }),
    ));
  }
}
