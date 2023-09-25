
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/styles/icon_broken.dart';

class NativeCodeScreen extends StatefulWidget {

  @override
  State<NativeCodeScreen> createState() => _NativeCodeScreenState();
}


class _NativeCodeScreenState extends State<NativeCodeScreen> {

  //create channel
  static const platform = MethodChannel('samples.flutter.dev/battery');
  // Get battery level.
  String batteryLevel = 'Unknown battery level.';

  void getBatteryLevel()  {
     platform.invokeMethod('getBatteryLevel').then((value)
    {
      setState(() {
        batteryLevel = 'Battery level at $value % .';
      });
    }).catchError((error)
    {
      setState(() {
        batteryLevel = "Failed to get battery level: '${error.message}'.";
      });
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Battery of device'
        ),
        titleSpacing: 0,
        leading:  IconButton(
          onPressed: ()
          {
            Navigator.pop(context);
          },
          icon:  Icon(
            IconBroken.Arrow___Left_2,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
            Text(batteryLevel),
          ],
        ),
      ),
    );
  }
}
