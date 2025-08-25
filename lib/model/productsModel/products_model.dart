// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductsModel {
  ProductsModel({
    required this.code,
    required this.subCategoryCode,
    this.variantCode = 0,
    required this.imageUrl,
    required this.subSkuName,
    required this.desc,
    required this.uom,
    required this.sellingPrice,
    required this.mrp,
  });
  final int code;
  final int subCategoryCode;
  final int variantCode;
  final String imageUrl;
  final String subSkuName;
  final String desc;
  final String uom;
  final double sellingPrice;
  final double mrp;

  ProductsModel copyWith({
    int? code,
    int? subCategoryCode,
    int? variantCode,
    String? imageUrl,
    String? subSkuName,
    String? desc,
    String? uom,
    double? sellingPrice,
    double? mrp,
  }) {
    return ProductsModel(
      code: code ?? this.code,
      subCategoryCode: subCategoryCode ?? this.subCategoryCode,
      variantCode: variantCode ?? this.variantCode,
      imageUrl: imageUrl ?? this.imageUrl,
      subSkuName: subSkuName ?? this.subSkuName,
      desc: desc ?? this.desc,
      uom: uom ?? this.uom,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      mrp: mrp ?? this.mrp,
    );
  }
}
