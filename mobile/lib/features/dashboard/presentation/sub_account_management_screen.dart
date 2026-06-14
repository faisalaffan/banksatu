import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class SubAccountManagementScreen extends StatefulWidget {
  const SubAccountManagementScreen({Key? key}) : super(key: key);

  @override
  State<SubAccountManagementScreen> createState() => _SubAccountManagementScreenState();
}

class _SubAccountManagementScreenState extends State<SubAccountManagementScreen> {
  final List<Map<String, dynamic>> _subAccounts = [
    {
      'name': 'Kantong Kasir (Toko Utama)',
      'acc': '882-990-281',
      'balance': 4850000.0,
      'limit': 10000000.0,
      'canTransfer': false,
      'canWithdraw': true,
    },
    {
      'name': 'Kantong Operasional (Kurir)',
      'acc': '882-990-394',
      'balance': 1200000.0,
      'limit': 3000000.0,
      'canTransfer': true,
      'canWithdraw': true,
    },
    {
      'name': 'Kantong Tabungan Darurat',
      'acc': '882-990-501',
      'balance': 15000000.0,
      'limit': 0.0, // unlimited
      'canTransfer': false,
      'canWithdraw': false,
    },
  ];

  void _createNewSubAccount() {
    final nameController = TextEditingController();
    final balanceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buat Sub-account Baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nama Sub-account')),
            const SizedBox(height: 12),
            TextField(controller: balanceController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Saldo Awal (Rp)')),
          ],
        ),
        actions: [
          TextButton(child: const Text('Batal'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('Buat'),
            onPressed: () {
              final name = nameController.text.trim();
              final bal = double.tryParse(balanceController.text) ?? 0.0;
              if (name.isNotEmpty) {
                setState(() {
                  _subAccounts.add({
                    'name': name,
                    'acc': '882-990-${(100 + _subAccounts.length * 15).toString()}',
                    'balance': bal,
                    'limit': 0.0,
                    'canTransfer': true,
                    'canWithdraw': true,
                  });
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _configurePermissions(int index) {
    final sa = _subAccounts[index];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    sa['name'],
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                  ),
                  Text(
                    'Nomor Rekening: ${sa['acc']}',
                    style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLightGray),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  SwitchListTile.adaptive(
                    title: const Text('Izin Transfer Keluar'),
                    subtitle: const Text('Mengizinkan pemindahan dana ke rekening lain'),
                    value: sa['canTransfer'],
                    activeColor: AppTheme.shariaGreen,
                    onChanged: (val) {
                      setState(() {
                        sa['canTransfer'] = val;
                      });
                      setModalState(() {});
                    },
                  ),
                  SwitchListTile.adaptive(
                    title: const Text('Izin Penarikan Tunai'),
                    subtitle: const Text('Mengizinkan penarikan uang melalui ATM/Teller'),
                    value: sa['canWithdraw'],
                    activeColor: AppTheme.shariaGreen,
                    onChanged: (val) {
                      setState(() {
                        sa['canWithdraw'] = val;
                      });
                      setModalState(() {});
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue, foregroundColor: Colors.white),
                      child: const Text('Simpan Konfigurasi'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Kelola Sub-account',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daftar Sub-account',
                  style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
                ),
                TextButton(
                  onPressed: _createNewSubAccount,
                  child: const Text('+ Buat Baru'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _subAccounts.length,
              itemBuilder: (context, index) {
                final sa = _subAccounts[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE8EEFF)),
                    boxShadow: AppTheme.premiumShadow,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue.withOpacity(0.06),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.wallet, color: AppTheme.primaryBlue, size: 20),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sa['name'],
                                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                                ),
                                Text(
                                  'Acc: ${sa['acc']}',
                                  style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLightGray),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Rp ${sa['balance'].toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w900, color: AppTheme.textDark),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Divider(height: 1, color: Color(0xFFF1F3FF)),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _buildPermissionBadge(sa['canTransfer'], 'Transfer'),
                              const SizedBox(width: 6),
                              _buildPermissionBadge(sa['canWithdraw'], 'Tarik'),
                            ],
                          ),
                          TextButton.icon(
                            onPressed: () => _configurePermissions(index),
                            icon: const Icon(Icons.settings, size: 14),
                            label: const Text('Atur Akses', style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionBadge(bool enabled, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: enabled ? AppTheme.shariaGreen.withOpacity(0.08) : AppTheme.errorRed.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: enabled ? AppTheme.shariaGreen : AppTheme.errorRed,
        ),
      ),
    );
  }
}
