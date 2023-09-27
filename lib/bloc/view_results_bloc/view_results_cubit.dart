import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_checker/domain/models/form_model.dart';

enum ResultListState { loading, success, error }

class ViewResultsCubit extends Cubit<ResultListState> {
  ViewResultsCubit() : super(ResultListState.loading);

  Stream<QuerySnapshot<Map<String, dynamic>>>? resultsStream;
  String errorMessage = '';
  String title = "View Result";

  Future<void> getResults() async {
    try {
      emit(ResultListState.loading);

      final ref = FirebaseFirestore.instance
          .collection('results')
          .where('testName', isEqualTo: title.toUpperCase())
          .snapshots();

      resultsStream = ref;

      emit(ResultListState.success);
    } catch (e) {
      errorMessage = e.toString();
      emit(ResultListState.error);
    }
  }

  Future<void> getSearched({String? value}) async {
    try {
      emit(ResultListState.loading);

      log("${value}");
      if (value != null && value.isNotEmpty) {
        final ref = FirebaseFirestore.instance
            .collection('results')
            .where('testName', isEqualTo: title)
            .where('district', isEqualTo: value.toUpperCase())
            .snapshots();
        resultsStream = ref;
      } else {
        getResults();
      }

      emit(ResultListState.success);
    } catch (e) {
      errorMessage = e.toString();
      emit(ResultListState.error);
    }
  }
}
