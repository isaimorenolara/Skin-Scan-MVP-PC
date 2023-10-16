import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';

class TfliteModel extends StatefulWidget {
  const TfliteModel({Key? key}) : super(key: key);

  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  late File _image;
  late List _results;
  bool imageSelect = false;
  List<CameraDescription> cameras = [];
  late CameraController controller;
  bool isCameraBusy = false;

  final Completer<CameraController> _cameraController = Completer<CameraController>();

  @override
  void initState() {
    super.initState();
    loadModel();
    _initializeCamera();
  }

  Future _initializeCamera() async {
    cameras = await availableCameras();
    final controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller.initialize();
    if (!mounted) {
      return;
    }
    _cameraController.complete(controller);
  }


  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt"))!;
    print("Models loading status: $res");
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
      isCameraBusy = false;
    });
  }

  Future<void> captureImage() async {
    if (isCameraBusy) {
      return;
    }

    isCameraBusy = true;

    try {
      final XFile file = await controller.takePicture();
      if (file != null) {
        imageClassification(File(file.path));
      }
    } catch (e) {
      print("Error capturing image: $e");
      isCameraBusy = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Classification"),
      ),
      body: ListView(
        children: [
          (imageSelect)
              ? Container(
            margin: const EdgeInsets.all(10),
            child: Image.file(_image),
          )
              : Container(
            margin: const EdgeInsets.all(10),
            child: const Opacity(
              opacity: 0.8,
              child: Center(
                child: Text("No image selected"),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: (imageSelect)
                  ? _results.map((result) {
                return Card(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
                      style: const TextStyle(
                          color: Colors.red, fontSize: 20),
                    ),
                  ),
                );
              }).toList()
                  : [],
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: pickImage,
            tooltip: "Pick Image",
            child: Icon(Icons.image),
          ),
          FloatingActionButton(
            onPressed: captureImage,
            tooltip: "Capture Image",
            child: Icon(Icons.camera),
          ),
        ],
      ),
    );
  }

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }

  @override
  void dispose() {
    Tflite.close();
    controller.dispose();
    super.dispose();
  }
}