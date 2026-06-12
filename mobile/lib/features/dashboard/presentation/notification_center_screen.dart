import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class AppNotification {
  final String title;
  final String content;
  final String time;
  final String type; // 'transaction', 'security', 'promo'
  final bool isUnread;

  AppNotification({
    required this.title,
    required this.content,
    required this.time,
    required this.type,
    required this.isUnread,
  });
}

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({Key? key}) : super(key: key);

  @override
  State<NotificationCenterScreen> createState() => _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
  final List<AppNotification> _notifications = [
    AppNotification(
      title: 'Transfer Keluar Berhasil',
      content: 'Anda telah berhasil mengirimkan Rp 1.500.000 ke Adinda Larasati.',
      time: '10 Menit Lalu',
      type: 'transaction',
      isUnread: true,
    ),
    AppNotification(
      title: 'Peringatan Login Baru',
      content: 'Akun Anda berhasil masuk dari peranti macOS di Bandung.',
      time: '1 Jam Lalu',
      type: 'security',
      isUnread: true,
    ),
    AppNotification(
      title: 'Promo Cashback Emas 5%',
      content: 'Beli emas digital hari ini dan nikmati cashback saldo investasi s.d Rp 50.000.',
      time: 'Kemarin',
      type: 'promo',
      isUnread: false,
    ),
  ];

  void _markAllAsRead() {
    setState(() {
      for (var i = 0; i < _notifications.length; i++) {
        _notifications[i] = AppNotification(
          title: _notifications[i].title,
          content: _notifications[i].content,
          time: _notifications[i].time,
          type: _notifications[i].type,
          isUnread: false,
        );
      }
    });
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'transaction':
        return Platform.isIOS ? CupertinoIcons.arrow_right_arrow_left : Icons.swap_horiz_rounded;
      case 'security':
        return Platform.isIOS ? CupertinoIcons.shield_fill : Icons.shield_rounded;
      case 'promo':
        return Platform.isIOS ? CupertinoIcons.tag_fill : Icons.local_offer_rounded;
      default:
        return Platform.isIOS ? CupertinoIcons.bell_fill : Icons.notifications_rounded;
    }
  }

  Color _getColor(String type) {
    switch (type) {
      case 'transaction':
        return AppTheme.primaryBlue;
      case 'security':
        return AppTheme.errorRed;
      case 'promo':
        return const Color(0xFFC78314);
      default:
        return AppTheme.textLightGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Pusat Notifikasi'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: AppTheme.textDark,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all_rounded, color: AppTheme.primaryBlue),
            tooltip: 'Tandai Semua Dibaca',
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: SafeArea(
        child: _notifications.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Platform.isIOS ? CupertinoIcons.bell_slash : Icons.notifications_off_rounded,
                      size: 64,
                      color: AppTheme.textDisabled,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Tidak ada notifikasi baru',
                      style: GoogleFonts.inter(
                        color: AppTheme.textLightGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notif = _notifications[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: notif.isUnread ? AppTheme.primaryBlue.withOpacity(0.02) : AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: notif.isUnread ? AppTheme.primaryBlue.withOpacity(0.12) : const Color(0xFFE8EEFF),
                      ),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _getColor(notif.type).withOpacity(0.06),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(_getIcon(notif.type), color: _getColor(notif.type), size: 18),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    notif.title,
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textDark,
                                    ),
                                  ),
                                  Text(
                                    notif.time,
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      color: AppTheme.textLightGray,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                notif.content,
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: AppTheme.textLightGray,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
