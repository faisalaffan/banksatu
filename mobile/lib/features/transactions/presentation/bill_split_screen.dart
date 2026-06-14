import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class BillSplitScreen extends StatefulWidget {
  const BillSplitScreen({Key? key}) : super(key: key);

  @override
  State<BillSplitScreen> createState() => _BillSplitScreenState();
}

class _BillSplitScreenState extends State<BillSplitScreen> {
  final double _totalBill = 450000.0;
  bool _splitEqually = true;

  // Active participants list (You is always index 0 and cannot be deleted)
  final List<Map<String, String>> _participants = [
    {'name': 'You', 'role': 'Owner', 'info': 'Tabungan Utama'},
  ];

  final List<Map<String, String>> _availableContacts = [
    {'name': 'Budi Pratama', 'role': 'Friend', 'info': '0812-3456-7890', 'initials': 'BP'},
    {'name': 'Siti Aminah', 'role': 'Friend', 'info': 'BankSatu Account', 'initials': 'SA'},
    {'name': 'Agus Tri', 'role': 'Friend', 'info': '0899-8877-6655', 'initials': 'AT'},
    {'name': 'Dewi Sari', 'role': 'Friend', 'info': 'BankSatu Account', 'initials': 'DS'},
  ];

  @override
  void initState() {
    super.initState();
    // Default add first two friends to the split list
    _participants.add(_availableContacts[0]);
    _participants.add(_availableContacts[1]);
  }

  void _toggleContact(Map<String, String> contact) {
    setState(() {
      if (_participants.contains(contact)) {
        if (_participants.length > 1) {
          _participants.remove(contact);
        }
      } else {
        _participants.add(contact);
      }
    });
  }

  double get _amountPerPerson => _totalBill / _participants.length;

  double get _totalToRequest => _amountPerPerson * (_participants.length - 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: AppTheme.textDark,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Split Bill',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textDark,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Bill Summary Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: AppTheme.premiumShadow,
                      border: Border.all(color: const Color(0xFFE8EEFF)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFF1F1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.restaurant,
                            color: AppTheme.errorRed,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Dinner at Sederhana',
                          style: GoogleFonts.inter(
                            color: AppTheme.textDark,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rp 450.000',
                          style: GoogleFonts.inter(
                            color: AppTheme.primaryBlue,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '12 Oct 2023 • 19:30',
                          style: GoogleFonts.inter(
                            color: AppTheme.textLightGray,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Split Mode Toggles
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F3FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _splitEqually = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: _splitEqually ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Split Equally',
                                  style: GoogleFonts.inter(
                                    color: _splitEqually ? AppTheme.primaryBlue : AppTheme.textLightGray,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _splitEqually = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: !_splitEqually ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Custom Amount',
                                  style: GoogleFonts.inter(
                                    color: !_splitEqually ? AppTheme.primaryBlue : AppTheme.textLightGray,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Add Friends Section Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Friends',
                        style: GoogleFonts.inter(
                          color: AppTheme.textDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Scan QR',
                        style: GoogleFonts.inter(
                          color: AppTheme.primaryBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Friend Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Name, phone, or account number',
                      prefixIcon: Icon(
                        Platform.isIOS ? CupertinoIcons.search : Icons.search,
                        color: AppTheme.textLightGray,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Horizontal scroll list of contacts
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _availableContacts.length,
                      itemBuilder: (context, index) {
                        final contact = _availableContacts[index];
                        final isAdded = _participants.contains(contact);
                        return GestureDetector(
                          onTap: () => _toggleContact(contact),
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 54,
                                      height: 54,
                                      decoration: BoxDecoration(
                                        color: isAdded
                                            ? AppTheme.primaryBlue.withOpacity(0.08)
                                            : const Color(0xFFF1F3FF),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isAdded ? AppTheme.primaryBlue : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          contact['initials']!,
                                          style: GoogleFonts.inter(
                                            color: AppTheme.primaryBlue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (isAdded)
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: const BoxDecoration(
                                            color: AppTheme.shariaGreen,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  contact['name']!.split(' ')[0],
                                  style: GoogleFonts.inter(
                                    color: AppTheme.textDark,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Participants list title
                  Text(
                    'Split Participants (${_participants.length})',
                    style: GoogleFonts.inter(
                      color: AppTheme.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // List of participants
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _participants.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final item = _participants[index];
                      final isOwner = item['name'] == 'You';
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE8EEFF)),
                          boxShadow: AppTheme.premiumShadow,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: isOwner
                                        ? AppTheme.primaryBlue
                                        : AppTheme.primaryBlue.withOpacity(0.08),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      isOwner ? 'Y' : item['name']!.split(' ')[0][0],
                                      style: TextStyle(
                                        color: isOwner ? Colors.white : AppTheme.primaryBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name']!,
                                      style: GoogleFonts.inter(
                                        color: AppTheme.textDark,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      isOwner ? 'Owner' : item['info']!,
                                      style: GoogleFonts.inter(
                                        color: AppTheme.textLightGray,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Rp ${_amountPerPerson.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                  style: GoogleFonts.inter(
                                    color: AppTheme.textDark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                if (!isOwner) ...[
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => _toggleContact(item),
                                    child: const Icon(
                                      Icons.close,
                                      color: AppTheme.textLightGray,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),

          // Bottom Sticky Action request panel
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(top: BorderSide(color: Color(0xFFF1F3FF))),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  offset: const Offset(0, -4),
                  blurRadius: 16,
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total to request',
                        style: GoogleFonts.inter(
                          color: AppTheme.textLightGray,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Rp ${_totalToRequest.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                            style: GoogleFonts.inter(
                              color: AppTheme.primaryBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            '(excluding you)',
                            style: GoogleFonts.inter(
                              color: AppTheme.textLightGray,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Simulate sending request and go back to home
                        showDialog(
                          context: context,
                          builder: (context) => Platform.isIOS
                              ? CupertinoAlertDialog(
                                  title: const Text('Permintaan Terkirim'),
                                  content: const Text(
                                      'Notifikasi penagihan transfer telah dikirimkan ke teman Anda.'),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        GoRouter.of(context).go('/');
                                      },
                                    ),
                                  ],
                                )
                              : AlertDialog(
                                  title: const Text('Permintaan Terkirim'),
                                  content: const Text(
                                      'Notifikasi penagihan transfer telah dikirimkan ke teman Anda.'),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        GoRouter.of(context).go('/');
                                      },
                                    ),
                                  ],
                                ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      icon: const Icon(Icons.send, size: 16),
                      label: Text(
                        'Request Funds',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
