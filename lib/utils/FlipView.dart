import 'package:flutter/cupertino.dart';

class FlipView extends StatefulWidget {
  final Widget child;

  const FlipView({Key? key, required this.child}) : super(key: key);

  @override
  _FlipViewState createState() => _FlipViewState();
}

class _FlipViewState extends State<FlipView> {
  bool _isFlipped = false;

  void _flip(v) {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _flip,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(_isFlipped ? 3.1415926 : 0),
        child: widget.child,
      ),
    );
  }
}
