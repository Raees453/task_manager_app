class Validators {
  static String? validateNonEmptyString(String? value) {
    value = value?.trim();

    if (value == null || value.isEmpty) {
      return 'Please provide a value';
    }

    return null;
  }
}
