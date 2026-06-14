import 'package:banksatu_mobile/data/models/transaction_dto.dart';

abstract class TransactionRemoteDatasource {
  Future<List<TransactionDto>> getTransactions();
  Future<TransactionDto> getTransactionById(String id);
}

class TransactionRemoteDatasourceImpl implements TransactionRemoteDatasource {
  // TODO: inject ApiClient ketika API sudah live
  // final ApiClient _client;

  // const TransactionRemoteDatasourceImpl(this._client);

  @override
  Future<List<TransactionDto>> getTransactions() async {
    // TODO: ganti dengan _client.get('/transactions') saat API live
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockTransactions;
  }

  @override
  Future<TransactionDto> getTransactionById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockTransactions.firstWhere((t) => t.id == id);
  }
}

final _mockTransactions = [
  TransactionDto(
    id: 'tx_01',
    merchantName: 'Kopi Kenangan - Grand Indonesia',
    originalAcquirerString: 'EDC-BCA-10492-JKT',
    amount: -45000.00,
    category: 'Food & Beverage',
    timestamp: DateTime(2026, 6, 14, 10, 30),
    latitude: -6.1966,
    longitude: 106.8228,
    feeBreakdown: {'Harga Pokok': 45000.0, 'PPN (11%)': 4950.0, 'Merchant Fee (SNAP)': 0.0},
  ),
  TransactionDto(
    id: 'tx_02',
    merchantName: 'MRT Jakarta - Bundaran HI',
    originalAcquirerString: 'GATE-MRT-BHI-01',
    amount: -15000.00,
    category: 'Transportation',
    timestamp: DateTime(2026, 6, 14, 7, 30),
    latitude: -6.1950,
    longitude: 106.8225,
    feeBreakdown: {'Tarif Perjalanan': 15000.0, 'Asuransi Jasa Raharja': 500.0},
  ),
  TransactionDto(
    id: 'tx_03',
    merchantName: 'Gaji Mei - PT Antigravity Creative',
    originalAcquirerString: 'SKN-BI-FAST-INCOMING-REFS204',
    amount: 24500000.00,
    category: 'Salary',
    timestamp: DateTime(2026, 6, 13, 9, 0),
    latitude: -6.1751,
    longitude: 106.8272,
    feeBreakdown: {'Gaji Pokok': 24500000.0, 'Bonus Kinerja': 0.0, 'Biaya BI-FAST': 0.0},
  ),
  TransactionDto(
    id: 'tx_04',
    merchantName: 'Tokopedia Belanja',
    originalAcquirerString: 'PG-GOPAY-TOKOPEDIA-MCH994',
    amount: -350000.00,
    category: 'Shopping',
    timestamp: DateTime(2026, 6, 12, 14, 15),
    latitude: -6.2234,
    longitude: 106.8123,
    feeBreakdown: {'Subtotal': 348000.0, 'Biaya Jasa Aplikasi': 1000.0, 'Biaya Penanganan': 1000.0},
  ),
  TransactionDto(
    id: 'tx_05',
    merchantName: 'Listrik PLN Prabayar',
    originalAcquirerString: 'PLN-PREPAID-32948293849',
    amount: -102500.00,
    category: 'Bills',
    timestamp: DateTime(2026, 6, 11, 8, 0),
    latitude: -6.2088,
    longitude: 106.8456,
    feeBreakdown: {'Token Listrik': 100000.0, 'Admin Bank': 2500.0},
  ),
];
