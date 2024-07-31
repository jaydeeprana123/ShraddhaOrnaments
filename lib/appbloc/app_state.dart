part of 'app_bloc.dart';



@immutable
abstract class AppState extends Equatable {
  const AppState();
  @override
  List<Object> get props => [];
}

class App extends AppState {}

