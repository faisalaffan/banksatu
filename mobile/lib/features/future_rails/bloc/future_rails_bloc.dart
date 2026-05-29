import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulator/features/future_rails/models/future_rails_data.dart';

// Events
abstract class FutureRailsEvent {}

class LoadFutureRails extends FutureRailsEvent {}

class MintCbdcTokens extends FutureRailsEvent {
  final double amount;
  MintCbdcTokens(this.amount);
}

class BackupCustodyKeys extends FutureRailsEvent {}

class SpendBansosAid extends FutureRailsEvent {
  final double amount;
  final String category;
  SpendBansosAid({required this.amount, required this.category});
}

class ResetTransactionState extends FutureRailsEvent {}

// States
abstract class FutureRailsState {}

class FutureRailsLoading extends FutureRailsState {}

class FutureRailsLoaded extends FutureRailsState {
  final FutureRailsData data;
  final String? transactionStatusMessage;
  final bool isTransactionSuccessful;

  FutureRailsLoaded({
    required this.data,
    this.transactionStatusMessage,
    this.isTransactionSuccessful = true,
  });

  FutureRailsLoaded copyWith({
    FutureRailsData? data,
    String? transactionStatusMessage,
    bool? isTransactionSuccessful,
  }) {
    return FutureRailsLoaded(
      data: data ?? this.data,
      transactionStatusMessage: transactionStatusMessage,
      isTransactionSuccessful: isTransactionSuccessful ?? this.isTransactionSuccessful,
    );
  }
}

// Bloc
class FutureRailsBloc extends Bloc<FutureRailsEvent, FutureRailsState> {
  FutureRailsBloc() : super(FutureRailsLoading()) {
    on<LoadFutureRails>(_onLoadFutureRails);
    on<MintCbdcTokens>(_onMintCbdcTokens);
    on<BackupCustodyKeys>(_onBackupCustodyKeys);
    on<SpendBansosAid>(_onSpendBansosAid);
    on<ResetTransactionState>(_onResetTransactionState);
  }

  void _onLoadFutureRails(LoadFutureRails event, Emitter<FutureRailsState> emit) {
    emit(FutureRailsLoaded(
      data: const FutureRailsData(
        cbdcBalance: 1250000.00, // Rp 1.25jt
        cryptoAssets: {
          'USDT': 150.00,
          'USDC': 75.00,
        },
        isSecureCustodyBackupDone: false,
        bansosBalance: 600000.00, // Rp 600k
        bansosLockedCategory: 'Sembako & Kebutuhan Pokok',
        educationBalance: 1500000.00, // Rp 1.5jt
        educationLockedCategory: 'Biaya Sekolah / Kuliah',
      ),
    ));
  }

  void _onMintCbdcTokens(MintCbdcTokens event, Emitter<FutureRailsState> emit) {
    if (state is FutureRailsLoaded) {
      final currentState = state as FutureRailsLoaded;
      emit(currentState.copyWith(
        data: currentState.data.copyWith(
          cbdcBalance: currentState.data.cbdcBalance + event.amount,
        ),
        transactionStatusMessage: 'Sukses mencetak (mint) Rupiah Digital sebesar Rp ${event.amount.toInt()}!',
        isTransactionSuccessful: true,
      ));
    }
  }

  void _onBackupCustodyKeys(BackupCustodyKeys event, Emitter<FutureRailsState> emit) {
    if (state is FutureRailsLoaded) {
      final currentState = state as FutureRailsLoaded;
      emit(currentState.copyWith(
        data: currentState.data.copyWith(
          isSecureCustodyBackupDone: true,
        ),
        transactionStatusMessage: 'Kunci kustodi kripto (recovery keys) berhasil dicadangkan dengan aman!',
        isTransactionSuccessful: true,
      ));
    }
  }

  void _onSpendBansosAid(SpendBansosAid event, Emitter<FutureRailsState> emit) {
    if (state is FutureRailsLoaded) {
      final currentState = state as FutureRailsLoaded;
      
      // Strict programmable spending lock logic
      if (event.category != currentState.data.bansosLockedCategory) {
        emit(currentState.copyWith(
          transactionStatusMessage: 'Transaksi Ditolak! Dana Bansos terkunci hanya untuk kategori "${currentState.data.bansosLockedCategory}".',
          isTransactionSuccessful: false,
        ));
      } else if (event.amount > currentState.data.bansosBalance) {
        emit(currentState.copyWith(
          transactionStatusMessage: 'Transaksi Gagal! Saldo Dana Bansos tidak mencukupi.',
          isTransactionSuccessful: false,
        ));
      } else {
        emit(currentState.copyWith(
          data: currentState.data.copyWith(
            bansosBalance: currentState.data.bansosBalance - event.amount,
          ),
          transactionStatusMessage: 'Transaksi Berhasil! Dana Bansos dibelanjakan sebesar Rp ${event.amount.toInt()} untuk ${event.category}.',
          isTransactionSuccessful: true,
        ));
      }
    }
  }

  void _onResetTransactionState(ResetTransactionState event, Emitter<FutureRailsState> emit) {
    if (state is FutureRailsLoaded) {
      final currentState = state as FutureRailsLoaded;
      emit(FutureRailsLoaded(
        data: currentState.data,
      ));
    }
  }
}
