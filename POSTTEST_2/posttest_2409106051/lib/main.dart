import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manajemen Stok Alat Pancing',
      home: HomePage(),
    ),
  );
}

// Widget HomePage untuk halaman awal aplikasi
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // widget build untuk membuat tampilan halaman
    return Scaffold(
      // scaffold untuk membuat struktur halaman
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        //bar yang di atas halaman yang ada tulisan stok alat pacing
        backgroundColor: Colors.blue.shade800, //biar appbarnya warna biru
        title: const Row(
          //row untuk menyusun isi appbar secara mendatar
          children: [
            Icon(
              Icons.phishing, //ikon pancing
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              'Stok Alat Pancing',
              style: TextStyle(
                //mengatur style tulisan seperti warna ukuran dan lainnya
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        //safe area biar tidak keluar dari body
        // singlechildscrollview biar halaman bisa discroll
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            // column untuk menyusun isi halaman ke bawah
            child: Column(
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
                  'Kelola Stok toko',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 20),

                Container(
                  // container untuk ringkasan stok
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
                          // expanded biar ukuran menyesuaikan layar
                          Expanded(
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                // container untuk kolom pencarian
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),

                  // textfield untuk membuat kolom pencarian
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari nama alat pancing...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),

                      //ikon pencarian
                      suffixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Daftar Produk',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                // container untuk card produk 1
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
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
                      // stack untuk menumpuk gambar dan tulisan stok
                      Stack(
                        children: [
                          // image untuk menampilkan gambar dari file, gambar harus masuk di folder assets
                          // dan harus ditambahkan di pubspec.yaml
                          Image.asset(
                            'assets/joran.png',
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),

                          // positioned untuk mengatur posisi tulisan stok
                          Positioned(
                            top: 10,
                            right: 10,

                            // container untuk membuat label stok
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: const Text(
                                'Stok: 25',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Joran Carbon 180cm',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Kategori: Joran',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Rp250.000',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Icon(
                            Icons.check_circle, //ikon status stok
                            color: Colors.green,
                            size: 30,
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // row untuk tombol navigasi
                      Row(
                        children: [
                          // expanded biar tombol menyesuaikan lebar layar
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // navigator push untuk pindah ke halaman detail
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DetailPage(),
                                  ),
                                );
                              },
                              child: const Text('Lihat Detail'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // container untuk card produk 2
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            //foto reel
                            'assets/reel.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),

                          const SizedBox(width: 12),
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
                                SizedBox(height: 5),
                                Text(
                                  'Kategori: Reel',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Stok: 6 pcs',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // positioned untuk menempatkan icon di kanan atas
                      Positioned(
                        top: 0,
                        right: 0,

                        child: Icon(
                          Icons.warning_amber_rounded, //ikon peringatan stok menipis
                          color: Colors.orange.shade700,
                          size: 28,
                        ),
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
                    border: Border.all(color: Colors.grey.shade200),
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
                              'Stok: 40 pcs',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.check_circle, color: Colors.green),
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

// Widget DetailPage untuk halaman detail produk
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // scaffold untuk membuat struktur halaman detail
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      // appbar untuk membuat bar di atas halaman
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: const Text('Detail Stok'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // container untuk card detail produk
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
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
                    Stack(
                      children: [
                        Image.asset(
                          'assets/joran.png',
                          width: 220,
                          height: 220,
                          fit: BoxFit.cover,
                        ),

                        Positioned(
                          bottom: 10,
                          right: 10,

                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: const Text(
                              'Tersedia',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Joran Carbon 180cm',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Jumlah stok: 25 pcs',
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Harga jual: Rp250.000',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // row untuk tombol kembali
                    Row(
                      children: [
                        // expanded biar tombol menyesuaikan layar
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // navigator pop untuk kembali ke halaman sebelumnya
                              Navigator.pop(context);
                            },

                            child: const Text('Kembali'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
