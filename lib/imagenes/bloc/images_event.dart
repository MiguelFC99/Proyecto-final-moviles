part of 'images_bloc.dart';

abstract class ImagesEvent extends Equatable {
  const ImagesEvent();
}

class GetDataEvent extends ImagesEvent {
  @override
  List<Object> get props => [];
}

class RemoveDataEvent extends ImagesEvent {
  final int index;

  RemoveDataEvent({
    @required this.index,
  });
  @override
  List<Object> get props => [index];
}

class SaveDataEvent extends ImagesEvent {
  //final String materia;
  //final String descripcion;

  @override
  List<Object> get props => [];
}

class ChooseImage extends ImagesEvent {
  final bool bandera;
  ChooseImage({
    @required this.bandera,
  });

   @override
  List<Object> get props => [bandera];
}

class GuardarPress extends ImagesEvent {
  
  @override
  List<Object> get props => [];
}


// imagen recivida de otra app
class CargarImagesEvent extends ImagesEvent {
  final File imageOtherApp;

  CargarImagesEvent({
    @required this.imageOtherApp,
  });
  @override
  List<Object> get props => [imageOtherApp];
}
