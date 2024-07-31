import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shradha_design/repositories/app_repository.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {

  final AppRepository appRepository;


  AppBloc({@required this.appRepository})
      : assert(appRepository != null),
        super(App());



  @override
  Stream<AppState> mapEventToState(AppEvent event,) async* {
   /* if (event is CatalogStarted) {
      yield* _mapCatalogStartedToState(event);
    }*/
  }

  
/*

  Stream<CatalogState> _mapCatalogStartedToState(CatalogStarted event) async* {
    yield CatalogLoading();
    try {

      var response = ShopBybrandResponse.fromJson(json.decode(await appRepository.getData(event.parms)));


     */

/* final ShopBybrandResponse weather = await appRepository.getData();
      yield CatalogLoaded(weather: weather);
     *//*



      await Future<void>.delayed(const Duration(milliseconds: 500));
      yield CatalogLoaded(response);



    } catch (_) {
      yield CatalogError();
    }
  }
*/



}
