import 'package:banksatu_mobile/core/error/failures.dart';
import 'package:banksatu_mobile/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:banksatu_mobile/data/models/transaction_dto.dart';

abstract class TransactionRepository {
  Future<(Failure?, List<TransactionDto>?)> getTransactions();
  Future<(Failure?, TransactionDto?)> getTransactionById(String id);
}

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDatasource _datasource;

  const TransactionRepositoryImpl(this._datasource);

  @override
  Future<(Failure?, List<TransactionDto>?)> getTransactions() async {
    try {
      final transactions = await _datasource.getTransactions();
      return (null, transactions);
    } catch (e) {
      return (
        const ServerFailure(message: 'Gagal memuat transaksi'),
        null,
      );
    }
  }

  @override
  Future<(Failure?, TransactionDto?)> getTransactionById(String id) async {
    try {
      final transaction = await _datasource.getTransactionById(id);
      return (null, transaction);
    } catch (e) {
      return (
        NotFoundFailure(message: 'Transaksi tidak ditemukan'),
        null,
      );
    }
  }
}
