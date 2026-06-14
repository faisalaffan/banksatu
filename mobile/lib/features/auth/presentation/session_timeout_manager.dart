import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/router/app_router.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class SessionTimeoutManager extends StatefulWidget {
  final Widget child;

  const SessionTimeoutManager({Key? key, required this.child}) : super(key: key);

  @override
  State<SessionTimeoutManager> createState() => _SessionTimeoutManagerState();
}

class _SessionTimeoutManagerState extends State<SessionTimeoutManager> {
  Timer? _inactivityTimer;
  Timer? _dialogCountdownTimer;
  bool _isDialogShowing = false;
  int _countdownSeconds = 15;
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _startInactivityTimer();
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    _dialogCountdownTimer?.cancel();
    super.dispose();
  }

  void _resetTimer() {
    if (_isDialogShowing) return;
    _startInactivityTimer();
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(const Duration(seconds: 60), _onInactivityTimeout);
  }

  String _getCurrentPath() {
    try {
      return appRouter.routeInformationProvider.value.uri.path;
    } catch (_) {
      try {
        return appRouter.routerDelegate.currentConfiguration.uri.path;
      } catch (_) {
        return '/';
      }
    }
  }

  bool _shouldManageSession(String path) {
    if (path == '/onboarding' ||
        path == '/login' ||
        path == '/oauth/authorize' ||
        path.startsWith('/kyc')) {
      return false;
    }
    return true;
  }

  Future<void> _onInactivityTimeout() async {
    final currentPath = _getCurrentPath();
    if (!_shouldManageSession(currentPath)) {
      _startInactivityTimer();
      return;
    }

    final token = await _storage.read(key: 'bank_satu_auth_token');
    if (token == null) {
      _startInactivityTimer();
      return;
    }

    _showTimeoutConfirmationDialog(currentPath);
  }

  void _showTimeoutConfirmationDialog(String currentPath) {
    if (_isDialogShowing) return;

    setState(() {
      _isDialogShowing = true;
      _countdownSeconds = 15;
    });

    _dialogCountdownTimer?.cancel();
    _dialogCountdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_countdownSeconds > 0) {
          _countdownSeconds--;
        } else {
          timer.cancel();
          _handleLogout();
        }
      });
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return WillPopScope(
          onWillPop: () async => false,
          child: StatefulBuilder(
            builder: (context, setDialogState) {
              Timer.periodic(const Duration(milliseconds: 200), (t) {
                if (!dialogContext.mounted) {
                  t.cancel();
                  return;
                }
                setDialogState(() {});
              });

              return Platform.isIOS
                  ? CupertinoAlertDialog(
                      title: Text(
                        'Sesi Hampir Berakhir',
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            'Anda tidak aktif selama 1 menit. Demi keamanan, Anda akan keluar otomatis dalam $_countdownSeconds detik.',
                            style: GoogleFonts.inter(fontSize: 13),
                          ),
                        ],
                      ),
                      actions: [
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: const Text('Keluar'),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            _handleLogout();
                          },
                        ),
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const Text('Lanjutkan'),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            _handleExtendSession(currentPath);
                          },
                        ),
                      ],
                    )
                  : AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded, color: AppTheme.errorRed),
                          const SizedBox(width: 8),
                          Text(
                            'Sesi Hampir Berakhir',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppTheme.textDark,
                            ),
                          ),
                        ],
                      ),
                      content: Text(
                        'Anda tidak aktif selama 1 menit. Demi keamanan, sesi Anda akan keluar otomatis dalam $_countdownSeconds detik.',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppTheme.textLightGray,
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'Keluar',
                            style: GoogleFonts.inter(
                              color: AppTheme.errorRed,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            _handleLogout();
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Lanjutkan',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            _handleExtendSession(currentPath);
                          },
                        ),
                      ],
                    );
            },
          ),
        );
      },
    ).then((_) {
      if (mounted) {
        setState(() {
          _isDialogShowing = false;
        });
      }
    });
  }

  Future<void> _handleLogout() async {
    _dialogCountdownTimer?.cancel();
    await _storage.delete(key: 'bank_satu_auth_token');
    if (mounted) {
      setState(() {
        _isDialogShowing = false;
      });
      appRouter.go('/onboarding');
    }
  }

  void _handleExtendSession(String currentPath) {
    _dialogCountdownTimer?.cancel();
    if (mounted) {
      setState(() {
        _isDialogShowing = false;
      });
      appRouter.go('/login?from=$currentPath');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _resetTimer(),
      onPointerMove: (_) => _resetTimer(),
      child: widget.child,
    );
  }
}
