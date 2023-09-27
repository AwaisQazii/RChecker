import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeStates {
  loading,
  loaded,
}

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeStates.loading) {
    updateState();
  }

  updateState() {
    emit(HomeStates.loaded);
  }
}
