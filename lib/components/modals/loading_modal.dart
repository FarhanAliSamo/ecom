import 'package:ecom/core/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingDialog {
  static OverlayEntry? _overlayEntry;
  static bool _isLoading = false;
  static const Color lightTransparent = Color(0x4D000000);

  /// Show a loading overlay
  static void showLoadingDialog(BuildContext context) {
    if (_isLoading) {
      debugPrint('Loading dialog is already shown.');
      return;
    }

    _isLoading = true;

    final overlay = Overlay.of(context);

    // ignore: unnecessary_null_comparison
    if (overlay != null) {
      _overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            Container(
              color: lightTransparent,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      );

      overlay.insert(_overlayEntry!);
    }
  }

  /// Hide the loading overlay
  static void hideLoadingDialog() {
    if (_isLoading && _overlayEntry != null) {
      try {
        _overlayEntry!.remove(); // Removes the overlay
        _overlayEntry = null;
        _isLoading = false; // Reset the loader status
      } catch (e) {
        debugPrint('Error hiding loading overlay: $e');
      }
    } else {
      _isLoading = false; // Reset the loader status even if no overlay exists
    }
  }
}
