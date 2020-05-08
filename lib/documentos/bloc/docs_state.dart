part of 'docs_bloc.dart';

abstract class DocsState extends Equatable {
  const DocsState();
}

class DocsInitial extends DocsState {
  @override
  List<Object> get props => [];
}

class CloudStoreError extends DocsState {
  final String errorMessage;

  CloudStoreError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class CloudStoreRemoved extends DocsState {
  @override
  List<Object> get props => [];
}

class CloudStoreSaved extends DocsState {
  @override
  List<Object> get props => [];
}

class CloudStoreGetData extends DocsState {
  @override
  List<Object> get props => [];
}

class CargaDoc extends DocsState{
  final bool carga;

  CargaDoc({@required this.carga});

  List<Object> get props => [carga];
}
class DocGallery extends DocsState{
  final File doc;
  final bool docAdd;

  DocGallery( {@required this.docAdd, this.doc});

  List<Object> get props => [doc];
}

class DocGalleryM extends DocsState {
  final String errorMessageGallery;

  DocGalleryM({@required this.errorMessageGallery});
  @override
  List<Object> get props => [errorMessageGallery];
}

class DatoCargado extends DocsState {
  final bool otro;
  final String url;

  DatoCargado( {@required this.url,this.otro,});
   @override
  List<Object> get props => [url, otro];
}

class CargandoDatos extends DocsState {
  final bool isLoading;

  CargandoDatos({@required this.isLoading});
   @override
  List<Object> get props => [isLoading];
}