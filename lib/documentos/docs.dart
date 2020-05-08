

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/documentos/add_doc.dart';
import 'package:proyecto_app_moviles/documentos/item_doc.dart';
import 'package:proyecto_app_moviles/utils/constants.dart';
import 'package:open_file/open_file.dart';

import 'bloc/docs_bloc.dart';

class Docs extends StatefulWidget {
  Docs({Key key}) : super(key: key);

  @override
  _DocsState createState() => _DocsState();
}

class _DocsState extends State<Docs> {
  DocsBloc bloc;
  //File _document;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: Color(0xFF9AB3BE),
        title: Text("My Folder"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: UniqueKey(),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: bloc,
                child: AddDoc(), //AddApunte(),
              ),
            ),
          );
        },
        label: Text("Agregar"),
        icon: Icon(Icons.add_box),
      ),
      body: BlocProvider(
        create: (context) {
          bloc = DocsBloc()..add(GetDataEvent());
          return bloc;
        },
        child: BlocListener<DocsBloc, DocsState>(
          listener: (context, state) {
            if (state is CloudStoreRemoved) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Se ha eliminado el elemento."),
                  ),
                );
            } else if (state is CloudStoreError) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("${state.errorMessage}"),
                  ),
                );
            } else if (state is CloudStoreSaved) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Se ha guardado el elemento."),
                  ),
                );
            } else if (state is CloudStoreGetData) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Descargando datos..."),
                  ),
                );
            }
          },
          child: BlocBuilder<DocsBloc, DocsState>(
            builder: (context, state) {
              if (state is DocsInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return bloc.getdocsList.length != null
                  ? ListView.builder(
                      itemCount: bloc.getdocsList.length == null
                          ? 0
                          : bloc.getdocsList.length,
                      padding: EdgeInsets.all(8),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              OpenFile.open(bloc.getdocsList[index].ruta);
                            });
                          },
                          child: ItemDoc(
                            key: UniqueKey(),
                            docUrl: bloc.getdocsList[index].docUrl,
                            docName: bloc.getdocsList[index].docName,
                            index: index,
                            ruta: bloc.getdocsList[index].ruta,
                          ),
                        );
                      },
                    )
                  : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                            "No hay archivos almacenados, agregue un nuevo archivo"),
                      ),
                  );
            },
          ),
        ),
      ),
    );
  }
}
