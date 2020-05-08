import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:proyecto_app_moviles/imagenes/bloc/images_bloc.dart';
import 'package:share_extend/share_extend.dart';

class IndImage extends StatefulWidget {
  final String imageUrl;
  final String ruta;
  IndImage({Key key, @required this.imageUrl, @required this.ruta}) : super(key: key);

  @override
  _IndImageState createState() => _IndImageState();
}



class _IndImageState extends State<IndImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(color: Colors.white),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _shareStorageFile();
                  });
                },
                child: Icon(
                  Icons.share,
                  size: 26.0,
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: Center(
        child: ClipRect(
          child: PhotoView(
            imageProvider: NetworkImage(
              "${widget.imageUrl}",
            ),
          ),
        ),
      ),
    );
  }
  Future _shareStorageFile() async {
    File testFile = File(widget.ruta);
    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
  }  
}
