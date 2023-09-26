import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_checker/app/navigation_helper.dart';
import 'package:result_checker/widgets/global_methods.dart';

enum SubmitState { loading, valid, invalid, error, success }

class SubmitCubit extends Cubit<SubmitState> {
  final formKey = GlobalKey<FormState>();
  final rollNo = TextEditingController();
  final name = TextEditingController();
  final cnic = TextEditingController();
  final marks = TextEditingController();
  final year = TextEditingController();
  final district = TextEditingController();
  final college = TextEditingController();
  final coaching = TextEditingController();

  String error = '';
  SubmitCubit() : super(SubmitState.loading);

  submitForm(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        loader(context);
        final ref = FirebaseFirestore.instance.collection('results');
        final docID = ref.doc().id;

        final body = {
          'docId': docID,
          'name': name.text,
          'cnic': cnic.text.trim(),
          'seatNo': rollNo.text,
          'district': district.text,
          'marks': marks.text
        };
        await ref.doc(docID).set(body);
        pop();
        pop();

        emit(SubmitState.success);
      } catch (e) {
        pop();
        error = e.toString();
        log("$error");
        emit(SubmitState.error);
      }

      emit(SubmitState.valid);
    } else {
      pop();

      emit(SubmitState.invalid);
    }
  }
}
