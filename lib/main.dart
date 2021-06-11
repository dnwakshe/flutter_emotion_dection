
import 'dart:io' as i;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage()
    );
  }
}
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState()=> _HomePageState();
}
class _HomePageState extends State<HomePage> {
   late CameraDescription camera;
   late CameraController controller;
   bool _isInited = false;
   late String _url="lib\img";

   late i.File _image;
  final picker = ImagePicker();


   getFilePath() async {
    i.Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    //String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = 'lib\img'; // 3

    return filePath;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final cameras = await availableCameras();
      print(cameras);
      // setState(() {});
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      controller.initialize().then((value) => {
            setState(() {
              _isInited = true;
            })
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // child: _isInited ? CameraPreview(controller) : Container()
        child: Column(
          children: [
            Expanded(
              child: _isInited
                  ? AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: CameraPreview(controller),
                    )
                  : Container(),
            ),
            Container(
              height: 152,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    child: _url != null
                        ? Image.file(
                            i.File(_url),
                            height: 120,
                            width: 120,
                          )
                        : Container(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          final path = join(

              (await getTemporaryDirectory()).path, '${DateTime.now()}.png');
                await controller.takePicture().then((res) => {


                setState(() {
                 _url= res.path;
                i.File file = i.File( getFilePath()); // 1
                file.writeAsString(_url);
               
                })
              });

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
