// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'dart:convert';

import 'package:flutter/foundation.dart';

part 'base/base_controller.dart';

mixin Morf {
  final Set<BaseController> _inputs = {};

  void _add(BaseController input) {
    _inputs.add(input);
  }
}
