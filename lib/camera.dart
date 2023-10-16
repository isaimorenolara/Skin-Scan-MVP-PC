import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';


typedef void Callback(List<dynamic> list);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;

  Camera(this.cameras, this.setRecognitions);
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController cameraController;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    cameraController =
        CameraController(widget.cameras.first, ResolutionPreset.high);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});

      cameraController.startImageStream((image) {
        if (!isDetecting) {
          isDetecting = true;
          Tflite.runModelOnFrame(
            bytesList: image.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: image.height,
            imageWidth: image.width,
            numResults: 1,
          ).then((value) {
            if (value?.isNotEmpty ?? false) {
              widget.setRecognitions(value!);
              isDetecting = false;
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return Container();
    }

    return Transform.scale(
      scale: 1 / cameraController.value.aspectRatio,
      child: Center(
        child: AspectRatio(
          aspectRatio: cameraController.value.aspectRatio,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // set the border radius here
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // set the border radius here as well
                border: Border.all(
                  color: const Color.fromRGBO(16, 202, 196, 100),
                  width: 3,
                ),
              ),
              child: CameraPreview(cameraController),
            ),
          ),
        ),
      ),
    );
  }
}