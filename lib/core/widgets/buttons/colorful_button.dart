import 'package:flutter/cupertino.dart';

class ColorfulButton<T> extends StatelessWidget {
  final Color color;
  final Function(T) onPressed;
  final T value;
  final T groupvalue;
  const ColorfulButton({
    Key? key,
    required this.color,
    required this.onPressed,
    required this.value,
    required this.groupvalue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Container(
        height: 20,
        width: 20,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 1,
          ),
          shape: BoxShape.circle,
        ),
        child: value == groupvalue
            ? Container(
                alignment: Alignment.center,
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              )
            : null,
      ),
      onPressed: () {
        onPressed(value);
      },
    );
  }
}
