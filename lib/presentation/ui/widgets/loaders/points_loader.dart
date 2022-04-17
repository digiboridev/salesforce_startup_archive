import 'package:***REMOVED***/core/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PointsLoader extends StatefulWidget{
  final Color points_color;
  PointsLoader({required this.points_color});
  @override
  State<StatefulWidget> createState() => PointsLoaderState();

}
class PointsLoaderState extends State<PointsLoader> with SingleTickerProviderStateMixin{
late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, value: 0,
        duration: Duration(milliseconds: 2000))..repeat();

    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return  Container(
      alignment: Alignment.center,
      height: 50,
        //width: Get.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          AnimationLoaderPoint(key: UniqueKey(),
    position: 1,
    animationController:controller, minSide: 3, maxSide: 7, color: widget.points_color,),
    SizedBox(width: 5,),
          AnimationLoaderPoint(key: UniqueKey(),
        position: 2,
    animationController:controller, minSide: 5, maxSide:10,
              color: widget.points_color),
      SizedBox(width: 5,),
          AnimationLoaderPoint(key: UniqueKey(),
        position: 3,
        minSide: 7, maxSide: 13,
    animationController:controller,
              color: widget.points_color),
      SizedBox(width: 5,),
          AnimationLoaderPoint(key: UniqueKey(),
          position: 4,
          minSide: 5, maxSide: 10,
          animationController:controller,
              color: widget.points_color),
      SizedBox(width: 5,),
          AnimationLoaderPoint(key: UniqueKey(),
          position: 5,
          minSide: 3, maxSide: 7,
          animationController:controller,
              color: widget.points_color)
    ],));

  }

}

class AnimationLoaderPoint extends StatelessWidget {
  final int position;
  final double maxSide;
  final double minSide;
  final Color color;
  final AnimationController animationController;

  AnimationLoaderPoint(
      {required Key key,
        required this.color,
        required this.position,
         required this.maxSide,
        required this.minSide,
        required this.animationController})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    var seq = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: maxSide, end: minSide),
          weight: 0.5),]);
    var squareSizeChangeTweenAnimation = seq.animate(animationController);

    return AnimatedBuilder(
        animation: squareSizeChangeTweenAnimation,
        builder: (context, child) {
          var side = squareSizeChangeTweenAnimation.value;
          return Container(
            alignment: Alignment.topCenter,
              height: 50,
              width: 10,
              child:  Stack(children: [AnimatedPositioned(
              height: 20,
              width: 10,
          bottom: 2*side,

          duration: Duration(milliseconds: 2000),
          child:Column(children: [SizedBox(
            height: this.maxSide,
            width: this.maxSide,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle
                ),
                width: side,
                height: side,

              ),
            ),
          ),
         ],))])); });

          // square tile code here in a moment..
  }
  /// The function will return the color for the tile
  /// depending on its type

}