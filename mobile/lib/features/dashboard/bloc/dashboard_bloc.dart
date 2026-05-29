import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulator/features/dashboard/models/transaction.dart';

// Events
abstract class DashboardEvent {}

class LoadDashboard extends DashboardEvent {}

class SearchTransactions extends DashboardEvent {
  final String query;
  SearchTransactions(this.query);
}

// States
abstract class DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final double balance;
  final List<Transaction> transactions;
  final List<Transaction> filteredTransactions;
  final String searchQuery;

  DashboardLoaded({
    required this.balance,
    required this.transactions,
    required this.filteredTransactions,
    required this.searchQuery,
  });

  DashboardLoaded copyWith({
    double? balance,
    List<Transaction>? transactions,
    List<Transaction>? filteredTransactions,
    String? searchQuery,
  }) {
    return DashboardLoaded(
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
      filteredTransactions: filteredTransactions ?? this.filteredTransactions,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

// Bloc
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<SearchTransactions>(_onSearchTransactions);
  }

  void _onLoadDashboard(LoadDashboard event, Emitter<DashboardState> emit) {
    final mockTransactions = [
      Transaction(
        id: 'tx_01',
        merchantName: 'Kopi Kenangan - Grand Indonesia',
        originalAcquirerString: 'EDC-BCA-10492-JKT',
        amount: -45000.00,
        category: 'Food & Beverage',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        latitude: -6.1966,
        longitude: 106.8228,
        feeBreakdown: {
          'Harga Pokok': 45000.00,
          'PPN (11%)': 4950.00,
          'Merchant Fee (SNAP)': 0.00,
        },
      ),
      Transaction(
        id: 'tx_02',
        merchantName: 'MRT Jakarta - Bundaran HI',
        originalAcquirerString: 'GATE-MRT-BHI-01',
        amount: -15000.00,
        category: 'Transportation',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        latitude: -6.1950,
        longitude: 106.8225,
        feeBreakdown: {
          'Tarif Perjalanan': 15000.00,
          'Asuransi Jasa Raharja': 500.00,
        },
      ),
      Transaction(
        id: 'tx_03',
        merchantName: 'Gaji Mei - PT Antigravity Creative',
        originalAcquirerString: 'SKN-BI-FAST-INCOMING-REFS204',
        amount: 24500000.00,
        category: 'Salary',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        latitude: -6.1751,
        longitude: 106.8272,
        feeBreakdown: {
          'Gaji Pokok': 24500000.00,
          'Bonus Kinerja': 0.00,
          'Biaya BI-FAST': 0.00,
        },
      ),
      Transaction(
        id: 'tx_04',
        merchantName: 'Tokopedia Belanja',
        originalAcquirerString: 'PG-GOPAY-TOKOPEDIA-MCH994',
        amount: -350000.00,
        category: 'Shopping',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        latitude: -6.2234,
        longitude: 106.8123,
        feeBreakdown: {
          'Subtotal': 348000.00,
          'Biaya Jasa Aplikasi': 1000.00,
          'Biaya Penanganan': 1000.00,
        },
      ),
      Transaction(
        id: 'tx_05',
        merchantName: 'Listrik PLN Prabayar',
        originalAcquirerString: 'PLN-PREPAID-32948293849',
        amount: -102500.00,
        category: 'Bills',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        latitude: -6.2088,
        longitude: 106.8456,
        feeBreakdown: {
          'Token Listrik': 100000.00,
          'Admin Bank': 2500.00,
        },
      ),
    ];

    emit(DashboardLoaded(
      balance: 24137500.00, // starting balance after transactions
      transactions: mockTransactions,
      filteredTransactions: mockTransactions,
      searchQuery: '',
    ));
  }

  void _onSearchTransactions(SearchTransactions event, Emitter<DashboardState> emit) {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;
      final query = event.query.toLowerCase();

      if (query.isEmpty) {
        emit(currentState.copyWith(
          filteredTransactions: currentState.transactions,
          searchQuery: '',
        ));
      } else {
        final filtered = currentState.transactions.where((tx) {
          final nameMatch = tx.merchantName.toLowerCase().contains(query);
          final catMatch = tx.category.toLowerCase().contains(query);
          final acqMatch = tx.originalAcquirerString.toLowerCase().contains(query);
          return nameMatch || catMatch || acqMatch;
        }).toList();

        emit(currentState.copyWith(
          filteredTransactions: filtered,
          searchQuery: event.query,
        ));
      }
    }
  }
}
