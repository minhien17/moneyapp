class Expense {
  final int id, value;
  final String type, note;

  Expense(
      {required this.id,
      required this.value,
      required this.type,
      required this.note});

  @override
  String toString() {
    return 'Expense{id: $id, value: $value, type: $type, note: $note}';
  }
}
