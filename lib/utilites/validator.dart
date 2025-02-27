class Validator {
  static String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "pleae enter something";
    }
    return null;
  }
}
