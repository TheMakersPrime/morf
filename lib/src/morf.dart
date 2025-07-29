// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'dart:convert';

import 'package:flutter/foundation.dart';

part 'base/base_input_controller.dart';

mixin Morf {
  final Set<BaseInputController> _inputs = {};

  void _add(BaseInputController input) {
    _inputs.add(input);
  }
}
