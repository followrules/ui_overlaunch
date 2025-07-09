// import 'dart:convert';
// import 'package:bs58/bs58.dart';
// import 'package:get/get.dart';
// import 'package:solana/solana.dart';
// import 'package:solana_wallet_adapter/solana_wallet_adapter.dart';

// class AuthController extends GetxController {
//   final walletAddress = ''.obs; // ✅ Ganti dari result ke walletAddress biar lebih jelas
//   final wallet64Address = ''.obs; 
//   final balance = ''.obs;
//   final isAuth = false.obs;
//   final signature = ''.obs;

//   final rpcClient = RpcClient('https://api.devnet.solana.com');

//   final adapter = SolanaWalletAdapter(
//     const AppIdentity(),
//     cluster: Cluster.devnet,
//   );

//   Future<void> authorize() async {
//     try {
//       await adapter.authorize();

//       // Ambil address base64 dan convert ke base58
//       wallet64Address.value = adapter.connectedAccount?.address ?? '';
//       final addressBytes = base64Decode(wallet64Address.value);
//       final base58Address = base58.encode(addressBytes);

//       walletAddress.value = base58Address;
//       isAuth.value = adapter.isAuthorized;

//       await getBalance(base58Address);
//     } catch (e) {
//       walletAddress.value = 'Error: $e';
//     }
//   }

//   Future<void> deauthorize() async {
//     try {
//       await adapter.deauthorize();
//       walletAddress.value = 'Wallet disconnected.';
//       balance.value = '';
//       isAuth.value = false;
//       signature.value = '';
//     } catch (e) {
//       walletAddress.value = 'Error: $e';
//     }
//   }

//   Future<void> getBalance(String walletAddress) async {
//     try {
//       if (walletAddress.isEmpty) return;

//       final lamports = await rpcClient.getBalance(walletAddress);
//       final sol = lamports.value / lamportsPerSol;

//       balance.value = sol.toStringAsFixed(6) + ' SOL';
//     } catch (e) {
//       balance.value = 'Error: $e';
//     }
//   }

// Future<void> signLoginMessage() async {
//     try {
//       if (walletAddress.value.isEmpty) {
//         signature.value = 'Please connect wallet first.';
//         return;
//       }

//       final message = 'Login to MyApp at ${DateTime.now().toIso8601String()}';

//       final encodedMessage = adapter.encodeMessage(message);
//       final wallet = wallet64Address.value;
//       // Gunakan base64 address langsung sesuai Mobile Wallet Adapter Spec
//       // final encodedAccount = adapter.connectedAccount!.address;

//       final result = await adapter.signMessages(
//         [encodedMessage], 
//         addresses: [wallet],
//       );

//       signature.value = result.signedPayloads.first;
//     } catch (e) {
//       if (e.toString().toLowerCase().contains('declined')) {
//         signature.value = 'Sign Declined by User';
//       } else {
//         signature.value = 'Sign Error: $e';
//       }
//     }
//   }
// }
