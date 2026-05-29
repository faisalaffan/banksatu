import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdaptiveDialog {
  AdaptiveDialog._();

  static Future<void> showAlert({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmLabel,
    required VoidCallback onConfirm,
    String? cancelLabel = 'Kembali',
    Color? confirmColor,
  }) async {
    if (Platform.isIOS) {
      return showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                content,
                style: GoogleFonts.inter(fontSize: 13),
              ),
            ),
            actions: <CupertinoDialogAction>[
              if (cancelLabel != null && cancelLabel.isNotEmpty)
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    cancelLabel,
                    style: GoogleFonts.inter(color: CupertinoColors.systemBlue),
                  ),
                ),
              CupertinoDialogAction(
                isDestructiveAction: confirmColor == Colors.red || confirmColor == const Color(0xFFBA1A1A),
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                child: Text(
                  confirmLabel,
                  style: GoogleFonts.inter(
                    color: confirmColor ?? CupertinoColors.activeBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
            content: Text(
              content,
              style: GoogleFonts.inter(fontSize: 14),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            actions: <Widget>[
              if (cancelLabel != null && cancelLabel.isNotEmpty)
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    cancelLabel,
                    style: GoogleFonts.inter(color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                child: Text(
                  confirmLabel,
                  style: GoogleFonts.inter(
                    color: confirmColor ?? Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
