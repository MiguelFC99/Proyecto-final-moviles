import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/home/home_page.dart';
import 'package:proyecto_app_moviles/imagenes/bloc/images_bloc.dart';
import 'dart:async';

import 'package:receive_sharing_intent/receive_sharing_intent.dart';

//void main() => runApp(Prueba());

class Prueba extends StatefulWidget {
  final StreamSubscription intentDataStreamSubscription;
  final List<SharedMediaFile> sharedFiles;
  final String sharedText;

  const Prueba(
      {Key key,
      @required this.intentDataStreamSubscription,
      @required this.sharedFiles,
      @required this.sharedText})
      : super(key: key);

  @override
  _PruebaState createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
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
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Material(
                              shape: CircleBorder(),
                              elevation: 3,
                              child: IconButton(
                                icon: Icon(Icons.camera),
                                onPressed: () {
                                  BlocProvider.of<ImagesBloc>(context)
                                      .add(ChooseImage(bandera: true));
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.image),
                              onPressed: () {
                                BlocProvider.of<ImagesBloc>(context)
                                    .add(ChooseImage(bandera: false));
                              },
                            ),
                          ],
                        ),*/
                        /*IconButton(
                          icon: Icon(Icons.image),
                          onPressed: () {
                            BlocProvider.of<ImagesBloc>(context)
                                .add(ChooseImage(bandera: true));
                          },
                        ),*/
                        SizedBox(height: 24),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                child: Text("Guardar"),
                                
                                onPressed: () {
                                  // TODO aqui esta el llamado de guardado al bloc
                                  //  BlocProvider.of<ApuntesBloc>(context).add(GuardarPress());

                                  //addImageBloc.add(GuardarPress());
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
                              /*Center(
                                      child: Text(
                                          "Tome una foto o seleccione imagen de la galeria")),*/
                            ),
                          ],
                        ),
                      ],
                    ),
                    //_isLoading ? CircularProgressIndicator() : Container(),
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

/*import 'dart:io';

class _ReceiveImageState extends State<ReceiveImage> {
  StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile> _sharedFiles;
  String _sharedText;

  ImagesBloc addImageBloc;
  bool _banSave = false;

  /* @override
    void dispose() {
    addImageBloc.close();
    super.dispose();
  }*/

  

  @override
  void initState() {
    super.initState();
    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getMediaStream().listen((List<SharedMediaFile> value) {
      setState(() {
        print("Shared:" + (_sharedFiles?.map((f)=> f.path)?.join(",") ?? ""));
        _sharedFiles = value;
      });
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value;
      });
    });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        _sharedText = value;
      });
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String value) {
      setState(() {
        _sharedText = value;
      });
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    addImageBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    File _choosenImage = File(_sharedFiles?.map((f)=> f.path)?.join(",") ?? "");
    
    
    
    //addImageBloc = BlocProvider.of(context);

    //addImageBloc.add(CargarImagesEvent(imageOtherApp: _choosenImage));

    //BlocProvider.of<ImagesBloc>(context).add(CargarImagesEvent(imageOtherApp: _choosenImage));

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFFC6D8E1),
            title: Text("Seleccionar imagen")),
        body:  BlocProvider(create: (context){
            addImageBloc = ImagesBloc();
            return addImageBloc;
        },
        child: BlocBuilder<ImagesBloc, ImagesState>(
          builder: (context, state) {
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
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Material(
                              shape: CircleBorder(),
                              elevation: 3,
                              child: IconButton(
                                icon: Icon(Icons.camera),
                                onPressed: () {
                                  BlocProvider.of<ImagesBloc>(context)
                                      .add(ChooseImage(bandera: true));
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.image),
                              onPressed: () {
                                BlocProvider.of<ImagesBloc>(context)
                                    .add(ChooseImage(bandera: false));
                              },
                            ),
                          ],
                        ),*/
                        /*IconButton(
                          icon: Icon(Icons.image),
                          onPressed: () {
                            BlocProvider.of<ImagesBloc>(context)
                                .add(ChooseImage(bandera: true));
                          },
                        ),*/
                        SizedBox(height: 24),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                      child: Text("Guardar"),
                                      onPressed: () {
                                        // TODO aqui esta el llamado de guardado al bloc
                                        //  BlocProvider.of<ApuntesBloc>(context).add(GuardarPress());

                                        //addImageBloc.add(SaveDataEvent());
                                        Future.delayed(
                                                Duration(milliseconds: 1500))
                                            .then((_) {
                                          return Images();
                                        });
                                      },
                                    )
                                  /*Center(
                                      child: Text(
                                          "Tome una foto o seleccione imagen de la galeria")),*/
                            )
                          ],
                        ),
                      ],
                    ),
                    //_isLoading ? CircularProgressIndicator() : Container(),
                  ],
                ),
              ),
            );
          },
        ),),
          );
  }




 /* @override
  Widget build(BuildContext context) {
    String prueba = _sharedFiles?.map((f)=> f.path)?.join(",") ?? "";
    const textStyleBold = const TextStyle(fontWeight: FontWeight.bold);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text("Shared files:", style: textStyleBold),
              Text(_sharedFiles?.map((f)=> f.path)?.join(",") ?? ""),
              SizedBox(height: 100),
              Text("Shared urls/text:", style: textStyleBold),
              Text(_sharedText ?? "")
            ],
          ),
        ),
      ),
    );
  }*/
}*/
