import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {// fungsi main untuk menjalankan aplikasi
  runApp(
    MultiProvider(// multi provider untuk mengelola state aplikasi
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // change notifier provider untuk mengelola state keranjang belanja
      ],
      child: const MaterialApp(// material app untuk membuat aplikasi
        debugShowCheckedModeBanner: false,
        title: 'Manajemen Stok Alat Pancing',
        home: HomePage(),// home page untuk menampilkan halaman utama aplikasi
      ),
    ),
  );
}

class Product {// class product untuk menampung data produk
  final String id;
  final String name;
  final String category;
  final int price;
  int stock;
  final String? imageAsset;
  final IconData icon;

  Product({// constructor untuk class product
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    this.imageAsset,
    required this.icon,
  });
}

class CartProvider extends ChangeNotifier {// class cart provider untuk mengelola state keranjang belanja
  final List<Product> products = [// list produk yang tersedia
    Product(
      id: 'joran',
      name: 'Joran Carbon 180cm',
      category: 'Joran',
      price: 250000,
      stock: 25,
      imageAsset: 'assets/joran.png',
      icon: Icons.phishing,
    ),
    Product(
      id: 'reel',
      name: 'Reel Spinning 4000',
      category: 'Reel',
      price: 175000,
      stock: 6,
      imageAsset: 'assets/reel.png',
      icon: Icons.settings,
    ),
    Product(
      id: 'senar',
      name: 'Senar Pancing 0.30mm',
      category: 'Senar',
      price: 50000,
      stock: 40,
      imageAsset: 'assets/senar.jpeg',
      icon: Icons.circle_outlined,
    ),
  ];

  final Map<String, int> cartQuantities = {};// map untuk menampung jumlah produk yang ada di keranjang belanja
  int get totalProducts => products.length;
  int get lowStockCount => products.where((product) => product.stock <= 8).length;
  int get cartItemCount =>
      cartQuantities.values.fold(0, (total, quantity) => total + quantity);
  int get grandTotal => products.fold(
        0,
        (total, product) =>
            total + product.price * (cartQuantities[product.id] ?? 0),
      );

  List<Product> get cartProducts => products
      .where((product) => (cartQuantities[product.id] ?? 0) > 0)// fungsi untuk mendapatkan daftar produk yang ada di keranjang belanja
      .toList();

  int quantityFor(String productId) => cartQuantities[productId] ?? 0;

  Product productById(String productId) =>// fungsi untuk mendapatkan produk berdasarkan id
      products.firstWhere((product) => product.id == productId);

  bool addToCart(String productId) {// fungsi untuk menambahkan produk ke keranjang belanja
    final product = productById(productId);
    if (product.stock <= 0) return false;

    product.stock--;// mengurangi stok produk
    cartQuantities[productId] = quantityFor(productId) + 1;
    notifyListeners();
    return true;
  }

  void removeFromCart(String productId) {// fungsi untuk menghapus produk dari keranjang belanja
    final quantity = quantityFor(productId);
    if (quantity <= 0) return;

    productById(productId).stock++;// menambahkan stok produk karena produk dihapus dari keranjang belanja
    if (quantity == 1) {
      cartQuantities.remove(productId);
    } else {
      cartQuantities[productId] = quantity - 1;
    }
    notifyListeners();
  }

  void clearCart() {// fungsi untuk mengosongkan keranjang belanja
    for (final entry in cartQuantities.entries) {
      productById(entry.key).stock += entry.value;
    }
    cartQuantities.clear();
    notifyListeners();
  }
}

String formatRupiah(int value) {// fungsi untuk memformat angka menjadi format rupiah
  final formatted = value
      .toString()
      .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.');
  return 'Rp$formatted';
}

class HomePage extends StatefulWidget {// Widget HomePage untuk halaman awal aplikasi
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();// membuat state untuk widget HomePage
}

class _HomePageState extends State<HomePage> {// state untuk widget HomePage
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';// variabel untuk menampung query pencarian

  @override
  void dispose() {// fungsi dispose untuk membersihkan controller pencarian saat widget dihapus dari tree
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { // widget build untuk membuat tampilan halaman
    final cart = context.watch<CartProvider>();
    final filteredProducts = cart.products.where((product) {
      final query = searchQuery.toLowerCase();
      return product.stock > 0 &&
          (product.name.toLowerCase().contains(query) ||
              product.category.toLowerCase().contains(query));
    }).toList();

    return Scaffold( // scaffold untuk membuat struktur halaman
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(//bar yang di atas halaman yang ada tulisan stok alat pacing
        backgroundColor: Colors.blue.shade800,//biar appbarnya warna biru
        title: const Row(
          //row untuk menyusun isi appbar secara mendatar
          children: [
            Icon(Icons.phishing, color: Colors.white),//ikon pancing
            SizedBox(width: 10),
            Text(
              'Stok Alat Pancing',
              style: TextStyle(//mengatur style tulisan seperti warna ukuran dan lainnya
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, provider, child) {
              return IconButton(
                tooltip: 'Keranjang',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartPage()),
                  );
                },
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                    if (provider.cartItemCount > 0)
                      Positioned(
                        top: -7,
                        right: -8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${provider.cartItemCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        //safe area biar tidak keluar dari body
        // singlechildscrollview biar halaman bisa discroll
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column( // column untuk menyusun isi halaman ke bawah
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Manajemen Stok',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Kelola stok toko alat pancing',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 20),
                Container(// container untuk ringkasan stok
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ringkasan Stok',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded( // expanded biar ukuran menyesuaikan layar
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${cart.totalProducts}',
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Jenis Produk',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.blue.shade100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${cart.lowStockCount}',
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Stok Menipis',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.blue.shade100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Cari Produk',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(// container untuk kolom pencarian
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(// textfield untuk kolom pencarian
                    controller: _searchController,
                    onChanged: (value) => setState(() => searchQuery = value),
                    decoration: const InputDecoration(
                      hintText: 'Cari nama alat pancing...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      suffixIcon: Icon(Icons.search, color: Colors.grey),// ikon pencarian di sebelah kanan kolom
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Daftar Produk',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                if (filteredProducts.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: Text('Produk tidak ditemukan.')),// jika produk tidak ditemukan
                  )
                else
                  ...filteredProducts.map(
                    (product) => ProductCard(product: product),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {// widget untuk menampilkan card produk
  final Product product;// variabel untuk menampung data produk

  const ProductCard({super.key, required this.product}); // constructor untuk menerima data produk

  @override
  Widget build(BuildContext context) {// widget build untuk membuat tampilan card produk
    final available = product.stock > 8;
    final stockColor = product.stock == 0
        ? Colors.red
        : available
            ? Colors.green
            : Colors.orange;

    return Container(// container untuk card produk
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ProductImage(product: product, width: 100, height: 100),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Kategori: ${product.category}',
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      formatRupiah(product.price),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: stockColor.withOpacity(0.12),// biar warna stok agak transparan
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Stok: ${product.stock} pcs',
                        style: TextStyle(
                          color: stockColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(// row untuk menampilkan tombol lihat detail dan tambah ke keranjang
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(productId: product.id),
                      ),
                    );
                  },
                  child: const Text('Lihat Detail'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: product.stock > 0
                      ? () {
                          final added =
                              context.read<CartProvider>().addToCart(product.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                added
                                    ? '${product.name} ditambahkan ke keranjang'
                                    : 'Stok produk habis',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.add_shopping_cart, size: 18),
                  label: const Text('Tambah'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {// widget untuk menampilkan gambar produk
  final Product product;// variabel untuk menampung data produk
  final double width;// variabel untuk menampung data lebar gambar
  final double height;// variabel untuk menampung data tinggi gambar

  const ProductImage({
    super.key,
    required this.product,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {// widget build untuk membuat tampilan gambar produk
    if (product.imageAsset != null) {// jika produk memiliki gambar, tampilkan gambar tersebut
      return Image.asset(
        product.imageAsset!,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.green.shade50,
      alignment: Alignment.center,
      child: Icon(product.icon, color: Colors.green.shade800, size: 38),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        final product = cart.productById(productId);
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: AppBar(
            backgroundColor: Colors.blue.shade800,
            foregroundColor: Colors.white,
            title: const Text('Detail Produk'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ProductImage(
                            product: product,
                            width: 220,
                            height: 220,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          product.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Kategori: ${product.category}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Jumlah stok: ${product.stock} pcs',
                          style: TextStyle(
                            fontSize: 16,
                            color: product.stock <= 8
                                ? Colors.orange
                                : Colors.green,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Harga jual: ${formatRupiah(product.price)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: product.stock > 0
                                ? () {
                                    final added = context
                                        .read<CartProvider>()
                                        .addToCart(product.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          added
                                              ? 'Produk ditambahkan ke keranjang'
                                              : 'Stok produk habis',
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            icon: const Icon(Icons.add_shopping_cart),
                            label: const Text('Tambah ke Keranjang'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Kembali'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CartPage extends StatelessWidget {// widget untuk menampilkan halaman keranjang belanja
  const CartPage({super.key});// constructor untuk halaman keranjang belanja

  @override
  Widget build(BuildContext context) {// widget build untuk membuat tampilan halaman keranjang belanja
    final cart = context.watch<CartProvider>();// variabel untuk menampung data keranjang belanja

    return Scaffold(// scaffold untuk membuat struktur halaman
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: const Text('Keranjang Belanja'),
      ),
      body: cart.cartProducts.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('Keranjang masih kosong'),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.cartProducts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),// biar ada jarak antar item
                    itemBuilder: (context, index) {
                      final product = cart.cartProducts[index];
                      final quantity = cart.quantityFor(product.id);
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: ProductImage(
                                product: product,
                                width: 68,
                                height: 68,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(formatRupiah(product.price)),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Subtotal: ${formatRupiah(product.price * quantity)}',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => context
                                      .read<CartProvider>()
                                      .removeFromCart(product.id),
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                Text('$quantity'),
                                IconButton(
                                  onPressed: product.stock > 0
                                      ? () => context
                                          .read<CartProvider>()
                                          .addToCart(product.id)
                                      : null,
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 8,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Belanja',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              formatRupiah(cart.grandTotal),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () {
                            context.read<CartProvider>().clearCart();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Keranjang dikosongkan'),
                              ),
                            );
                          },
                          child: const Text('Kosongkan Keranjang'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
