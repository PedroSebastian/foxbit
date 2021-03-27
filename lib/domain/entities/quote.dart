class Quote {
  final double lastTradedPx;
  final double rolling24HrVolume;
  final double rolling24HrPxChange;

  const Quote({this.lastTradedPx, this.rolling24HrVolume, this.rolling24HrPxChange});

  factory Quote.fromMap(Map<dynamic, dynamic> map) {
    return Quote(
      lastTradedPx: map['LastTradedPx'] != null
          ? double.parse(map['LastTradedPx'].toString())
          : null,
      rolling24HrVolume: map['Rolling24HrVolume'] as double,
      rolling24HrPxChange: map['Rolling24HrPxChange'] as double,
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <dynamic, dynamic>{
      'LastTradedPx': lastTradedPx,
      'Rolling24HrVolume': rolling24HrVolume,
      'Rolling24HrPxChange': rolling24HrPxChange,
    };
  }
}