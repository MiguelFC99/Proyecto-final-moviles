import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/imagenes/add_image.dart';
import 'package:proyecto_app_moviles/imagenes/bloc/images_bloc.dart';
import 'package:proyecto_app_moviles/imagenes/ind_image.dart';
import 'package:proyecto_app_moviles/utils/constants.dart';

class Images extends StatefulWidget {
  Images({Key key}) : super(key: key);

  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  ImagesBloc bloc;

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
        title: Text("Imágenes"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: UniqueKey(),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: bloc,
                child: AddImage(), //AddApunte(),
              ),
            ),
          );
        },
        label: Text("Agregar"),
        icon: Icon(Icons.add_box),
      ),
      body: BlocProvider(
        create: (context) {
          bloc = ImagesBloc()..add(GetDataEvent());
          return bloc;
        },
        child: BlocListener<ImagesBloc, ImagesState>(
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
          child: BlocBuilder<ImagesBloc, ImagesState>(
            builder: (context, state) {
              if (state is ImagesInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return bloc.getImagesList.length != null && bloc.getImagesList.length != 0
                  ? GridView.builder(
                      itemCount: bloc.getImagesList.length == null
                          ? 0
                          : bloc.getImagesList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            setState(() {
                              _deleteImage(index);
                              print("QUEPEDOOOOO");
                            });
                          },
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => IndImage(
                                    imageUrl:
                                        bloc.getImagesList[index].imageUrl,
                                    ruta: bloc.getImagesList[index].ruta)));
                          },
                          child: Image.network(
                            bloc.getImagesList[index].imageUrl ??
                                "https://via.placeholder.com/150",
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    )
                  : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                          "No hay imagenes cargadas en la base de datos,\n agregue imagen",
                        ),
                      ),
                  );
            },
          ),
        ),
      ),
    );
  }

  _deleteImage(int index) {
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
                      bloc.add(
                        RemoveDataEvent(index: index),
                      );
                      Navigator.of(context).pop();
                    })
              ],
            ));
  }
}

/*ListView.builder(
                itemCount: bloc.getApuntesList.length == null ? 0 : 10,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => IndImage(
                              imageUrl: bloc.getApuntesList[index].imageUrl),
                        ),
                      );
                    },
                    child: ItemApuntes(
                      key: UniqueKey(),
                      index: index,
                      imageUrl: bloc.getApuntesList[index].imageUrl,
                      materia: bloc.getApuntesList[index].materia ?? "No name",
                      descripcion: bloc.getApuntesList[index].descripcion ??
                          "No description",
                    ),
                  );
                },
              );*/
