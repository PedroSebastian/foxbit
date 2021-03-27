class AppMetrics {
  static const double _defaultSpacing = 15;

  static const double appBarHeight = 55;

  static double getDefaultSpacing() {
    return _defaultSpacing;
  }

  static double getDefaultSpacingWithMultiplier(double multiplier) {
    return _defaultSpacing * multiplier;
  }
}