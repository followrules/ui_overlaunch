import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlaunch/constant/dummy_data.dart';
import 'package:overlaunch/controller/home_controller.dart';
import 'package:overlaunch/routes/app_pages.dart';
import 'package:overlaunch/ui/widget/custom_button.dart';
import 'package:solana_wallet_provider/solana_wallet_provider.dart';
import 'package:cryptocoins_icons/cryptocoins_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    IconData getCryptoIcon(String code) {
      switch (code.toUpperCase()) {
        case 'BTC':
          return CryptoCoinIcons.BTC;
        case 'ETH':
          return CryptoCoinIcons.ETC;
        case 'USDT':
          return CryptoCoinIcons.USDT;
        case 'DOGE':
          return CryptoCoinIcons.DOGE;
        case 'XRP':
          return CryptoCoinIcons.XRP;
        case 'LTC':
          return CryptoCoinIcons.LTC;
        default:
          return Icons.monetization_on_rounded;
      }
    }

    return SolanaWalletProvider.create(
      httpCluster: Cluster.devnet,
      identity: AppIdentity(
        uri: Uri.parse('https://my_dapp.com'),
        icon: Uri.parse('favicon.png'),
        name: 'My Dapp',
      ),

      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: SafeArea(
          child: LayoutBuilder(
            builder:
                (context, constraints) => CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      pinned: false,
                      floating: false,
                      delegate: _SliverSearchBarDelegate(
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                IconButton(
                                  color: Colors.black87,
                                  splashColor: Colors.green,
                                  onPressed: () =>{
                                    Get.toNamed(Routes.account)
                                  },
                                  icon: Icon(Icons.wallet, size: 25),
                                ),
                                Text(
                                  'Bs6wVhK....ZVj5fAD',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              color: Colors.black87,
                              splashColor: Colors.green,
                              onPressed: () {},
                              icon: Icon(Icons.search, size: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverAppBar(
                      // title: Container(
                      //   color: Colors.green,
                      //   child: Flex(
                      //     direction: Axis.horizontal,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         'Connected at: ',
                      //         style: GoogleFonts.aBeeZee(fontSize: 15),
                      //       ),
                      //       Text(
                      //         'Bs6wVhK....ZVj5fAD',
                      //         style: GoogleFonts.aBeeZee(
                      //           fontSize: 17,
                      //           color: Colors.white54,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.yellow, Colors.pink[100]!],
                          ),
                        ),
                        child: PreferredSize(
                          preferredSize: const Size.fromHeight(50),
                          child: Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                color: Colors.black54,
                                splashColor: Colors.white,
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/img/solana.png',
                                  width: 35,
                                  height: 35,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5.0),
                                child: Flex(
                                  direction: Axis.vertical,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '10.122 SOL ',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 17,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "\$ 1.200.000",
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 12,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      pinned: true,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.36,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.yellow, Colors.pink[100]!],
                          ),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Flex(
                              direction: Axis.vertical,
                              children: [
                                Flex(
                                  direction: Axis.vertical,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.rocket_launch,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Featured',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 15,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                CarouselSlider.builder(
                                  options: CarouselOptions(
                                    height: 280,
                                    enlargeCenterPage: true,
                                    autoPlay: true,
                                    viewportFraction: 0.8,
                                  ),
                                  itemCount: 5,
                                  itemBuilder: (context, index, realIdx) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.network(
                                            'https://raw2.seadn.io/base/0x41dc69132cce31fcbf6755c84538ca268520246f/ae25b56e7616163498963bc9abe224/40ae25b56e7616163498963bc9abe224.png',
                                            fit: BoxFit.fill,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                                      color: Colors.grey[800],
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.error,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                          ),
                                          // Overlay gradient (optional, biar teks lebih jelas)
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black.withOpacity(
                                                      0.35,
                                                    ),
                                                    Colors.transparent,
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Overlay teks di bawah
                                          Positioned(
                                            top: 5,
                                            left: 0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16.0,
                                                  ),
                                              child: Container(
                                                padding: EdgeInsets.all(1),
                                                decoration: BoxDecoration(
                                                  color: Colors.pink[100]!.withOpacity(0.3),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                'Blue Pepe ${index + 1}',
                                                style: GoogleFonts.aBeeZee(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black54,
                                                      offset: Offset(0, 2),
                                                      blurRadius: 6,
                                                    ),
                                                  ],
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              )
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            right: 10,
                                            bottom: 0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16.0,
                                                    vertical: 12,
                                                  ),
                                              child: Text(
                                                'Blue Pepe ${index + 1} Shopify sellers lack time/resources to create professional social content and collect feedback from customers. Snap Tale auto-collects customer photos/reviews via WhatsApp and generates branded posts, solving their engagement gap without hiring staff.',
                                                style: GoogleFonts.aBeeZee(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  backgroundColor: Colors.yellow
                                                      .withValues(alpha: 0.4),
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black54,
                                                      offset: Offset(0, 2),
                                                      blurRadius: 10,
                                                    ),
                                                  ],
                                                ),
                                                textAlign: TextAlign.start,
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 10,
                                            child: Flex(
                                              direction: Axis.horizontal,
                                              children: [
                                                Text(
                                                  '24H',
                                                  style: GoogleFonts.aBeeZee(
                                                    fontSize: 15,
                                                    color: Colors.greenAccent,
                                                    fontStyle: FontStyle.italic,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black54,
                                                        offset: Offset(0, 2),
                                                        blurRadius: 6,
                                                      ),
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  '120%',
                                                  style: GoogleFonts.aBeeZee(
                                                    fontSize: 15,
                                                    color: Colors.greenAccent,
                                                    fontStyle: FontStyle.italic,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black54,
                                                        offset: Offset(0, 2),
                                                        blurRadius: 6,
                                                      ),
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final crypto = cryptoList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8,
                          ),
                          child: Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            color: Colors.lime[900],
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 26,
                                child: Icon(
                                  getCryptoIcon(crypto['label']),
                                  size: 52, // adjust the size as needed
                                ),
                              ),
                              title: Text(
                                crypto['name'],
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                crypto['label'],
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.grey[300],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '\$ ${crypto['price'].toStringAsFixed(0)}',
                                    style: GoogleFonts.aBeeZee(
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$12.4M MC',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }, childCount: cryptoList.length),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );

    // return SolanaWalletProvider.create(
    //   httpCluster: Cluster.devnet,
    //   identity: AppIdentity(
    //     uri: Uri.parse('https://my_dapp.com'),
    //     icon: Uri.parse('favicon.png'),
    //     name: 'My Dapp',
    //   ),
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text(
    //         'Solana Dapps Demo',
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 22,
    //           color: Colors.white,
    //         ),
    //       ),
    //       backgroundColor: Colors.green,
    //       elevation: 2,
    //     ),
    //     body: FutureBuilder(
    //       future: SolanaWalletProvider.initialize(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState != ConnectionState.done) {
    //           return const Center(child: CircularProgressIndicator());
    //         }

    //         final provider = SolanaWalletProvider.of(context);

    //         if (controller.solanaService == null) {
    //           controller.setupService(provider.connection);
    //         }

    //         return Container(
    //           color: Colors.green[50],
    //           width: double.infinity,
    //           child: Center(
    //             child: SingleChildScrollView(
    //               padding: const EdgeInsets.all(20.0),
    //               child: ConstrainedBox(
    //                 constraints: const BoxConstraints(maxWidth: 420),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.stretch,
    //                   children: [
    //                     Card(
    //                       elevation: 4,
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(16),
    //                       ),
    //                       margin: const EdgeInsets.only(bottom: 20),
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(20.0),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           children: [
    //                             const Text(
    //                               'Wallet',
    //                               style: TextStyle(
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 18,
    //                               ),
    //                             ),
    //                             const SizedBox(height: 8),
    //                             SolanaWalletButton(),
    //                             SizedBox(
    //                               height: 12,),
    //                               Obx((){
    //                                 return Text('Balance: ${controller.balance.value} SOL' );
    //                               }),
    //                             const SizedBox(height: 14),
    //                             Wrap(
    //                               spacing: 12,
    //                               runSpacing: 8,
    //                               alignment: WrapAlignment.center,
    //                               children: [
    //                                 CustomButton(
    //                                   'Connect',
    //                                   enabled: !provider.adapter.isAuthorized,
    //                                   onPressed:
    //                                       () => controller.connect(provider),
    //                                 ),
    //                                 CustomButton(
    //                                   'Disconnect',
    //                                   enabled: provider.adapter.isAuthorized,
    //                                   onPressed:
    //                                       () => controller.disconnect(provider),
    //                                 ),
    //                                 CustomButton(
    //                                   'Get Airdrop',
    //                                   enabled: provider.adapter.isAuthorized,
    //                                   onPressed:
    //                                       () => controller.getAirdrop(provider),
    //                                 ),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),

    //                     Card(
    //                       elevation: 3,
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(16),
    //                       ),
    //                       margin: const EdgeInsets.only(bottom: 20),
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(20.0),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.stretch,
    //                           children: [
    //                             const Text(
    //                               'Owner Control',
    //                               style: TextStyle(
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 18,
    //                               ),
    //                             ),
    //                             const SizedBox(height: 8),
    //                             Obx(
    //                               () => SelectableText(
    //                                 'Current Owner:\n${controller.ownerAddress.value}',
    //                                 style: const TextStyle(
    //                                   fontSize: 15,
    //                                   color: Colors.black87,
    //                                 ),
    //                                 textAlign: TextAlign.left,
    //                               ),
    //                             ),
    //                             const SizedBox(height: 10),
    //                             Row(
    //                               children: [
    //                                 Expanded(
    //                                   child: Obx(() {
    //                                     return CustomButton(
    //                                       'Fetch Owner',
    //                                       enabled:
    //                                           controller.serviceReady.value,
    //                                       onPressed:
    //                                           controller.serviceReady.value
    //                                               ? () => controller.fetchOwner(
    //                                                 provider,
    //                                               )
    //                                               : () {},
    //                                     );
    //                                   }),
    //                                 ),
    //                                 const SizedBox(width: 8),
    //                                 Expanded(
    //                                   child: CustomButton(
    //                                       'Change Owner',
    //                                       enabled:
    //                                           provider.adapter.isAuthorized,
    //                                       onPressed:
    //                                           provider.adapter.isAuthorized
    //                                               ? () =>
    //                                                   controller.changeOwner(
    //                                                     provider,
    //                                                   )
    //                                               : () {},

    //                                 )),
    //                               ],
    //                             ),
    //                             const SizedBox(height: 18),
    //                             TextField(
    //                               decoration: InputDecoration(
    //                                 labelText: 'New Owner Address',
    //                                 hintText: 'Enter wallet address',
    //                                 border: OutlineInputBorder(
    //                                   borderRadius: BorderRadius.circular(10),
    //                                 ),
    //                                 contentPadding: const EdgeInsets.symmetric(
    //                                   horizontal: 12,
    //                                   vertical: 10,
    //                                 ),
    //                               ),
    //                               onChanged: controller.updateNewOwnerAddress,
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),

    //                     Card(
    //                       elevation: 2,
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(16),
    //                       ),
    //                       margin: const EdgeInsets.only(bottom: 16),
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(20.0),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.stretch,
    //                           children: [
    //                             const Text(
    //                               'Wallet Methods',
    //                               style: TextStyle(
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 16,
    //                               ),
    //                             ),
    //                             const SizedBox(height: 14),
    //                             Wrap(
    //                               spacing: 12,
    //                               runSpacing: 8,
    //                               children: [
    //                                 CustomButton(
    //                                   'Sign Tx (1)',
    //                                   enabled: provider.adapter.isAuthorized,
    //                                   onPressed:
    //                                       () => controller.signTransactions(
    //                                         provider,
    //                                         1,
    //                                       ),
    //                                 ),
    //                                 CustomButton(
    //                                   'Sign Tx (3)',
    //                                   enabled: provider.adapter.isAuthorized,
    //                                   onPressed:
    //                                       () => controller.signTransactions(
    //                                         provider,
    //                                         3,
    //                                       ),
    //                                 ),
    //                                 CustomButton(
    //                                   'Sign & Send Tx (1)',
    //                                   enabled: provider.adapter.isAuthorized,
    //                                   onPressed:
    //                                       () => controller
    //                                           .signAndSendTransactions(
    //                                             provider,
    //                                             1,
    //                                           ),
    //                                 ),
    //                                 CustomButton(
    //                                   'Sign & Send Tx (3)',
    //                                   enabled: provider.adapter.isAuthorized,
    //                                   onPressed:
    //                                       () => controller
    //                                           .signAndSendTransactions(
    //                                             provider,
    //                                             3,
    //                                           ),
    //                                 ),
    //                                 CustomButton(
    //                                   'Sign Msg (1)',
    //                                   enabled: provider.adapter.isAuthorized,
    //                                   onPressed:
    //                                       () => controller.signMessages(
    //                                         provider,
    //                                         1,
    //                                       ),
    //                                 ),
    //                                 CustomButton(
    //                                   'Sign Msg (3)',
    //                                   enabled: provider.adapter.isAuthorized,
    //                                   onPressed:
    //                                       () => controller.signMessages(
    //                                         provider,
    //                                         3,
    //                                       ),
    //                                 ),
    //                                 CustomButton(
    //                                   'Refresh Balance',
    //                                   enabled: provider.adapter.isAuthorized,
    //                                   onPressed:
    //                                       () => controller.fetchBalance(provider),
    //                                 ),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),

    //                     Card(
    //                       color: Colors.green[100],
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(16),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(18.0),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.stretch,
    //                           children: [
    //                             const Text(
    //                               'Output / Status',
    //                               style: TextStyle(
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 16,
    //                               ),
    //                             ),
    //                             const SizedBox(height: 10),
    //                             Obx(
    //                               () => SelectableText(
    //                                 controller.status.value.isEmpty
    //                                     ? '-'
    //                                     : controller.status.value,
    //                                 style: TextStyle(
    //                                   color:
    //                                       controller.status.value.contains(
    //                                             "Error",
    //                                           )
    //                                           ? Colors.red[800]
    //                                           : Colors.green[900],
    //                                   fontWeight: FontWeight.w500,
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}

class _SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverSearchBarDelegate({required this.child});

  @override
  double get minExtent => 50.0;

  @override
  double get maxExtent => 50.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverSearchBarDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
