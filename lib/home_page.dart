import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:google_fonts/google_fonts.dart';
import 'camera.dart';

class MyHomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  MyHomePage(this.cameras);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String predOne = '';
  double confidence = 0;
  double index = 0;

  @override
  void initState() {
    super.initState();
    loadTfliteModel();
  }

  loadTfliteModel() async {
    String? res;
    res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
    print(res);
  }

  setRecognitions(outputs) {
    print(outputs);

    if (outputs[0]['index'] == 0) {
      index = 0;
    } else if (outputs[0]['index'] == 1){
      index = 1;
    } else if (outputs[0]['index'] == 2){
      index = 2;
    } else if (outputs[0]['index'] == 3){
      index = 3;
    } else if (outputs[0]['index'] == 4){
      index = 4;
    } else if (outputs[0]['index'] == 5){
      index = 5;
    } else if (outputs[0]['index'] == 6){
      index = 6;
    }

    confidence = outputs[0]['confidence'];

    setState(() {
      predOne = outputs[0]['label'];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Skin Scan App",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(16, 202, 196, 100),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                width: double.infinity,
                height: double.infinity,
                child: Camera(widget.cameras, setRecognitions),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0), // Ajusta el margen como desees
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'akiec',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                              ),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Expanded(
                              flex: 8,
                              child: SizedBox(
                                height: 20.0,
                                child: Stack(
                                  children: [
                                    LinearProgressIndicator(
                                      valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.redAccent),
                                      value: index == 0 ? confidence : 0.0,
                                      backgroundColor:
                                      Colors.redAccent.withOpacity(0.2),
                                      minHeight: 50.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 0 ? (confidence * 100).toStringAsFixed(0) : 0} %',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'bcc',
                                style: TextStyle(
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                              ),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Expanded(
                              flex: 8,
                              child: SizedBox(
                                height: 20.0,
                                child: Stack(
                                  children: [
                                    LinearProgressIndicator(
                                      valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.orangeAccent),
                                      value: index == 1 ? confidence : 0.0,
                                      backgroundColor: Colors.orangeAccent
                                          .withOpacity(0.2),
                                      minHeight: 50.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 1 ? (confidence * 100).toStringAsFixed(0) : 0} %',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'bkl',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                              ),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Expanded(
                              flex: 8,
                              child: SizedBox(
                                height: 20.0,
                                child: Stack(
                                  children: [
                                    LinearProgressIndicator(
                                      valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.blueAccent),
                                      value: index == 2 ? confidence : 0.0,
                                      backgroundColor: Colors.blueAccent
                                          .withOpacity(0.2),
                                      minHeight: 50.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 2 ? (confidence * 100).toStringAsFixed(0) : 0} %',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'df',
                                style: TextStyle(
                                    color: Colors.purpleAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                              ),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Expanded(
                              flex: 8,
                              child: SizedBox(
                                height: 20.0,
                                child: Stack(
                                  children: [
                                    LinearProgressIndicator(
                                      valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.purpleAccent),
                                      value: index == 3 ? confidence : 0.0,
                                      backgroundColor: Colors.purpleAccent
                                          .withOpacity(0.2),
                                      minHeight: 50.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 3 ? (confidence * 100).toStringAsFixed(0) : 0} %',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'mel',
                                style: TextStyle(
                                    color: Colors.pinkAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                              ),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Expanded(
                              flex: 8,
                              child: SizedBox(
                                height: 20.0,
                                child: Stack(
                                  children: [
                                    LinearProgressIndicator(
                                      valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.pinkAccent),
                                      value: index == 4 ? confidence : 0.0,
                                      backgroundColor: Colors.pinkAccent
                                          .withOpacity(0.2),
                                      minHeight: 50.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 4 ? (confidence * 100).toStringAsFixed(0) : 0} %',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'nv',
                                style: TextStyle(
                                    color: Colors.yellowAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                              ),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Expanded(
                              flex: 8,
                              child: SizedBox(
                                height: 20.0,
                                child: Stack(
                                  children: [
                                    LinearProgressIndicator(
                                      valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.yellowAccent),
                                      value: index == 5 ? confidence : 0.0,
                                      backgroundColor: Colors.yellowAccent
                                          .withOpacity(0.2),
                                      minHeight: 50.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 5 ? (confidence * 100).toStringAsFixed(0) : 0} %',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'vasc',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                              ),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Expanded(
                              flex: 8,
                              child: SizedBox(
                                height: 20.0,
                                child: Stack(
                                  children: [
                                    LinearProgressIndicator(
                                      valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.green),
                                      value: index == 6 ? confidence : 0.0,
                                      backgroundColor: Colors.green
                                          .withOpacity(0.2),
                                      minHeight: 50.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 6 ? (confidence * 100).toStringAsFixed(0) : 0} %',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}