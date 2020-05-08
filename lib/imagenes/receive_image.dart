import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/home/home_page.dart';
import 'package:proyecto_app_moviles/imagenes/bloc/images_bloc.dart';
import 'dart:async';

import 'package:receive_sharing_intent/receive_sharing_intent.dart';

//void main() => runApp(ReceiveImagenApp());


class ReceiveImagenApp extends StatefulWidget {
  final StreamSubscription intentDataStreamSubscription;
  final List<SharedMediaFile> sharedFiles;
  final String sharedText;

  const ReceiveImagenApp(
      {Key key,
      @required this.intentDataStreamSubscription,
      @required this.sharedFiles,
      @required this.sharedText})
      : super(key: key);

  @override
  _ReceiveImagenAppState createState() => _ReceiveImagenAppState();
}

class _ReceiveImagenAppState extends State<ReceiveImagenApp> {
  ImagesBloc addImageBloc;

  @override
  void dispose() {
    addImageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    File _choosenImage =
        File(widget.sharedFiles?.map((f) => f.path)?.join(",") ?? "");

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFC6D8E1),
          title: Text("Seleccionar imagen")),
      body: BlocProvider(
        create: (context) {
          addImageBloc = ImagesBloc();
          return addImageBloc;
        },
        child: BlocBuilder<ImagesBloc, ImagesState>(
          builder: (context, state) {
            if (_choosenImage != null) {
              BlocProvider.of<ImagesBloc>(context)
                  .add(CargarImagesEvent(imageOtherApp: _choosenImage));
            }
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Stack(
                  alignment: FractionalOffset.center,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _choosenImage != null
                            ? Image.file(
                                _choosenImage,
                                fit: BoxFit.cover,
                                height: 300,
                                width: 300,
                              ) //TODO intentar poner doc
                            : Container(
                                height: 150,
                                width: 150,
                                child: Placeholder(
                                  fallbackHeight: 150,
                                  fallbackWidth: 150,
                                ),
                              ),
                        SizedBox(height: 48),
                        SizedBox(height: 24),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                child: Text("Guardar"),
                                
                                onPressed: () {
                                  addImageBloc.add(GuardarPress());
                                  Future.delayed(Duration(milliseconds: 1500))
                                      .then((_) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomePage()));
                                  });

                                  print("vale kk mucha kkkkkkkkk");
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

