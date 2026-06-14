import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;

/// Adaptive page scaffold — Cupertino for iOS, Material for Android.
class AdaptiveScaffold extends StatelessWidget {
  final Widget child;
  final Widget? navigationBar;
  final Color backgroundColor;

  const AdaptiveScaffold({
    super.key,
    required this.child,
    this.navigationBar,
    this.backgroundColor = const Color(0xFFF9F9FF),
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: backgroundColor,
        navigationBar: navigationBar is CupertinoNavigationBar
            ? navigationBar as CupertinoNavigationBar?
            : null,
        child: child,
      );
    }
    return SafeArea(child: child);
  }
}

/// Adaptive loading indicator — Cupertino spinner for iOS, Material for Android.
class AdaptiveLoadingIndicator extends StatelessWidget {
  final Color color;
  final double radius;

  const AdaptiveLoadingIndicator({
    super.key,
    this.color = const Color(0xFF0052CC),
    this.radius = 14,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(color: color, radius: radius);
    }
    return CircularProgressIndicator(color: color);
  }
}

/// Adaptive button — CupertinoButton for iOS, ElevatedButton for Android.
class AdaptiveButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;

  const AdaptiveButton({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor = const Color(0xFF0052CC),
    this.textColor = Colors.white,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
        onPressed: onPressed,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Text(
          label,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(label),
    );
  }
}

/// Adaptive text field — CupertinoTextField for iOS, TextField for Android.
class AdaptiveTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const AdaptiveTextField({
    super.key,
    this.controller,
    this.placeholder,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoTextField(
        controller: controller,
        placeholder: placeholder,
        obscureText: obscureText,
        onChanged: onChanged,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE3E8F9)),
        ),
      );
    }
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: placeholder,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE3E8F9)),
        ),
      ),
    );
  }
}

/// Adaptive error view — consistent error display.
class AdaptiveErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const AdaptiveErrorView({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Platform.isIOS ? CupertinoIcons.exclamationmark_circle : Icons.error_outline,
            size: 48,
            color: const Color(0xFFBA1A1A),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(color: Color(0xFF737685)),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            AdaptiveButton(label: 'Coba Lagi', onPressed: onRetry),
          ],
        ],
      ),
    );
  }
}
