import 'dart:convert';

TransactionResponseModel transactionResponseModelFromJson(String str) =>
    TransactionResponseModel.fromJson(json.decode(str));

String transactionResponseModelToJson(TransactionResponseModel data) =>
    json.encode(data.toJson());

class TransactionResponseModel {
  String status;
  Data data;

  TransactionResponseModel({required this.status, required this.data});

  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) =>
      TransactionResponseModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"status": status, "data": data.toJson()};
}

class Data {
  Summary summary;
  List<Transaction> transactions;

  Data({required this.summary, required this.transactions});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    summary: Summary.fromJson(json["summary"]),
    transactions: List<Transaction>.from(
      json["transactions"].map((x) => Transaction.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "summary": summary.toJson(),
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class Summary {
  int totalBalance;
  int totalIncome;
  double totalExpense;

  Summary({
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpense,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalBalance: json["totalBalance"],
    totalIncome: json["totalIncome"],
    totalExpense: json["totalExpense"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "totalBalance": totalBalance,
    "totalIncome": totalIncome,
    "totalExpense": totalExpense,
  };
}

class Transaction {
  String id;
  Type type;
  String title;
  String message;
  int amount;
  DateTime date;

  Transaction({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.amount,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    type: typeValues.map[json["type"]]!,
    title: json["title"],
    message: json["message"],
    amount: json["amount"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": typeValues.reverse[type],
    "title": title,
    "message": message,
    "amount": amount,
    "date": date.toIso8601String(),
  };
}

enum Type { EXPENSE, INCOME }

final typeValues = EnumValues({"expense": Type.EXPENSE, "income": Type.INCOME});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
