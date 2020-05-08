import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/documentos/bloc/docs_bloc.dart';
import 'package:share_extend/share_extend.dart';

class ItemDoc extends StatefulWidget {
  final String docUrl;
  final String docName;
  final int index;
  final String ruta;
  ItemDoc(
      {Key key,
      @required this.docUrl,
      @required this.docName,
      @required this.index,
      @required this.ruta})
      : super(key: key);

  @override
  _ItemDocState createState() => _ItemDocState();
}

class _ItemDocState extends State<ItemDoc> {
  DocsBloc docsBloc;

  @override
  Widget build(BuildContext context) {
    docsBloc = BlocProvider.of(context);
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //Text(" ${widget.index + 1}. ",style: TextStyle(fontWeight: FontWeight.bold),),
              Text(" ${widget.docName}",style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  _shareStorageFile(widget.index);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: <Widget>[
                        MaterialButton(
                            child: Text("Cancelar"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        MaterialButton(
                          child: Text("Borrar"),
                          onPressed: () {
                            docsBloc.add(
                              RemoveDataEvent(index: widget.index),
                            );
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _shareStorageFile(int index) async {
    File testFile = File(widget.ruta);
    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
  }
}
