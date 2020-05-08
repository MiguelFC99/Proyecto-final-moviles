import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/documentos/bloc/docs_bloc.dart';
import 'package:proyecto_app_moviles/home/home_page.dart';
import 'package:proyecto_app_moviles/utils/constants.dart';
import 'dart:async';

import 'package:receive_sharing_intent/receive_sharing_intent.dart';

//void main() => runApp(ReceiveDocApp());

class ReceiveDocApp extends StatefulWidget {
  final StreamSubscription intentDataStreamSubscription;
  final List<SharedMediaFile> sharedFiles;
  final String sharedText;

  const ReceiveDocApp(
      {Key key,
      @required this.intentDataStreamSubscription,
      @required this.sharedFiles,
      @required this.sharedText})
      : super(key: key);

  @override
  _ReceiveDocAppState createState() => _ReceiveDocAppState();
}

class _ReceiveDocAppState extends State<ReceiveDocApp> {
  DocsBloc addDocBloc;

  @override
  void dispose() {
    addDocBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    File _documento =
        File(widget.sharedFiles?.map((f) => f.path)?.join(",") ?? "");

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFC6D8E1),
          title: Text("Archivo seleccionado")),
      body: BlocProvider(
        create: (context) {
          addDocBloc = DocsBloc();
          return addDocBloc;
        },
        child: BlocBuilder<DocsBloc, DocsState>(
          builder: (context, state) {
            if (_documento != null) {
              BlocProvider.of<DocsBloc>(context)
                  .add(CargarDocsEvent(docsOtherApp: _documento));
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Image.asset(
                              DocAppImage,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                            ),
                            Text("documento seleccionado correctamente"),
                          ],
                        ),
                        SizedBox(height: 48),
                        SizedBox(height: 24),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                child: Text("Guardar"),
                                onPressed: () {
                                  // TODO aqui esta el llamado de guardado al bloc
                                  //  BlocProvider.of<ApuntesBloc>(context).add(GuardarPress());

                                  addDocBloc.add(GuardarPress());
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
