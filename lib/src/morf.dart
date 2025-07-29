// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:morf/morf.dart';

part 'base/base_controller.dart';

mixin Morf {
  final Set<BaseController> _inputs = {};

  void _add(BaseController input) {
    _inputs.add(input);
  }

  FormData getFormData() {
    final formMap = <String, dynamic>{};
    final confirmMap = <String, String>{};

    for (final input in _inputs) {
      if (input.value != null) {
        final selectionWithTransform = input is TransformableSelectionController;
        final selection = input is SelectionController;
        if (selection || selectionWithTransform) {
          final _input = input as TransformableSelectionController;
          formMap[input.tag] = _input.transformedValue ?? input.value;
          confirmMap[input.label] = _input.transformedLabel ?? input.value;
        } else {
          formMap[input.tag] = input.value;
          confirmMap[input.label] = input.value;
        }
      }
    }
    return FormData(confirmMap: confirmMap, formMap: formMap);
  }

  void fillFormData(Map<String, dynamic> data) {
    for (final entry in data.entries) {
      final controller = _getController(entry.key);
      if (controller != null) {
        if (controller is TransformableSelectionController || controller is SelectionController) {
          // TODO (Ishwor) Complete
        } else {
          controller.onChanged(entry.value);
        }
      }
    }
  }

  void setErrors(Map<String, String> errors) {
    for (final entry in errors.entries) {
      final controller = _getController(entry.key);
      if (controller != null) {
        controller.error = entry.value;
      }
    }
  }

  bool validate({Set<BaseController>? inputs}) {
    final resolvedInputs = inputs ?? _inputs;
    bool formValid = true;
    for (final input in resolvedInputs) {
      if (!input.validate()) {
        formValid = false;
      }
    }
    return formValid;
  }

  void resetForm() {
    for (final input in _inputs) {
      input.reset();
    }
  }

  BaseController? _getController(String tag) {
    try {
      return _inputs.firstWhere((field) {
        return field.tag == tag;
      });
    } on Exception {
      return null;
    }
  }
}

class FormData {
  const FormData({
    required this.confirmMap,
    required this.formMap,
  });

  final Map<String, String> confirmMap;
  final Map<String, dynamic> formMap;
}
