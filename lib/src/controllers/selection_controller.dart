// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'package:morf/src/morf.dart';

class SelectionController<T> extends SelectionWithController<T, T> {
  SelectionController(
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
    super.items,
    super.labelTransformer,
  });
}

abstract class SelectionWithController<T, V> extends BaseController<T> {
  SelectionWithController(
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
    List<T> items = const [],
    this.labelTransformer,
    this.valueTransformer,
  }) : _items = items;

  final ValueTransformer<T, String>? labelTransformer;
  final ValueTransformer<T, V>? valueTransformer;
  List<T> _items;

  List<T> get items => _items;

  set items(List<T> items) {
    _items = items;
    notifyListeners();
  }
}
