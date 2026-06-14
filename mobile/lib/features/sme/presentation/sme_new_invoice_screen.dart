import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class InvoiceItem {
  String name;
  int quantity;
  double price;

  InvoiceItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class SMENewInvoiceScreen extends StatefulWidget {
  const SMENewInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<SMENewInvoiceScreen> createState() => _SMENewInvoiceScreenState();
}

class _SMENewInvoiceScreenState extends State<SMENewInvoiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameController = TextEditingController(
    text: 'PT Sinergi Semesta',
  );
  final _clientEmailController = TextEditingController(
    text: 'finance@sinergi.co.id',
  );
  final _clientAddressController = TextEditingController(
    text: 'Menara Mandiri Lt. 18, Jakarta',
  );

  DateTime _dueDate = DateTime.now().add(const Duration(days: 14));
  bool _isSending = false;

  final List<InvoiceItem> _items = [
    InvoiceItem(
      name: 'Premium Design System Consulting',
      quantity: 1,
      price: 15000000,
    ),
    InvoiceItem(
      name: 'Flutter Integration Phase 1',
      quantity: 1,
      price: 20000000,
    ),
  ];

  final _currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    // Safely trigger date formatting initialization for hot reloads or first-time render
    initializeDateFormatting('id_ID', null).then((_) {
      if (mounted) {
        setState(() {}); // Re-render once initialized
      }
    });
  }

  String _formatDueDate(DateTime date) {
    try {
      return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
    } catch (_) {
      // Safe fallback to English date formatting if locale is not initialized yet
      return DateFormat('dd MMMM yyyy').format(date);
    }
  }

  @override
  void dispose() {
    _clientNameController.dispose();
    _clientEmailController.dispose();
    _clientAddressController.dispose();
    super.dispose();
  }

  double get _subtotal {
    return _items.fold(0, (sum, item) => sum + (item.quantity * item.price));
  }

  double get _tax {
    return _subtotal * 0.11; // 11% PPN
  }

  double get _total {
    return _subtotal + _tax;
  }

  void _addNewItem() {
    setState(() {
      _items.add(InvoiceItem(name: 'Item Baru', quantity: 1, price: 1000000));
    });
  }

  void _removeItem(int index) {
    if (_items.length > 1) {
      setState(() {
        _items.removeAt(index);
      });
    } else {
      _showWarning('Minimal harus ada 1 item dalam invoice.');
    }
  }

  void _showWarning(String msg) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Perhatian'),
          content: Text(msg),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: AppTheme.errorRed),
      );
    }
  }

  Future<void> _selectDueDate() async {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
          height: 250,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _dueDate,
              minimumDate: DateTime.now().subtract(const Duration(days: 1)),
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  _dueDate = newDate;
                });
              },
            ),
          ),
        ),
      );
    } else {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dueDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );
      if (picked != null && picked != _dueDate) {
        setState(() {
          _dueDate = picked;
        });
      }
    }
  }

  void _submitInvoice() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        setState(() {
          _isSending = false;
        });

        // Show elegant success dialog
        if (Platform.isIOS) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Invoice Terkirim'),
              content: Text(
                'Tagihan sebesar ${_currencyFormatter.format(_total)} berhasil diterbitkan dan dikirim ke ${_clientEmailController.text}.',
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Selesai'),
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Back to dashboard
                  },
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Invoice Terkirim'),
              content: Text(
                'Tagihan sebesar ${_currencyFormatter.format(_total)} berhasil diterbitkan dan dikirim ke ${_clientEmailController.text}.',
              ),
              actions: [
                TextButton(
                  child: const Text('Selesai'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Buat Invoice Baru'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: AppTheme.textDark,
          ),
        ),
      ),
      body: SafeArea(
        child: _isSending
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Platform.isIOS
                        ? const CupertinoActivityIndicator(
                            radius: 18,
                            color: AppTheme.primaryBlue,
                          )
                        : const CircularProgressIndicator(
                            color: AppTheme.primaryBlue,
                          ),
                    const SizedBox(height: 16),
                    Text(
                      'Menerbitkan Invoice Digital...',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Menyinkronkan rules PPN & BI-FAST Hub...',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppTheme.textLightGray,
                      ),
                    ),
                  ],
                ),
              )
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Client Information Section Card
                      Text(
                        'INFORMASI KLIEN',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textLightGray,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFE8EEFF),
                            width: 1,
                          ),
                          boxShadow: AppTheme.premiumShadow,
                        ),
                        child: Column(
                          children: [
                            _buildTextField(
                              label: 'Nama Klien / Perusahaan',
                              controller: _clientNameController,
                              placeholder: 'Contoh: PT Angin Ribut',
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Nama klien harus diisi'
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              label: 'Email Klien',
                              controller: _clientEmailController,
                              placeholder: 'finance@perusahaan.com',
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) =>
                                  val == null || !val.contains('@')
                                  ? 'Email tidak valid'
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              label: 'Alamat Tagihan',
                              controller: _clientAddressController,
                              placeholder: 'Gedung, Jalan, Kota',
                              maxLines: 2,
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Alamat harus diisi'
                                  : null,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Due Date Picker Card
                      Text(
                        'JATUH TEMPO & ATURAN',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textLightGray,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _selectDueDate,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceCard,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFE8EEFF),
                              width: 1,
                            ),
                            boxShadow: AppTheme.premiumShadow,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.calendar,
                                    color: AppTheme.primaryBlue,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Batas Pembayaran',
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          color: AppTheme.textLightGray,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        _formatDueDate(_dueDate),
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.textDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Platform.isIOS
                                    ? CupertinoIcons.chevron_down
                                    : Icons.arrow_drop_down,
                                color: AppTheme.textLightGray,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Line Items Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ITEM INVOICE',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textLightGray,
                              letterSpacing: 1.2,
                            ),
                          ),
                          GestureDetector(
                            onTap: _addNewItem,
                            child: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.add_circled_solid,
                                  color: AppTheme.primaryBlue,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Tambah Item',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Dynamic Items List
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceCard,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFE8EEFF),
                                width: 1,
                              ),
                              boxShadow: AppTheme.premiumShadow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: _buildItemInlineField(
                                        hint: 'Nama Item / Layanan',
                                        initialValue: item.name,
                                        onChanged: (val) => item.name = val,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => _removeItem(index),
                                      child: const Icon(
                                        CupertinoIcons.trash,
                                        color: AppTheme.errorRed,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      child: _buildItemInlineField(
                                        hint: 'Qty',
                                        initialValue: item.quantity.toString(),
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) {
                                          setState(() {
                                            item.quantity =
                                                int.tryParse(val) ?? 1;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildItemInlineField(
                                        hint: 'Harga Satuan (Rp)',
                                        initialValue: item.price
                                            .toStringAsFixed(0),
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) {
                                          setState(() {
                                            item.price =
                                                double.tryParse(val) ?? 0.0;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Subtotal',
                                          style: GoogleFonts.inter(
                                            fontSize: 9,
                                            color: AppTheme.textLightGray,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          _currencyFormatter.format(
                                            item.quantity * item.price,
                                          ),
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.textDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // Totals Summary Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBlue.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppTheme.primaryBlue.withOpacity(0.12),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildSummaryRow(
                              'Subtotal',
                              _currencyFormatter.format(_subtotal),
                              isBold: false,
                            ),
                            const SizedBox(height: 10),
                            _buildSummaryRow(
                              'PPN (11%)',
                              _currencyFormatter.format(_tax),
                              isBold: false,
                            ),
                            const SizedBox(height: 12),
                            const Divider(color: Color(0xFFC4D2FF), height: 1),
                            const SizedBox(height: 12),
                            _buildSummaryRow(
                              'TOTAL TAGIHAN',
                              _currencyFormatter.format(_total),
                              isBold: true,
                              color: AppTheme.primaryBlue,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Premium Action Button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          onPressed: _submitInvoice,
                          child: Text(
                            'Kirim & Terbitkan Invoice',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppTheme.textLightGray,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: GoogleFonts.inter(
              color: AppTheme.textDisabled,
              fontSize: 13,
            ),
            fillColor: AppTheme.background.withOpacity(0.4),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemInlineField({
    required String hint,
    required String initialValue,
    TextInputType keyboardType = TextInputType.text,
    required ValueChanged<String> onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppTheme.textDark,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          color: AppTheme.textDisabled,
          fontSize: 12,
        ),
        fillColor: AppTheme.background.withOpacity(0.5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE8EEFF), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    required bool isBold,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isBold ? 13 : 12,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: color ?? AppTheme.textLightGray,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: isBold ? 16 : 13,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w700,
            color: color ?? AppTheme.textDark,
          ),
        ),
      ],
    );
  }
}
