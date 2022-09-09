class CartItem {
  final String id, title, imgurl, size;
  String? rate;
  int quantity;
  double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imgurl,
    required this.size,
    this.rate,
  });
}
