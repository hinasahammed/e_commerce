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
}
