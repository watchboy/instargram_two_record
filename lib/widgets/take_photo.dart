import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/constants/screen_size.dart';
import 'package:instagram_two_record/widgets/my_progress_indicator.dart';

class TakePhoto extends StatefulWidget {
  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  CameraController? _controller;
  Widget _progress = MyProgressIndicator(containerSize: 60);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
        future: availableCameras(),
        builder: (context, snapshot) {


          return Column(
            children: [
              Container(
                width: size!.width,
                height: size!.width,
                color: Colors.black,
                child: (snapshot.hasData)?_getPreview(snapshot.requireData):_progress,
              ),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text(''),
                    style: ounlinedButtonStyle()),
              )
            ],
          );
        });
  }

  ButtonStyle ounlinedButtonStyle() {
    return ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(
            Size(size!.width / 4, size!.width / 4)),
        shape: MaterialStateProperty.all(CircleBorder()),
        side: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.pressed)
              ? Colors.black45
              : Colors.black12;
          return BorderSide(color: color, width: 20);
        }));
  }

  Widget _getPreview(List<CameraDescription> cameras) {
    _controller = CameraController(
        cameras[0], ResolutionPreset.medium); //resolutionPreset = 화질
    return FutureBuilder(
        future: _controller!.initialize(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done)
          return ClipRect(
            child: OverflowBox(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                    width: size!.width,
                    height: size!.width/_controller!.value.aspectRatio,
                    child: CameraPreview(_controller)),
              ),
            ),
          );
          else{
            return _progress;
          }
        });
  }
}
