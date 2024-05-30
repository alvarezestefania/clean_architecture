import 'package:flutter/material.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void showLoadingOverlay(BuildContext context) {
    if (_overlayEntry != null) {
      return; // Si ya hay un overlay visible, no hacer nada
    }

    OverlayState? overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    overlayState.insert(_overlayEntry!);
  }

  static void hideLoadingOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}