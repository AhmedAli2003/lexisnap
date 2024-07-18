class StringUtils {
  const StringUtils._();

  // Regular expression to match allowed characters
  static final RegExp _allowedCharsRegExp = RegExp("[^a-zA-Z0-9,.' ]");

  static String capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  static String removeSpecialCharacters(String input) {
    // Replace all matches with an empty string
    return input.replaceAll(_allowedCharsRegExp, '');
  }
}
