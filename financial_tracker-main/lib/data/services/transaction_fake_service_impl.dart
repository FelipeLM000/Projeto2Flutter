import 'dart:convert';

import 'package:financial_tracker/helper/transaction_fake_repository.dart';

import '../../common/errors/errors_classes.dart';
import '../../common/errors/errors_messagens.dart';
import '../../common/patterns/result.dart';
import '../../domain/entity/transaction_entity.dart';
import 'transaction_storage_contract.dart';

class TransactionFakeServiceImpl implements TransactionStorageContract {
  final TransactionFakeRepository _api = TransactionFakeRepository();

  @override
  Future<Result<List<TransactionEntity>, Failure>> fetchAllTransacions() async {
    try {
      var result = await _api.getData();

      final List<dynamic> jsonList = jsonDecode(result);

      final transactions = jsonList
          .map(
            (item) => TransactionEntity.fromMap(item as Map<String, dynamic>),
          )
          .toList();
      return Success(transactions);
    } on DatasourceResultEmpty catch (e) {
      return Error(DatasourceResultEmpty(e.msg));
    } on APIFailure catch (e) {
      return Error(APIFailure(e.msg));
    } catch (e) {
      return Error(DefaultError('${MessagesError.defaultError}: ${e.toString()}'));
    }
  }

  @override
  Future<Result<TransactionEntity, Failure>> fetchTransacion(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<TransactionEntity>, Failure>> fetchTransacionsByTipe(
    TransactionType type,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<Result<void, Failure>> removeTransacion(String id) async {
    try {
      await _api.deleteData(id);
      return Success(null);
    } on RecordNotFound catch (e) {
      return Error(RecordNotFound(e.msg));
    } on APIFailure catch (e) {
      return Error(APIFailure(e.msg));
    } catch (e) {
      return Error(DefaultError('${MessagesError.defaultError}: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void, Failure>> storeTransacion(
    TransactionEntity transaction,
  ) async {
    try {
      await _api.addData(transaction.toJson());
      return Success(null);
    } on InvalidData catch (e) {
      return Error(InvalidData(e.msg));
    } on APIFailure catch (e) {
      return Error(APIFailure(e.msg));
    } catch (e) {
      return Error(DefaultError('${MessagesError.defaultError}: ${e.toString()}'));
    }
  }

  @override
  Future<Result<List<TransactionEntity>, Failure>> fetchTransacionsByDate(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      var result = await _api.getDataByDateRange(startDate, endDate);

      final List<dynamic> jsonList = jsonDecode(result);

      final transactions = jsonList
          .map(
            (item) => TransactionEntity.fromMap(item as Map<String, dynamic>),
          )
          .toList();
      return Success(transactions);
    } on DatasourceResultEmpty catch (e) {
      return Error(DatasourceResultEmpty(e.msg));
    } on APIFailure catch (e) {
      return Error(APIFailure(e.msg));
    } catch (e) {
      return Error(DefaultError('${MessagesError.defaultError}: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void, Failure>> updateTransaction(TransactionEntity transaction) async {
    print('Chamando update para transação: ${transaction.id}');
    try {
      final json = jsonEncode(transaction.toMap());
      await _api.updateData(json);
      return Success(null);
    } on RecordNotFound catch (e) {
      return Error(RecordNotFound(e.msg));
    } on APIFailureOnSave catch (e) {
      return Error(APIFailureOnSave(e.msg));
    } catch (e) {
      return Error(DefaultError('${MessagesError.defaultError}: ${e.toString()}'));
    }
  }
}
