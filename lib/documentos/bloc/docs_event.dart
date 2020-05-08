part of 'docs_bloc.dart';

abstract class DocsEvent extends Equatable {
  const DocsEvent();
}

class GetDataEvent extends DocsEvent {
  @override
  List<Object> get props => [];
}

class RemoveDataEvent extends DocsEvent {
  final int index;

  RemoveDataEvent({
    @required this.index,
  });
  @override
  List<Object> get props => [index];
}

class SaveDataEvent extends DocsEvent {
  //final String materia;
  //final String descripcion;

  @override
  List<Object> get props => [];
}

class ChooseDocs extends DocsEvent {
  @override
  List<Object> get props => [];
}

class GuardarPress extends DocsEvent {
  @override
  List<Object> get props => [];
}

class CargarDocsEvent extends DocsEvent {
  final File docsOtherApp;

  CargarDocsEvent({
    @required this.docsOtherApp,
  });

  @override
  List<Object> get props => [docsOtherApp];
}
