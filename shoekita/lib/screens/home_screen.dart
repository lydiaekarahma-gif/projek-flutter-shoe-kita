import 'package:flutter/material.dart';

const Color pinkLight = Color(0xFFF4B6B6);
const Color pinkNav = Color(0xFFEB7F7F);

class Product {
  final String name;
  final String image;
  const Product(this.name, this.image);
}

const List<Product> products = [
  Product('NIKE Pegasus 42', 'assets/nike_pegasus.png'),
  Product('Puma Shuffle', 'assets/puma_shuffle.png'),
  Product('PUMA Rebound V6 Low', 'assets/puma_rebound.png'),
  Product('Sepatu Kain Bordir Tradisional', 'assets/sepatu_bordir.png'),
  Product('Shoekita H-Series Chunky', 'assets/shoekita_chunky.png'),
  Product('Adidas Samba OG', 'assets/adidas_samba.png'),
  Product('Z-Series Batik Slip-On', 'assets/z_batik.png'),
];

// ======================= HOME SCREEN =======================
class HomeScreen extends StatefulWidget {
  final String namaUser;
  const HomeScreen({super.key, required this.namaUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _HomeTab(namaUser: widget.namaUser),
      const _PlaceholderTab(icon: Icons.search, title: 'Pencarian'),
      const _PlaceholderTab(icon: Icons.swap_horiz, title: 'Transaksi'),
      const _PlaceholderTab(
          icon: Icons.account_balance_wallet_outlined, title: 'Dompet'),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: Container(
        color: pinkNav,
        child: SafeArea(
          top: false,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (i) => setState(() => _selectedIndex = i),
            backgroundColor: pinkNav,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black54,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.swap_horiz), label: 'Transaksi'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_outlined),
                  label: 'Wallet'),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  final String namaUser;
  const _HomeTab({required this.namaUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [pinkLight, Colors.white],
          stops: [0.0, 0.12],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ===== BAGIAN TETAP (tidak ikut scroll) =====
            _searchBar(),
            _chips(context),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: _brandHeader(),
            ),

            // ===== BAGIAN YANG BISA DI-SCROLL =====
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  children: [
                    Text(
                      'Halo, $namaUser! 👋',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'produk sepatu yang kami rekomendasikan untuk anda :',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...products.map((p) => _productItem(context, p)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(fontSize: 13, color: Colors.black54),
          prefixIcon: const Icon(Icons.search, size: 20),
          filled: true,
          fillColor: const Color(0xFFF5EDED),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _chips(BuildContext context) {
    final items = [
      (Icons.favorite_border, 'Favorites'),
      (Icons.history, 'History'),
      (Icons.person_add_alt, 'Following'),
      (Icons.receipt_long_outlined, 'Orders'),
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          return InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${items[i].$2} dipilih')),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black26),
              ),
              child: Row(
                children: [
                  Icon(items[i].$1, size: 14),
                  const SizedBox(width: 4),
                  Text(items[i].$2, style: const TextStyle(fontSize: 11)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _brandHeader() {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/logo_shoekita.png',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              width: 80,
              height: 80,
              color: Colors.white,
              child: const Icon(Icons.snowshoeing, size: 40),
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Text(
            'SHOEKITA\nGaya Dan Kemudahan\nDi Setiap Langkah',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'serif'),
          ),
        ),
      ],
    );
  }

  Widget _productItem(BuildContext context, Product p) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(name: p.name, image: p.image),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 60,
              child: Hero(
                tag: p.name,
                child: Image.asset(
                  p.image,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                p.name,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  final IconData icon;
  final String title;
  const _PlaceholderTab({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: pinkNav),
            const SizedBox(height: 12),
            Text('Halaman $title',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Segera hadir', style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}

// ======================= DETAIL PRODUK =======================
class ProductDetailScreen extends StatelessWidget {
  final String name;
  final String image;

  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: const TextStyle(fontSize: 16)),
        backgroundColor: pinkNav,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: name,
                child: Image.asset(
                  image,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => const Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'Sepatu nyaman dan bergaya untuk menemani setiap langkahmu.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$name ditambahkan ke keranjang')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('TAMBAH KE KERANJANG',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}