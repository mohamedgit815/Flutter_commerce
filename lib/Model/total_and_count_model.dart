class TotalAndCountModel {
  final int totalCount, totalPrice;

  const TotalAndCountModel({
    required this.totalCount ,
    required this.totalPrice
  });

  factory TotalAndCountModel.fromJson(Map<String,dynamic>json) {
    return TotalAndCountModel(
        totalCount: json['count'],
        totalPrice: json['total']
    );
  }
}