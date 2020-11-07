class Transaction {
  final DateTime timestamp;
  final double amount;
  final String name;

  Transaction(this.timestamp, this.amount, this.name);

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        DateTime.parse(json['tstamp']), -json['rahamaara'], json['name'] == null ? "Unknown" : json['name']
    );
  }
}