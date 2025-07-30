// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'package:morf/src/morf.dart';

typedef SelectionResolver<T> = T Function(List<T>, dynamic);

class SelectionController<T> extends TransformableSelectionController<T, T> {
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

class TransformableSelectionController<T, V> extends BaseController<T> {
  TransformableSelectionController(
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
    this.selectionResolver,
  }) : _items = items;

  final ValueTransformer<T, String>? labelTransformer;
  final ValueTransformer<T, V>? valueTransformer;
  final SelectionResolver<T>? selectionResolver;

  List<T> _items;

  List<T> get items => _items;

  set items(List<T> items) {
    _items = items;
    notifyListeners();
  }

  V? get transformedValue => valueTransformer?.call(value);

  String? get transformedLabel => labelTransformer?.call(value);
}
