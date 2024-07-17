double convertSpeedToRate(double speed) {
  if (speed == 0.5) return 0.25;
  if (speed == 0.75) return 0.375;
  if (speed == 1.0) return 0.5;
  if (speed == 1.25) return 0.625;
  if (speed == 1.5) return 0.75;
  if (speed == 1.75) return 0.875;
  if (speed == 2.0) return 1.0;
  return 0.5;
}

double convertRateToSpeed(double rate) {
  if (rate == 0.25) return 0.5;
  if (rate == 0.375) return 0.75;
  if (rate == 0.5) return 1.0;
  if (rate == 0.625) return 1.25;
  if (rate == 0.75) return 1.5;
  if (rate == 0.875) return 1.75;
  if (rate == 1.0) return 2.0;
  return 1.0;
}

bool isEnglish(String text) {
  final englishPattern = RegExp(r"""^[a-zA-Z0-9\s,.\'\"\!\?\-]+$""");
  return englishPattern.hasMatch(text);
}
