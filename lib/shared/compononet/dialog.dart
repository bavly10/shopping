import 'package:flutter/material.dart';
import 'package:shopping/shared/my_colors.dart';

My_CustomAlertDialog(
    {Color? iconColor,
      required BuildContext context,
      required Function onPress,
      required String pressTitle,
      required Color pressColor,
      required String bigTitle,
      required String content,
      IconData? icon}) {
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  _getRowButtons(context) {
    return [
      DialogButton(
        child: Text(
          pressTitle,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: onPress,
        color: pressColor,
      ),
    ];
  }

  var buttonsRowDirection = 1; //ROW DIRECTION
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: _defaultShape(),
          insetPadding: EdgeInsets.all(8),
          elevation: 10,
          titlePadding: const EdgeInsets.all(0.0),
          title: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      children: [
                        Icon(
                          icon,
                          size: 90,
                          color: iconColor,
                        ),
                        Text(
                          bigTitle,
                          style: TextStyle(
                              color: myBlue,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          content,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(8),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _getRowButtons(context),
          )));

}
class DialogButton extends StatelessWidget {
  Widget? child;
  double? width;
  double height;
  Color? color;
  Color? highlightColor;
  Color? splashColor;
  Gradient? gradient;
  BorderRadius? radius;
  Function? onPressed;
  BoxBorder? border;
  EdgeInsets? padding;
  EdgeInsets? margin;

  /// DialogButton constructor
  DialogButton({
    Key? key,
    this.child,
    this.width,
    this.height = 40.0,
    this.color,
    this.highlightColor,
    this.splashColor,
    this.gradient,
    this.radius,
    this.border,
    this.padding = const EdgeInsets.only(left: 6, right: 6),
    this.margin = const EdgeInsets.all(6),
    this.onPressed,
  }) : super(key: key);

  /// Creates alert buttons based on constructor params
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).accentColor,
          gradient: gradient,
          borderRadius: radius ?? BorderRadius.circular(6),
          border: border ?? Border.all(color: Colors.transparent, width: 0)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: highlightColor ?? Theme.of(context).highlightColor,
          splashColor: splashColor ?? Theme.of(context).splashColor,
          onTap: () {
            onPressed!();
          },
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}