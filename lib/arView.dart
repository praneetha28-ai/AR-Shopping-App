import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart'as vector;


class ARViewScreen extends StatefulWidget {
  String itemImg;
  ARViewScreen({required this.itemImg});


  @override
  _ARViewScreenState createState() => _ARViewScreenState(item: itemImg);
}

class _ARViewScreenState extends State<ARViewScreen> {
  late String item;
  _ARViewScreenState({required this.item});
  late ArCoreController arCoreController;
  GlobalKey previewContainer = new GlobalKey();
  void whenARCoreViewCreated( ArCoreController controller){
    arCoreController= controller;
    arCoreController.onPlaneTap= controlOnPlaneTap;
  }

  void controlOnPlaneTap(List<ArCoreHitTestResult>results){
    final hit= results.first;
    print(hit.distance);
    addItemImagetoScene(hit);
  }

  Future addItemImagetoScene(ArCoreHitTestResult hitTestResult) async{
    final bytes= (await rootBundle.load(item)).buffer.asUint8List();
    final imageItem= ArCoreNode(
      image: ArCoreImage(bytes: bytes, width: 600, height: 600),
      position: hitTestResult.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
      rotation: hitTestResult.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
    );
    arCoreController.addArCoreNodeWithAnchor(imageItem);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: previewContainer,
      child:  Scaffold(
      body:  ArCoreView(
        onArCoreViewCreated: whenARCoreViewCreated,
        enableTapRecognizer: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            item="assets/items/dress.png";
            Fluttertoast.showToast(msg: "Image changed");
            // whenARCoreViewCreated;
          });
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.camera_alt),
      ),
    )
    );
  }
}
