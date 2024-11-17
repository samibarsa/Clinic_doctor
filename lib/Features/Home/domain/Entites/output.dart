class Output {
  final int id;
  final String outputType;
  final int price;

  Output({required this.id, required this.outputType, required this.price});
  factory Output.fromJson(Map<String, dynamic> json) {
    return Output(
        id: json['id'], outputType: json['output_type'], price: json['price']);
  }
}
