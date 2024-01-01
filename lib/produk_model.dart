class ProdukModel {
  int? id;
  String? name, category, createAt, updateAt;

  ProdukModel(
      {this.id, this.name, this.category, this.createAt, this.updateAt});
  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        createAt: json['create_at'],
        updateAt: json['update_at']);
  }
}
