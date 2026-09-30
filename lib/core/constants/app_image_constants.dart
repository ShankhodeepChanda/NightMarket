/// Night Market image aspect ratio and size constants.
///
/// Defines standard aspect ratios and size limits for images across the app.
class AppImageConstants {
  AppImageConstants._(); // Private constructor to prevent instantiation

  // Aspect Ratios
  /// Product images: 1:1 (square)
  static const double productAspectRatio = 1.0;

  /// Product images alternate: 4:3 (landscape)
  static const double productAspectRatioWide = 4.0 / 3.0;

  /// Event images: 16:9 (landscape)
  static const double eventAspectRatio = 16.0 / 9.0;

  /// Profile avatars: 1:1 (square/circular)
  static const double profileAspectRatio = 1.0;

  // Size Limits (in bytes)
  /// Maximum file size for product images: 5 MB
  static const int maxProductImageSize = 5 * 1024 * 1024;

  /// Maximum file size for event images: 5 MB
  static const int maxEventImageSize = 5 * 1024 * 1024;

  /// Maximum file size for profile avatars: 2 MB
  static const int maxProfileImageSize = 2 * 1024 * 1024;

  // Compression Targets
  /// Target quality for JPEG compression (0-100)
  static const int compressionQuality = 85;

  /// Maximum image dimension (width or height) in pixels before resize
  static const int maxImageDimension = 2048;
}
