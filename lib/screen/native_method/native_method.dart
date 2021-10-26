import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeMethod extends StatefulWidget {
  const NativeMethod({Key? key}) : super(key: key);

  @override
  _NativeMethodState createState() => _NativeMethodState();
}

class _NativeMethodState extends State<NativeMethod> {

  static const platform = const MethodChannel('samples.flutter.dev/battery');
  String _mess = "";

  Future<void> _getBatteryLevel() async {
    String mess;
    try {
      final String result = await platform.invokeMethod('getBatteryLevel');
      mess = result;
    } on PlatformException catch (e) {
      mess = e.message.toString();
    }

    setState(() {
      _mess = mess;
    });
  }


  @override
  void initState() {
    _getBatteryLevel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("$_mess"),
        ),
      ),
    );
  }
}
