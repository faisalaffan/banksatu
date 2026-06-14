import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class RequestMoneyScreen extends StatefulWidget {
  const RequestMoneyScreen({Key? key}) : super(key: key);

  @override
  State<RequestMoneyScreen> createState() => _RequestMoneyScreenState();
}

class _RequestMoneyScreenState extends State<RequestMoneyScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedContact = 'Budi Hartono';

  final List<Map<String, String>> _contacts = [
    {'name': 'Budi Hartono', 'phone': '0812-3456-7890', 'avatar': 'BH'},
    {'name': 'Adinda Larasati', 'phone': '0856-9876-5432', 'avatar': 'AL'},
    {'name': 'Agus Tri', 'phone': '0878-1122-3344', 'avatar': 'AT'},
  ];

  void _sendRequest() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount <= 0.0) return;

    showDialog(
      context: context,
      builder: (context) => Platform.isIOS
          ? CupertinoAlertDialog(
              title: const Text('Tagihan Terkirim'),
              content: Text('Tagihan sebesar Rp ${_amountController.text} berhasil dikirim ke $_selectedContact.'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          : AlertDialog(
              title: const Text('Tagihan Terkirim'),
              content: Text('Tagihan sebesar Rp ${_amountController.text} berhasil dikirim ke $_selectedContact.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Minta Uang (Request)',
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Kontak',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
            ),
            const SizedBox(height: 12),
            Container(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final c = _contacts[index];
                  final isSelected = _selectedContact == c['name'];
                  return GestureDetector(
                    onTap: () => setState(() => _selectedContact = c['name']!),
                    child: Container(
                      margin: const EdgeInsets.only(right: 14),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryBlue : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isSelected ? AppTheme.primaryBlue : const Color(0xFFE8EEFF)),
                        boxShadow: isSelected ? AppTheme.premiumShadow : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: isSelected ? Colors.white : AppTheme.primaryBlue,
                            child: Text(
                              c['avatar']!,
                              style: TextStyle(
                                color: isSelected ? AppTheme.primaryBlue : Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            c['name']!,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : AppTheme.textDark,
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
            Text(
              'Konfigurasi Permintaan',
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
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Nominal Permintaan (Rp)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(labelText: 'Pesan / Catatan (e.g. Patungan Makan Siang)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _sendRequest,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      ),
                      child: Text('Kirim Tagihan', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
