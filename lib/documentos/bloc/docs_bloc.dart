import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:proyecto_app_moviles/models/doc_model.dart';
import 'package:path/path.dart' as Path;

part 'docs_event.dart';
part 'docs_state.dart';

class DocsBloc extends Bloc<DocsEvent, DocsState> {
  final Firestore _firestoreInstance = Firestore.instance;
  List<DocModel> _docsList;
  List<DocumentSnapshot> _documentsList;
  List<DocModel> get getdocsList => _docsList;

  @override
  DocsState get initialState => DocsInitial();
  File _docs, _docsApp;
  String _docName, _docName2;
  String _ruta, _ruta2;
  bool _docAdd;

  @override
  Stream<DocsState> mapEventToState(
    DocsEvent event,
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
      bool saved = await _saveApunte(url1, _docName, _ruta);
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
        _docsList.removeAt(event.index);
        yield CloudStoreRemoved();
      } catch (err) {
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente borrar mas tarde.",
        );
      }
    } else if (event is ChooseDocs) {
      try {
        _docs = await _chooseFile();
        _docs != null ? _docAdd = true : _docAdd = false;
        yield DocGallery(doc: _docs, docAdd: _docAdd);
      } catch (err) {
        yield DocGalleryM(
          errorMessageGallery: "Ha ocurrido un error con el documento.",
        );
      }
    } else if (event is GuardarPress) {
      String url1 = await _uploadFileApp();
      bool saved = await _saveApunteApp(url1, _docName2, _ruta2);
      if (saved) {
        await _getData(); 
      }
    } else if (event is CargarDocsEvent) {
      _docsApp = event.docsOtherApp;
    }
  }

  Future<bool> _getData() async {
    try {
      var docs =
          await _firestoreInstance.collection("documentos").getDocuments();
      _docsList = docs.documents
          .map(
            (docs) => DocModel(
              docUrl: docs["document"],
              docName: docs["nombre"],
              ruta: docs["ruta"],
            ),
          )
          .toList();
      _documentsList = docs.documents;
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> _saveApunte(
    String docsUrl,
    String nombre,
    String ruta,
  ) async {
    try {
      await _firestoreInstance.collection("documentos").document().setData({
        "document": docsUrl,
        "nombre": nombre,
        "ruta": ruta,
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<File> _chooseFile() async {
    File _doc;
    await FilePicker.getFile(
      type: FileType.any,
    ).then((docu) {
      _doc = docu;
    });

    return _doc;
  }

  Future<String> _uploadFile() async {
    String filePath = _docs.path;
    _ruta = filePath;
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("documentos/${Path.basename(filePath)}");
    StorageUploadTask uploadTask = reference.putFile(_docs);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((documentUrl) {
      print("Link>>>>> $documentUrl");
    });
    taskSnapshot.ref.getName().then((docName) {
      _docName = docName;
    });
    return await reference.getDownloadURL();
  }

  Future<String> _uploadFileApp() async {
    String filePath = _docsApp.path;
    _ruta2 = filePath;
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("documentos/${Path.basename(filePath)}");
    StorageUploadTask uploadTask = reference.putFile(_docsApp);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((documentUrl) {
      print("Link>>>>> $documentUrl");
    });
    taskSnapshot.ref.getName().then((docName) {
      _docName2 = docName;
    });
    return await reference.getDownloadURL();
  }

  Future<bool> _saveApunteApp(
    String docsUrl,
    String nombre,
    String ruta,
  ) async {
    try {
      await _firestoreInstance.collection("documentos").document().setData({
        "document": docsUrl,
        "nombre": nombre,
        "ruta": ruta,
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }
}
