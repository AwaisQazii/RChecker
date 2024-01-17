import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_checker/app/navigation_helper.dart';
import 'package:result_checker/domain/models/form_model.dart';
import 'package:result_checker/widgets/global_methods.dart';

enum ResultFormState { loading, valid, invalid, error, success, reset }

class ResultFormCubit extends Cubit<ResultFormState> {
  final formKey = GlobalKey<FormState>();
  final rollNo = TextEditingController();
  final name = TextEditingController();
  final testName = TextEditingController();

  final attempt = TextEditingController();
  final cnic = TextEditingController();
  final marks = TextEditingController();
  final year = TextEditingController();
  final district = TextEditingController();
  final college = TextEditingController();
  final coaching = TextEditingController();

  String errorMessage = '';
  ResultFormCubit() : super(ResultFormState.loading);

  pop() {
    emit(ResultFormState.reset);
  }

  validState() {
    if (formKey.currentState?.validate() ?? false) {
      emit(ResultFormState.valid);
    } else {
      emit(ResultFormState.invalid);
    }
  }

  submitForm(BuildContext context) async {
    try {
      emit(ResultFormState.loading);
      final ref = FirebaseFirestore.instance.collection('results');
      final docID = ref.doc().id;

      double testMarks = 0.0;
      int noOfAttempts = 0;
      int testYear = 0;

      if (marks.text.isNotEmpty) {
        testMarks = double.parse(marks.text);
      }

      if (attempt.text.isNotEmpty) {
        noOfAttempts = int.parse(attempt.text);
      }

      if (year.text.isNotEmpty) {
        testYear = int.parse(year.text);
      }

      final form = FormModel(
        docId: docID,
        name: name.text,
        cnic: cnic.text,
        seatNo: rollNo.text,
        district: district.text,
        testName: testName.text,
        college: college.text,
        marks: testMarks,
        coaching: coaching.text,
        attempt: noOfAttempts,
        year: testYear,
      );

      final cnicExists = await doesCNICExist(cnic.text);

      if (cnicExists) {
        errorMessage = "candidate already exists";
        emit(ResultFormState.error);
      } else {
        await ref.doc(docID).set(form.toJson());
      }

      final testNameExists = await doesTestNameExist(testName.text);

      if (!testNameExists) {
        await FirebaseFirestore.instance.collection('test_types').doc().set({'name': testName});
      }

      emit(ResultFormState.success);
    } catch (e) {
      errorMessage = e.toString();
      log(errorMessage);
      emit(ResultFormState.error);
    }

    emit(ResultFormState.valid);
  }

  Future<bool> doesTestNameExist(String testName) async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('results').where('testName', isEqualTo: testName).get();

    // Check if there are any documents that match the query
    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> doesCNICExist(String cnic) async {
    final querySnapshot = await FirebaseFirestore.instance.collection('results').where('cnic', isEqualTo: cnic).get();

    // Check if there are any documents that match the query
    return querySnapshot.docs.isNotEmpty;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
