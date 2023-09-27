import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_checker/app/navigation_helper.dart';

enum SelectTestTypeState {
  initial,
  loading,
  error,
  success,
}

class SelectTestTypeCubit extends Cubit<SelectTestTypeState> {
  SelectTestTypeCubit() : super(SelectTestTypeState.initial) {
    getTestTypes();
  }
  String? errorMessage;
  // List<dynamic> testTypes = [];
  Stream<QuerySnapshot<Map<String, dynamic>>>? testTypes;
  getTestTypes() {
    try {
      emit(SelectTestTypeState.loading);

      final ref = FirebaseFirestore.instance.collection('test_types').snapshots();

      testTypes = ref;
      // testTypes = ref.docs;

      emit(SelectTestTypeState.success);
    } catch (e) {
      pop();
      errorMessage = e.toString();
      emit(SelectTestTypeState.error);
      return null;
    }
  }
}
