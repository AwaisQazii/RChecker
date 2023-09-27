import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_checker/app/navigation_helper.dart';
import 'package:result_checker/domain/models/form_model.dart';
import 'package:result_checker/widgets/global_methods.dart';

enum ResultFormState { loading, valid, invalid, error, success }

class ResultFormCubit extends Cubit<ResultFormState> {
  final formKey = GlobalKey<FormState>();

  String error = '';
  ResultFormCubit() : super(ResultFormState.loading);

  submitForm(
    BuildContext context, {
    required String name,
    required String cnic,
    required String rollNo,
    required String testName,
    required String district,
    required String marks,
    required String? coaching,
    required String? college,
    required String attempt,
    required String year,
  }) async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        emit(ResultFormState.loading);
        final ref = FirebaseFirestore.instance.collection('results');
        final docID = ref.doc().id;

        final form = FormModel(
          docId: docID,
          name: name,
          cnic: cnic,
          seatNo: rollNo,
          district: district,
          testName: testName,
          college: college ?? "",
          marks: double.parse(marks),
          coaching: coaching ?? "",
          attempt: int.parse(attempt),
          year: int.parse(year),
        );
        await ref.doc(docID).set(form.toJson());

        final testNameExists = await doesTestNameExist(testName);

        if (!testNameExists) {
          await FirebaseFirestore.instance.collection('test_types').doc().set({'name': testName});
        }

        emit(ResultFormState.success);
      } catch (e) {
        error = e.toString();
        log(error);
        emit(ResultFormState.error);
      }

      emit(ResultFormState.valid);
    } else {
      emit(ResultFormState.invalid);
    }
  }

  Future<bool> doesTestNameExist(String testName) async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('results').where('testName', isEqualTo: testName).get();

    // Check if there are any documents that match the query
    return querySnapshot.docs.isNotEmpty;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
