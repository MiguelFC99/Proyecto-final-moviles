import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/imagenes/bloc/images_bloc.dart';

class AddImage extends StatefulWidget {
  AddImage({Key key}) : super(key: key);

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  ImagesBloc addImageBloc;
  bool _banSave = false;

  /* @override
    void dispose() {
    addImageBloc.close();
    super.dispose();
  }*/

  File _choosenImage;

  @override
  Widget build(BuildContext context) {
    addImageBloc = BlocProvider.of(context);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFFC6D8E1),
            title: Text("Seleccionar imagen")),
        body: BlocBuilder<ImagesBloc, ImagesState>(
          builder: (context, state) {
            if (state is ImageGallery) {
              _choosenImage = state.image;
              if (_choosenImage == null) {
                _banSave = false;
              } else {
                _banSave = true;
              }
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
                        Row(
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
                        ),
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
                              child: _banSave
                                  ? RaisedButton(
                                      child: Text("Guardar"),
                                      onPressed: () {
                                        // TODO aqui esta el llamado de guardado al bloc
                                        //  BlocProvider.of<ApuntesBloc>(context).add(GuardarPress());

                                        addImageBloc.add(SaveDataEvent());
                                        Future.delayed(
                                                Duration(milliseconds: 1500))
                                            .then((_) {
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                          "Tome una foto o seleccione imagen de la galeria")),
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
        ));
  }
}

/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/imagenes/bloc/images_bloc.dart';

class AddImage extends StatefulWidget {
  AddImage({Key key}) : super(key: key);

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {

  ImagesBloc addImageBloc;

  @override
  void dispose() {
    addImageBloc.close();
    super.dispose();
  }

File _choosenImage;

  @override
  Widget build(BuildContext context) {
    addImageBloc = BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFC6D8E1),
          title: Text("Seleccionar imagen")),
      body: BlocBuilder<ImagesBloc, ImagesState>(
        builder: (context, state) {
          if(state is ImageGallery){
            _choosenImage = state.image;
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
                          width: 150,
                          height: 150,
                        )
                      : Container(
                          height: 150,
                          width: 150,
                          child: Placeholder(
                            fallbackHeight: 150,
                            fallbackWidth: 150,
                          ),
                        ),
                  SizedBox(height: 48),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      BlocProvider.of<ImagesBloc>(context).add(ChooseImage());
                    },
                  ),
                  SizedBox(height: 48),
                  SizedBox(height: 24),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text("Guardar"),
                          onPressed: () {
                           
                            addImageBloc.add(SaveDataEvent(
                            ));
                            Future.delayed(Duration(milliseconds: 1500))
                                .then((_) {
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
        },
      )
    );
  }
}*/
