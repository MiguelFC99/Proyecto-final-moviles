import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:proyecto_app_moviles/models/imagen_model.dart';
import 'package:path/path.dart' as Path;

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final Firestore _firestoreInstance = Firestore.instance;
  List<ImagenModel> _imagesList;
  List<DocumentSnapshot> _documentsList;
  List<ImagenModel> get getImagesList => _imagesList;
  @override
  ImagesState get initialState => ImagesInitial();
  File imagenp, imagenApp;
  bool actualizar, boolImagenApp = false;
  String imageRuta, imageRuta2;

  @override
  Stream<ImagesState> mapEventToState(
    ImagesEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetDataEvent) {
      bool dataRetrieved = await _getData();
      if (dataRetrieved)
        yield CloudStoreGetData();
      else
        yield CloudStoreError(
          errorMessage: "No se ha podido conseguir datos.",
        );
    } else if (event is SaveDataEvent) {
      String url1 = await _uploadFile();
      bool saved = await _saveApunte(url1, imageRuta);
      if (saved) {
        await _getData();
        yield CloudStoreSaved();
      } else
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente guardar mas tarde.",
        );
    } else if (event is RemoveDataEvent) {
      try {
        await _documentsList[event.index].reference.delete();
        _documentsList.removeAt(event.index);
        _imagesList.removeAt(event.index);
        yield CloudStoreRemoved();
      } catch (err) {
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente borrar mas tarde.",
        );
      }
    } else if (event is ChooseImage) {
      try {
        if (event.bandera) {
          imagenp = await _takePicture();
        } else {
          imagenp = await _chooseImage();
        }
        yield ImageGallery(image: imagenp);
      } catch (err) {
        yield ImageGalleryM(
          errorMessageGallery: "Ha ocurrido un error con la imagen.",
        );
      }
    } /*else if (event is GuardarPress) {
      String url1 = await _uploadFileApp();
      bool saved = await _saveApunteApp(url1, imageRuta2);
      if (saved) {
        await _getData();
        yield CloudStoreSaved();
      } else
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente guardar mas tarde.",
        );
    }*/ else if (event is CargarImagesEvent) {
      imagenApp = event.imageOtherApp;
      String url1 = await _uploadFileApp();
      bool saved = await _saveApunteApp(url1, imageRuta2);
      if (saved) {
        await _getData();
      } 
    }
  }

  Future<bool> _getData() async {
    try {
      var images =
          await _firestoreInstance.collection("imagenes").getDocuments();
      _imagesList = images.documents
          .map(
            (images) => ImagenModel(
              imageUrl: images["imagen"],
              ruta: images["ruta"],
            ),
          )
          .toList();
      _documentsList = images.documents;
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> _saveApunte(
    String imageUrl,
    String ruta,
  ) async {
    try {
      await _firestoreInstance.collection("imagenes").document().setData({
        "imagen": imageUrl,
        "ruta": ruta,
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<File> _chooseImage() async {
    File _ima;
    await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
    ).then((image) {
      _ima = image;
    });
    return _ima;
  }

  Future<File> _takePicture() async {
    File _cam;
    await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
    ).then((image) {
      _cam = image;
    });
    return _cam;
  }

  Future<String> _uploadFile() async {
    String filePath = imagenp.path;
    imageRuta = filePath;
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("imagenes/${Path.basename(filePath)}");
    StorageUploadTask uploadTask = reference.putFile(imagenp);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((imageUrl) {
      print("Link>>>>> $imageUrl");
    });
    return await reference.getDownloadURL();
  }

  //funciones al recibir una imagen de otra App

  Future _saveApunteApp(
    String imageUrl,
    String ruta,
  ) async {
    try {
      await _firestoreInstance.collection("imagenes").document().setData({
        "imagen": imageUrl,
        "ruta": ruta,
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<String> _uploadFileApp() async {
    String filePath = imagenApp.path;
    imageRuta2 = filePath;
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("imagenes/${Path.basename(filePath)}");
    StorageUploadTask uploadTask = reference.putFile(imagenApp);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((imageUrl) {
      print("Link>>>>> $imageUrl");
    });
    return await reference.getDownloadURL();
  }
}
