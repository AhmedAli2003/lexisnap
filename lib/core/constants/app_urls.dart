class AppUrls {
  const AppUrls._();

  static const String baseUrl = 'http://10.0.0.13:3000/api/v1';
  static const String authUrl = '$baseUrl/auth';
  static const String wordsUrl = '$baseUrl/words';
  static const String tagsUrl = '$baseUrl/tags';
  static const String statementsUrl = '$baseUrl/statements';

  static const String authorization = 'authorization';
}
