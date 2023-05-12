enum Menu {
  paymentType(
    '/payment-type/',
    'payment_type_ico.png',
    'payment_type_ico_selected.png',
    'Administrar Formas de Pagamento',
  ),
  products(
    '/products/',
    'product_ico.png',
    'product_ico_selected.png',
    'Administrar Produtos',
  ),
  orders(
    '/order/',
    'order_ico.png',
    'order_ico_selected.png',
    'Administrar Pedidos',
  );

  final String route;
  final String assetIcon;
  final String asstIconSelected;
  final String label;

  const Menu(this.route, this.assetIcon, this.asstIconSelected, this.label);
}
