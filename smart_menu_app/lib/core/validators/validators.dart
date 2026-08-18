class Validators {
  const Validators._();

  static String? requiredText(String? value, {required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName不能为空';
    }

    return null;
  }
}
