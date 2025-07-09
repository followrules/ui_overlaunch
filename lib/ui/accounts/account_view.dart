import 'package:flutter/material.dart';


class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet UI',
      debugShowCheckedModeBanner: false,
      home: const WalletHomePage(),
    );
  }
}

class WalletHomePage extends StatelessWidget {
  const WalletHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width * 0.9;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Ganti ke asset jika perlu
                Image.network(
                  "https://cdn-icons-png.flaticon.com/512/3667/3667333.png",
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 40),
                Container(
                  width: cardWidth,
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Wallet Address
                      _MenuField(
                        icon: Icons.wallet,
                        hint: "wallet address",
                      ),
                      const Divider(thickness: 1, height: 30),
                      // Language
                      _MenuField(
                        icon: Icons.language,
                        hint: "Language",
                      ),
                      const Divider(thickness: 1, height: 30),
                      // Rate App
                      _MenuField(
                        icon: Icons.star_border,
                        hint: "Rate App",
                      ),
                      const SizedBox(height: 32),
                      // Connect button
                      SizedBox(
                        width: cardWidth * 0.8,
                        height: 48,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[400],
                            foregroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          icon: const Icon(Icons.link),
                          label: const Text("Connect"),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuField extends StatelessWidget {
  final IconData icon;
  final String hint;

  const _MenuField({required this.icon, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: Colors.black54),
        const SizedBox(width: 14),
        Expanded(
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              isDense: true,
              hintStyle: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}