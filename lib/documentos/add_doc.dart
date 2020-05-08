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
      backgroundColor: BACK_COLOR2,
        appBar: AppBar(
            backgroundColor: BAR_COLOR,
            leading: BackButton(color: Colors.white),
            title: Text("Seleccionar documento",style: TextStyle(color: COLOR_WHI),)),
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
                        Material(color: BUTTON_COLOR,
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
                                    color: BUTTON_SAVE,
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
                                      child: Text("Seleccione un archivo",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 18),
                                      textAlign: TextAlign.center,),
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
