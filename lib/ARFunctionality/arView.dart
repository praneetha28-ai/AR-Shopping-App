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
  // ArCoreController arCoreController;
  late ArCoreNode node;
   Offset lastOffset = Offset.zero;
  void _onArCoreViewCreated( ArCoreController controller){
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
   node= ArCoreNode(
      image: ArCoreImage(bytes: bytes, width: 600, height: 600),
      position: hitTestResult.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
      rotation: hitTestResult.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
      scale: vector.Vector3(0.5,0.5,0.5)
    );
    arCoreController.addArCoreNodeWithAnchor(node);
  }

  @override
  Widget build(BuildContext context) {
    // return RepaintBoundary(
    //   key: previewContainer,
    //   child:  Scaffold(
    //   body:  ArCoreView(
    //     onArCoreViewCreated: whenARCoreViewCreated,
    //     enableTapRecognizer: true,
    //   ),
    // )
    // );
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ARCore Example'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
        ),
      ),
    );
  }

  // void _onArCoreViewCreated(ArCoreController controller) {
  //   arCoreController = controller;
  //   // arCoreController.onPlaneTap= controlOnPlaneTap;
  //   _addImage(arCoreController);
  // }
  //
  // Future<void> _addImage(ArCoreController controller) async {
  //   final bytes = await rootBundle.load(item);
  //   final image = MemoryImage(bytes.buffer.asUint8List());
  //   final textureBytes = Uint8List.fromList(image.bytes.toList());
  //   final material = ArCoreMaterial(
  //     textureBytes: textureBytes,
  //   );
  //   final cube = ArCoreCube(
  //     materials: [material],
  //     size: vector.Vector3(0.3, 0.3, 0.3),
  //   );
  //   final node = ArCoreNode(
  //     shape: cube,
  //     position: vector.Vector3(0, 0, -1.5),
  //   );
  //   arCoreController.addArCoreNode(node);
  // }
  void _onPanUpdate(DragUpdateDetails details) {
    if (lastOffset == null) {
      lastOffset = details.globalPosition;
      return;
    }

    // Calculate the change in position along x, y, and z axes
    final dx = details.globalPosition.dx - lastOffset.dx;
    final dy = lastOffset.dy - details.globalPosition.dy;
    final dz = 0.0;

    // Update the position of the node along x, y, and z axes
    node.position?.value += vector.Vector3(dx / 100, dy / 100, dz / 100);

    lastOffset = details.globalPosition;
  }
}