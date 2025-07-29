// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'package:morf/morf.dart';

class InputController extends BaseController<String> {
  InputController(
    super.morf, {
    required super.tag,
    required super.label,
    super.required,
    super.requiredMessage,
    super.validators,
    super.hint,
    super.helper,
    super.onListen,
    super.onSubmitted,
    super.obscureText,
    super.eagerError,
    super.autoValidate,
    super.obscuringCharacter,
  });
}
