import 'package:***REMOVED***/core/colors.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final Color enableColor;
  final Color disableColor;
  final double width;
  final double height;
  final double switchHeight;
  final double switchWidth;
  final ValueChanged<bool> onChanged;

  CustomSwitch(
      {required Key key,
      required this.value,
      required this.enableColor,
      required this.disableColor,
      required this.width,
      required this.height,
      required this.switchHeight,
      required this.switchWidth,
      required this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
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
        return GestureDetector(
            onTap: () {
              if (_animationController.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
              widget.value == false
                  ? widget.onChanged(true)
                  : widget.onChanged(false);
            },
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Container(
                  height: 30,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: _circleAnimation.value == Alignment.centerLeft
                        ? widget.disableColor
                        : MyColors.blue_003E7E,
                  ),
                  padding: EdgeInsets.all(2),
                  child: Container(
                    width: 50,
                    height: 30,
                  ),
                ),
                Positioned.fill(
                    left:
                        _circleAnimation.value == Alignment.centerLeft ? 4 : 10,
                    right:
                        _circleAnimation.value == Alignment.centerLeft ? 10 : 4,
                    child: Container(
                      alignment: widget.value
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _circleAnimation.value == Alignment.centerLeft
                              ? MyColors.blue_003E7E
                              : Colors.white,
                        ),
                      ),
                    )),
              ],
            ));
      },
    );
  }
}
