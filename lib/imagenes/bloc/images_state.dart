part of 'images_bloc.dart';

abstract class ImagesState extends Equatable {
  const ImagesState();
}

class ImagesInitial extends ImagesState {
  @override
  List<Object> get props => [];
}

class CloudStoreError extends ImagesState {
  final String errorMessage;

  CloudStoreError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class CloudStoreRemoved extends ImagesState {
  @override
  List<Object> get props => [];
}

class CloudStoreSaved extends ImagesState {
  @override
  List<Object> get props => [];
}

class CloudStoreGetData extends ImagesState {
  @override
  List<Object> get props => [];
}

class CargaApunte extends ImagesState{
  final bool carga;

  CargaApunte({@required this.carga});

  List<Object> get props => [carga];
}
class ImageGallery extends ImagesState{
  final File image;

  ImageGallery({@required this.image});

  List<Object> get props => [image];
}

class ImageGalleryM extends ImagesState {
  final String errorMessageGallery;

  ImageGalleryM({@required this.errorMessageGallery});
  @override
  List<Object> get props => [errorMessageGallery];
}

class DatoCargado extends ImagesState {
  final bool otro;
  final String url;

  DatoCargado( {@required this.url,this.otro,});
   @override
  List<Object> get props => [url, otro];
}

class CargandoDatos extends ImagesState {
  final bool isLoading;

  CargandoDatos({@required this.isLoading});
   @override
  List<Object> get props => [isLoading];
}