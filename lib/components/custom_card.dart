import 'package:flutter/material.dart';

///[CustomCard] that you can use for quick mplementation of [Card]
///Many properties simplified
///Added more features to simple [Card] like you can click on [CustomCard]
///also support hoverColor and more
class CustomCard extends StatelessWidget {
  ///Background [Color] for card
  final Color color;

  ///key
  @override
  // ignore: overridden_fields
  final Key? key;

  ///Creates an ink well.
  ///What should be happen when you click on [Card]
  final GestureTapCallback? onTap;

  ///shadow [Color] of the card
  final Color shadowColor;

  ///border color of card
  final Color? borderColor;

  ///hover [Color] for the [Card]
  ///onTap shoult not be null
  final Color? hoverColor;

  ///splash [Color] for click effect
  ///onTap shoult not be null
  final Color? splashColor;

  ///padding for the child
  final double childPadding;

  ///height of the [Card] if null then the height of [Card] will be according to child
  final double? height;

  ///height of the [Card] if null then the width of [Card] will be according to child
  final double? width;

  ///radius for the [Card]
  final double? borderRadius;

  ///The width of this side of the border, in logical pixels.
  final double? borderWidth;

  ///[elevation] for card
  final double elevation;

  ///child [Widget] of [Card]
  final Widget? child;

  // ignore: use_key_in_widget_constructors
  const CustomCard({
    this.elevation = 3,
    this.shadowColor = Colors.black,
    this.childPadding = 5,
    this.color = Colors.white,
    this.child,
    this.key,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.hoverColor,
    this.splashColor,
    this.onTap,
    this.height,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    bool isBorder = (borderColor != null || borderWidth != null);
    return Card(
      elevation: elevation,
      key: key,
      color: color,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        side: isBorder
            ? BorderSide(
                color: borderColor ?? Colors.black,
                width: borderWidth ?? 1,
                style: BorderStyle.solid,
              )
            : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        hoverColor: hoverColor,
        splashColor: splashColor,
        onTap: onTap,
        child: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: EdgeInsets.all(childPadding),
            child: child,
          ),
        ),
      ),
    );
  }
}
