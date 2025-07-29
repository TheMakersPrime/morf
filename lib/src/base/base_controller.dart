// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

part of '../morf.dart';

typedef InputValidator<T> = String? Function(T? value);
typedef ValueTransformer<T, V> = V Function(T? value);

abstract class BaseController<T> with ChangeNotifier {
  BaseController(
    this.morf, {
    required this.tag,
    required this.label,
    this.required = true,
    this.requiredMessage = 'This field is required',
    this.validators,
    this.hint,
    this.helper,
    this.onListen,
    this.onSubmitted,
    this.obscureText = false,
    this.eagerError = false,
    this.autoValidate = false,
    this.obscuringCharacter = '*',
  }) {
    morf._add(this);
  }

  //region Properties

  /// Link the InputController to the main Morf mixin
  final Morf morf;

  /// Mark field as required
  /// [true] by default
  final bool required;

  /// Should the input text in a field be obscured.
  /// Valid only for TextFields
  final bool obscureText;

  /// Should an error from the validator be returned eagerly or wait
  /// for all validator invocations
  final bool eagerError;

  /// Should the field be validated as input comes in or wait
  /// for the [validate] function to be triggered manually
  final bool autoValidate;

  /// Field tag
  final String tag;

  /// Field label text
  final String label;

  /// Field hint text
  final String? hint;

  /// Field helper text
  final String? helper;

  /// Message to be displayed when field required validation is triggered
  final String requiredMessage;

  /// Character to be used in place of the input text
  final String obscuringCharacter;

  /// Set of validators for the field
  final Set<InputValidator<T>>? validators;

  /// Attach value listener
  ///
  /// This triggers when input value changes
  final ValueChanged<T?>? onListen;

  /// Callback for when user taps on the return/enter button
  final ValueChanged<T>? onSubmitted;

  String? _error;
  T? _value;

  //endregion

  //region Functions

  T? get value => _value;

  String? get error => _error;

  set error(String? value) {
    _error = value;
    notifyListeners();
  }

  void reset() => onChanged(null);

  @mustCallSuper
  void onChanged(T? value) {
    _value = value;
    onListen?.call(_value);
    if (_value != null) {
      if (autoValidate) {
        validate();
        return;
      }

      _error = null;
      notifyListeners();
    }
  }

  @protected
  bool validate() {
    if (required && _value == null) {
      _error = requiredMessage;
      notifyListeners();
      return false;
    }

    if (validators != null && _value != null) {
      final errorBuffer = StringBuffer();

      for (final validator in validators!) {
        final error = validator(_value);
        if (error != null) errorBuffer.writeln(error);

        if (eagerError && errorBuffer.isNotEmpty) break;
      }

      _error = errorBuffer.toString();
      if (_error != null && _error!.isNotEmpty) {
        notifyListeners();
        return false;
      }
    }

    return true;
  }

  @protected
  bool get hasErrors => _error != null;

  @override
  String toString() {
    final map = {
      'tag': tag,
      'required': required,
      'label': label,
      'hint': hint,
      'helper': helper,
      'obscureText': obscureText,
      'eagerError': eagerError,
      'autoValidate': autoValidate,
      'requiredMessage': requiredMessage,
      'value': _value,
      'error': _error,
      'obscuringCharacter': obscuringCharacter,
    };

    return const JsonEncoder.withIndent(' ').convert(map);
  }

  //endregion
}
