import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class BulkTransferScreen extends StatefulWidget {
  const BulkTransferScreen({Key? key}) : super(key: key);

  @override
  State<BulkTransferScreen> createState() => _BulkTransferScreenState();
}

class _BulkTransferScreenState extends State<BulkTransferScreen> {
  final List<Map<String, dynamic>> _recipients = [
    {'name': 'Ahmad Fauzi', 'bank': 'BankSatu', 'acc': '10928374', 'amount': 150000.0, 'status': 'Pending'},
    {'name': 'Dewi Lestari', 'bank': 'BCA', 'acc': '883920192', 'amount': 500000.0, 'status': 'Pending'},
    {'name': 'Rian Hidayat', 'bank': 'Mandiri', 'acc': '1240009823', 'amount': 75000.0, 'status': 'Pending'},
  ];

  final _nameController = TextEditingController();
  final _accController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedBank = 'BankSatu';

  void _addRecipient() {
    final name = _nameController.text.trim();
    final acc = _accController.text.trim();
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (name.isEmpty || acc.isEmpty || amount <= 0.0) return;

    setState(() {
      _recipients.add({
        'name': name,
        'bank': _selectedBank,
        'acc': acc,
        'amount': amount,
        'status': 'Pending',
      });
      _nameController.clear();
      _accController.clear();
      _amountController.clear();
    });
  }

  void _removeRecipient(int index) {
    setState(() {
      _recipients.removeAt(index);
    });
  }

  void _executeBulkTransfer() {
    showDialog(
      context: context,
      builder: (context) => Platform.isIOS
          ? CupertinoAlertDialog(
              title: const Text('Konfirmasi Bulk Transfer'),
              content: Text('Anda akan mentransfer ke ${_recipients.length} penerima sekaligus.'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Batal'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('Kirim'),
                  onPressed: () {
                    Navigator.pop(context);
                    _simulateExecution();
                  },
                ),
              ],
            )
          : AlertDialog(
              title: const Text('Konfirmasi Bulk Transfer'),
              content: Text('Anda akan mentransfer ke ${_recipients.length} penerima sekaligus.'),
              actions: [
                TextButton(
                  child: const Text('Batal'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text('Kirim'),
                  onPressed: () {
                    Navigator.pop(context);
                    _simulateExecution();
                  },
                ),
              ],
            ),
    );
  }

  void _simulateExecution() {
    setState(() {
      for (var r in _recipients) {
        r['status'] = 'Processing';
      }
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          for (var r in _recipients) {
            r['status'] = 'Success';
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = _recipients.fold(0.0, (sum, r) => sum + r['amount']);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Bulk Transfer',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textDark),
        ),
        leading: IconButton(
          icon: Icon(Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back, color: AppTheme.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daftar Penerima',
                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _recipients.length,
                    itemBuilder: (context, index) {
                      final r = _recipients[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE8EEFF)),
                          boxShadow: AppTheme.premiumShadow,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlue.withOpacity(0.06),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.person, color: AppTheme.primaryBlue, size: 20),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    r['name'],
                                    style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                                  ),
                                  Text(
                                    '${r['bank']} • ${r['acc']}',
                                    style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLightGray),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rp ${r['amount'].toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: AppTheme.shariaGreen),
                                  ),
                                ],
                              ),
                            ),
                            _buildStatusWidget(r['status']),
                            if (r['status'] == 'Pending')
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: AppTheme.errorRed),
                                onPressed: () => _removeRecipient(index),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Tambah Penerima Baru',
                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE8EEFF)),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Nama Penerima', border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<String>(
                                value: _selectedBank,
                                items: ['BankSatu', 'BCA', 'Mandiri', 'BNI', 'BRI']
                                    .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                                    .toList(),
                                onChanged: (val) => setState(() => _selectedBank = val!),
                                decoration: const InputDecoration(labelText: 'Bank', border: OutlineInputBorder()),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: _accController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(labelText: 'Nomor Rekening', border: OutlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Nomor Nominal (Rp)', border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _addRecipient,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryBlue,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Tambah ke Daftar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFF1F3FF))),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Transfer:', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textLightGray)),
                      Text(
                        'Rp ${totalAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                        style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w900, color: AppTheme.primaryBlue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _recipients.isNotEmpty ? _executeBulkTransfer : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      ),
                      child: Text('Kirim Sekaligus', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
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

  Widget _buildStatusWidget(String status) {
    Color bg = Colors.grey.shade100;
    Color fg = Colors.grey.shade700;
    if (status == 'Processing') {
      bg = AppTheme.primaryBlue.withOpacity(0.08);
      fg = AppTheme.primaryBlue;
    } else if (status == 'Success') {
      bg = AppTheme.shariaGreen.withOpacity(0.08);
      fg = AppTheme.shariaGreen;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(status, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: fg)),
    );
  }
}
