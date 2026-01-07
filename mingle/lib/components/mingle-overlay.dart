import 'package:flutter/material.dart';

class LoadingOverlay {
  static final LoadingOverlay _instance = LoadingOverlay._internal();

  factory LoadingOverlay() => _instance;

  LoadingOverlay._internal();

  OverlayEntry? _overlayEntry;

  void show(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder:
          (_) => Material(
            color: Colors.black.withAlpha(150),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: size.width * .8,
                  maxHeight: size.width * .8,
                  minWidth: size.width * .5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10),
                      Text(
                        "Loading",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );

    // Insert the overlay into the OverlayState
    Overlay.of(context).insert(_overlayEntry!);
  }

  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}