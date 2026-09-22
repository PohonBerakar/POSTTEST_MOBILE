import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Manajemen Stok Alat Pancing',

    home: HomePage(),
  ));
}
// Widget HomePage untuk halaman awal apliksasi
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {//widget build untuk membuat tampilan halaman
    return Scaffold(//scaffold untuk membuat struktur halaman
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar( //bar yang di atas halaman yang ada tulisan stok alat pacing
        backgroundColor: Colors.blue.shade800,//biar appbarnya warna biru
        elevation: 0,
        title: const Row(
          children: [
            Icon(
              Icons.phishing, // ikon pancing
              color: Colors.white,
            ),
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
      ),

      body: SafeArea(//safe area biar tidak keluar dari body
        child: SingleChildScrollView(//biar bisa discroll
          child: Padding( 
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,//tulisan start di kiri 
              children: [
                const Text(
                  'Manajemen Stok', // untuk judul halaman tapi dibawah appbar
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Kelola Stok toko',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 20),

                Container(//container untuk ringkasan stok
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(16),
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
                          Expanded(//biar bisa menyesuaikan ukuran layar
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '120',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),

                                Text(
                                  'Total Produk',
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
                                const Text(
                                  '8',
                                  style: TextStyle(
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Container(//container untuk kolom pencarian
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),

                  child: const TextField(//untuk membuat kolom pencarian
                    decoration: InputDecoration(
                      hintText: 'Cari nama alat pancing...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),

                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Daftar Produk',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Container(//container untuk card produk 1
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),

                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Icon(
                          Icons.phishing,
                          color: Colors.blue.shade800,
                          size: 28,
                        ),
                      ),

                      const SizedBox(width: 14),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Joran Carbon 180cm',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              'Kategori: Joran',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              'Stok: 25 pcs',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),

                Container(//container untuk card produk 2
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),

                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Icon(
                          Icons.settings_input_component,
                          color: Colors.orange.shade800,
                          size: 28,
                        ),
                      ),

                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reel Spinning 4000',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),

                            Text(
                              'Kategori: Reel',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              'Stok: 6 pcs',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.warning_amber_rounded,// ikon untuk menampilkan tanda seru karena stok tipis
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),

                // container untuk card produk 3
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),

                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Icon(
                          Icons.circle_outlined,
                          color: Colors.green.shade800,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Senar Pancing 0.30mm',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              'Kategori: Senar',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Stok: 40 pcs', //menampilkan jumlah stok
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.check_circle, //ikon centang yang di kanan
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}