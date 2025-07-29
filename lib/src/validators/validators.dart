// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

const String _emailRegex = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';

class Validators {
  static String? email(String? value) {
    const error = 'Please enter valid email';
    if (value == null) return error;
    final regExp = RegExp(_emailRegex);

    if (regExp.hasMatch(value)) return null;

    return error;
  }

  static String? length(String? value, {int minLength = 8}) {
    return (value?.length ?? 0) >= minLength ? null : 'Should be of minimum $minLength characters';
  }

  static String? min(String? value, {int minValue = 1}) {
    final resolvedValue = int.tryParse(value ?? '0') ?? 0;
    return resolvedValue >= minValue ? null : 'Value should be at least $minValue';
  }

  static String? max(String? value, {int maxValue = 1}) {
    final resolvedValue = int.tryParse(value ?? '0') ?? 0;
    return resolvedValue <= maxValue ? null : 'Value can be at max $maxValue';
  }
}
