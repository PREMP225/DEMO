import 'dart:ffi';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
class ShowCamraView extends StatefulWidget {
  const ShowCamraView({super.key});

  @override
  State<ShowCamraView> createState() => _ShowCamraViewState();
}

class _ShowCamraViewState extends State<ShowCamraView> {

  CameraController? cameraController;
late List<CameraDescription>  cameras;


void startCamra()async{
cameras  = await availableCameras();

cameraController = CameraController(cameras.first, ResolutionPreset.medium,enableAudio: false);
 
 await cameraController!.initialize().then((value){
  if(!mounted){
    return;

  }
  setState(() {
debugPrint('======>');    
  });
 });
 }



 @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
  }
  

  @override
  void initState() {
    super.initState();
 startCamra();
  }


  @override
  Widget build(BuildContext context) {
    

if(cameraController != null &&  cameraController!.value.isInitialized){

  return Scaffold(
    body: Column(
      children: [
        CameraPreview(cameraController!)
      ],
    ),
  );
}else{
  return Container(
    height: 500,
    width: MediaQuery.of(context).size.width,
    child: Center(
      child: CircularProgressIndicator(color: Colors.blue,),
    ),
  );
}

  
  }
}