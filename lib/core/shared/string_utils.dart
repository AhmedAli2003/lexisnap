class StringUtils {
  const StringUtils();

  static String capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  static String removeSpecialCharacters(String input) {
  // Define a regular expression that matches anything other than English letters and numbers
  final RegExp regExp = RegExp(r'[^a-zA-Z0-9\s]');
  // Replace all matches with an empty string
  return input.replaceAll(regExp, '');
}
}
