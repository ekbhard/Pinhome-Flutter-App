

// Close reasonCloseFromJson(String str) => Close.fromJson(json.decode(str));
//
// String reasonCloseToJson(Close data) => json.encode(data.toJson());

class Close {
  Close({
    this.type,
    this.reason,
  });

  int type;
  int reason;

  factory Close.fromReason(int reason) => Close(
        type: 1,
        reason: reason,
      );

  Map<String, dynamic> toJson() => {
        "type": 1,
        "reason": reason,
      };
}
