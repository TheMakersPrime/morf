// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

part of '../morf.dart';

typedef InputValidator<T> = String? Function(T? value);
typedef ValueTransformer<T, V> = V Function(T? value);

abstract class BaseInputController<T> with ChangeNotifier {
  BaseInputController(
    this.morf, {
    required this.tag,
    required this.label,
    this.required = true,
    this.requiredMessage = 'This field is required',
    this.validators,
    this.hint,
    this.helper,
    this.onListen,
    this.initialValue,
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
  final ValueChanged? onSubmitted;

  /// Initial value for the input field
  T? initialValue;

  /// Error text for the input field
  String? _error;

  //endregion

  //region Functions

  String? get error => _error;

  T? get value;

  set error(String? value) {
    _error = value;
    notifyListeners();
  }

  void reset();

  @mustCallSuper
  void onChanged(T? value) {
    onListen?.call(value);
    if (value != null) {
      _error = null;
      notifyListeners();
    }
  }

  @protected
  bool validate() {
    if (required && value == null) {
      _error = requiredMessage;
      notifyListeners();
      return false;
    }

    if (validators != null && value != null) {
      final errorBuffer = StringBuffer();

      for (final validator in validators!) {
        final error = validator(value);
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
      'helperText': helper,
      'requiredMessage': requiredMessage,
      'initialValue': initialValue,
      'value': value,
    };

    return const JsonEncoder.withIndent(' ').convert(map);
  }

  //endregion
}
