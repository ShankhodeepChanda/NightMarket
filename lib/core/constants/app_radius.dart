/// Night Market border radius constants.
///
/// Provides consistent corner radius values across the app.
class AppRadius {
  AppRadius._(); // Private constructor to prevent instantiation

  /// Small radius: 8px
  /// Use for: chips, tags, small buttons
  static const double sm = 8.0;

  /// Medium radius: 12px (base unit)
  /// Use for: cards, input fields, dialogs
  static const double md = 12.0;

  /// Large radius: 16px
  /// Use for: large cards, bottom sheets
  static const double lg = 16.0;

  /// Circular radius: 9999px (effectively circular)
  /// Use for: avatars, FAB, icon buttons
  static const double circular = 9999.0;
}
