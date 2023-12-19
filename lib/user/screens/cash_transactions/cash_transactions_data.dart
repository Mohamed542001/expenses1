part of 'cash_transactions_imports.dart';

class CashTransactionsData{

  TransactionModel model = TransactionModel(
    name: "المعاملات النقدية",
  );

  GenericBloc<List<AddTransactionModel>> addTransactionCubit = GenericBloc([]);

  List<AddTransactionModel> addTransactionList = [];


  Future<void> fetchData() async {
    final box = await Hive.openBox<AddTransactionModel>("addTransactionBox");
    try {
      var list = box.values.map((dynamic value) {
        if (value is AddTransactionModel) {
          return value;
        } else {
          return AddTransactionModel(); // Replace with your default value or handle it accordingly
        }
      }).toList();
      for (AddTransactionModel item in list) {
        if (item.transactionName == "المعاملات النقدية") {
          addTransactionList.add(item);
        }
      }
      addTransactionCubit.onUpdateData(addTransactionList);
    } catch (e) {
      print('Error fetching data from Hive: $e');
    } finally {
      await box.close();
    }
  }
}