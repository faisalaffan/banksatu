import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class ContactHistoryScreen extends StatefulWidget {
  const ContactHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ContactHistoryScreen> createState() => _ContactHistoryScreenState();
}

class _ContactHistoryScreenState extends State<ContactHistoryScreen> {
  final List<Map<String, dynamic>> _ledger = [
    {'sender': 'Adinda Larasati', 'amount': 150000.0, 'isIncoming': true, 'time': '12 Jun, 09:15', 'note': 'Patungan Bakso'},
    {'sender': 'You', 'amount': 300000.0, 'isIncoming': false, 'time': '10 Jun, 14:20', 'note': 'Beli Tiket Nonton'},
    {'sender': 'Adinda Larasati', 'amount': 50000.0, 'isIncoming': true, 'time': '05 Jun, 18:00', 'note': 'Parkir Mal'},
  ];

  final _amountController = TextEditingController();

  void _sendQuickTransfer() {
    final val = double.tryParse(_amountController.text) ?? 0.0;
    if (val <= 0.0) return;

    setState(() {
      _ledger.insert(0, {
        'sender': 'You',
        'amount': val,
        'isIncoming': false,
        'time': 'Baru saja',
        'note': 'Transfer Instan',
      });
      _amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: AppTheme.primaryBlue,
              child: Text('AL', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adinda Larasati',
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textDark),
                ),
                Text(
                  '0856-9876-5432',
                  style: GoogleFonts.inter(fontSize: 9, color: AppTheme.textLightGray),
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back, color: AppTheme.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(24),
              physics: const BouncingScrollPhysics(),
              itemCount: _ledger.length,
              itemBuilder: (context, index) {
                final tx = _ledger[index];
                return Align(
                  alignment: tx['isIncoming'] ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: tx['isIncoming'] ? Colors.white : AppTheme.primaryBlue.withOpacity(0.06),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: tx['isIncoming'] ? Radius.zero : const Radius.circular(16),
                        bottomRight: tx['isIncoming'] ? const Radius.circular(16) : Radius.zero,
                      ),
                      border: Border.all(color: tx['isIncoming'] ? const Color(0xFFE8EEFF) : AppTheme.primaryBlue.withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: tx['isIncoming'] ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${tx['isIncoming'] ? "+" : "-"}${tx['amount'].toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: tx['isIncoming'] ? AppTheme.shariaGreen : AppTheme.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(tx['note'], style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textDark, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(tx['time'], style: GoogleFonts.inter(fontSize: 8, color: AppTheme.textLightGray)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFF1F3FF))),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan nominal transfer cepat...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_rounded, color: AppTheme.primaryBlue),
                    onPressed: _sendQuickTransfer,
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
