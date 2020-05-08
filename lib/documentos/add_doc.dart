import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/documentos/bloc/docs_bloc.dart';
import 'package:proyecto_app_moviles/utils/constants.dart';

class AddDoc extends StatefulWidget {
  AddDoc({Key key}) : super(key: key);

  @override
  _AddDocState createState() => _AddDocState();
}

class _AddDocState extends State<AddDoc> {
  DocsBloc addDocsBloc;
  bool _banSave = false;
  /*@override
  void dispose() {
    addDocsBloc.close();
    super.dispose();
  }*/

  File _documento;

  @override
  Widget build(BuildContext context) {
    addDocsBloc = BlocProvider.of(context);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFFC6D8E1),
            title: Text("Seleccionar Documento")),
        body: BlocBuilder<DocsBloc, DocsState>(
          builder: (context, state) {
            if (state is DocGallery) {
              _documento = state.doc;
              _banSave = state.docAdd;
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
                        _documento != null
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Image.asset(
                                    DocAppImage,
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 200,
                                  ),
                                  Text("documento seleccionado correctamente"),
                                ],
                              ) //TODO intentar poner doc
                            : Container(
                                height: 150,
                                width: 150,
                                child: Image.asset(
                                  DocPreview,
                                  height: 150,
                                  width: 150,
                                ),
                              ),
                        SizedBox(height: 48),
                        Material(color: Theme.of(context).primaryColor,
                        shape: CircleBorder(),
                        elevation: 3,
                                                  child: IconButton(
                            icon: Icon(Icons.insert_drive_file),
                            onPressed: () {
                              BlocProvider.of<DocsBloc>(context)
                                  .add(ChooseDocs());
                            },
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: _banSave
                                  ? RaisedButton(
                                    child: Text("Guardar"),
                                    onPressed: () {
                                      addDocsBloc.add(SaveDataEvent());
                                      Future.delayed(
                                              Duration(milliseconds: 1500))
                                          .then((_) {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  )
                                  : Center(
                                      child: Text("Seleccione un archivo"),
                                    ),
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
