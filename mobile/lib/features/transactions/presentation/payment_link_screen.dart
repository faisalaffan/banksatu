import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class PaymentLinkScreen extends StatefulWidget {
  const PaymentLinkScreen({Key? key}) : super(key: key);

  @override
  State<PaymentLinkScreen> createState() => _PaymentLinkScreenState();
}

class _PaymentLinkScreenState extends State<PaymentLinkScreen> {
  final _amountController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedExpiry = '24 Jam';
  bool _isSingleUse = true;
  String _generatedLink = '';

  void _generateLink() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount <= 0.0) return;

    setState(() {
      _generatedLink = 'https://link.banksatu.id/pay/tx_link_${(100000 + amount.toInt() % 99999).toString()}';
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _generatedLink));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tautan pembayaran berhasil disalin!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Buat Tautan Pembayaran',
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
              'Konfigurasi Link',
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
                    decoration: const InputDecoration(labelText: 'Nominal Tagihan (Rp)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _descController,
                    decoration: const InputDecoration(labelText: 'Deskripsi / Catatan Pembayaran', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Masa Berlaku:', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                      DropdownButton<String>(
                        value: _selectedExpiry,
                        items: ['1 Jam', '6 Jam', '24 Jam', '7 Hari']
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (val) => setState(() => _selectedExpiry = val!),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Pembayaran Sekali Pakai'),
                    subtitle: const Text('Tautan otomatis dinonaktifkan setelah berhasil dibayar sekali'),
                    value: _isSingleUse,
                    activeColor: AppTheme.shariaGreen,
                    onChanged: (val) => setState(() => _isSingleUse = val),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _generateLink,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Generate Payment Link'),
                    ),
                  ),
                ],
              ),
            ),
            if (_generatedLink.isNotEmpty) ...[
              const SizedBox(height: 28),
              Text(
                'Tautan Berhasil Dibuat',
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.shariaGreen.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.shariaGreen.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    SelectableText(
                      _generatedLink,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.shariaGreen,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _copyToClipboard,
                          icon: const Icon(Icons.copy, size: 16),
                          label: const Text('Salin Link'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.shariaGreen,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share, size: 16),
                          label: const Text('Bagikan'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.shariaGreen,
                            side: const BorderSide(color: AppTheme.shariaGreen),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
