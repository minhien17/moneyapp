class Transaction {
  final int id, value;
  final String type, note;
  final String date;
  final int typeInOut;
  final int balance;

  Transaction(
      {required this.id,
      required this.value,
      required this.type,
      required this.note,
      required this.date,
      required this.typeInOut,
      required this.balance});

  @override
  String toString() {
    return 'Transaction{id: $id, value: $value, type: $type, note: $note, date: $date, typeInOut: $typeInOut, balance: $balance}';
  }
}
