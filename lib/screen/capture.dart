
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// class _HomePageState extends State<HomePage> {
//   late CameraDescription camera;
//   late CameraController controller;
//   late bool _isInited = false;
//   late String _url;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     WidgetsBinding.instance!.addPostFrameCallback((_) async {
//       final cameras = await availableCameras();
//       print(cameras);
//       // setState(() {});
//       controller = CameraController(cameras[0], ResolutionPreset.medium);
//       controller.initialize().then((value) => {
//             setState(() {
//               _isInited = true;
//             })
//           });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Camera"),
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         // child: _isInited ? CameraPreview(controller) : Container()
//         child: Column(
//           children: [
//             Expanded(
//               child: _isInited
//                   ? AspectRatio(
//                       aspectRatio: controller.value.aspectRatio,
//                       child: CameraPreview(controller),
//                     )
//                   : Container(),
//             ),
//             Container(
//               height: 152,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     height: 120,
//                     width: 120,
//                     child: _url != null
//                         ? Image.file(
//                             File(_url),
//                             height: 120,
//                             width: 120,
//                           )
//                         : Container(),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.camera),
//         onPressed: () async {
//           final path = join(
//               (await getTemporaryDirectory()).path, '${DateTime.now()}.png');
//           await controller.takePicture(path).then((res) => {
//                 setState(() {
//                   _url = path;
//                 })
//               });
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }

