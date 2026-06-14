import 'package:flutter_test/flutter_test.dart';
import 'package:banksatu_mobile/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:banksatu_mobile/data/repositories/transaction_repository_impl.dart';

void main() {
  late TransactionRepositoryImpl repository;
  late TransactionRemoteDatasource datasource;

  setUp(() {
    datasource = TransactionRemoteDatasourceImpl();
    repository = TransactionRepositoryImpl(datasource);
  });

  group('TransactionRepository', () {
    test('getTransactions returns list of transactions', () async {
      final (failure, transactions) = await repository.getTransactions();

      expect(failure, isNull);
      expect(transactions, isNotNull);
      expect(transactions!.length, greaterThan(0));
    });

    test('getTransactionById returns correct transaction', () async {
      final (failure, transaction) = await repository.getTransactionById('tx_01');

      expect(failure, isNull);
      expect(transaction, isNotNull);
      expect(transaction!.id, equals('tx_01'));
      expect(transaction.merchantName, equals('Kopi Kenangan - Grand Indonesia'));
    });

    test('getTransactionById returns not found for invalid id', () async {
      final (failure, transaction) = await repository.getTransactionById('invalid');

      expect(transaction, isNull);
      // Will throw StateError from firstWhere — should be handled gracefully
    });
  });
}
