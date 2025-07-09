// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:overlaunch/controller/auth_controller.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ctl = Get.find<AuthController>();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Solana Wallet Login')),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               /// Wallet Address
//               Obx(() => Text(
//                     'Wallet Address:\n${ctl.walletAddress.value.isEmpty ? '-' : ctl.walletAddress.value}',
//                     textAlign: TextAlign.center,
//                   )),
//               const SizedBox(height: 16),

//               /// Wallet Balance
//               Obx(() => Text(
//                     'Balance: ${ctl.balance.value.isEmpty ? '-' : ctl.balance.value}',
//                     style: const TextStyle(fontSize: 16),
//                   )),
//               const SizedBox(height: 24),

//               /// Connect Wallet Button
//               ElevatedButton(
//                 onPressed: ctl.authorize,
//                 child: const Text('Connect Wallet'),
//               ),
//               const SizedBox(height: 12),

//               /// Refresh Balance Button
//               ElevatedButton(
//                 onPressed: () => ctl.getBalance(ctl.walletAddress.value),
//                 child: const Text('Refresh Balance'),
//               ),
//               const SizedBox(height: 12),

//               /// Sign Login Message Button
//               ElevatedButton(
//                 onPressed: ctl.signLoginMessage,
//                 child: const Text('Sign Login Message'),
//               ),
//               const SizedBox(height: 24),

//               /// Signature Result
//               Obx(() => Text(
//                     'Signature:\n${ctl.signature.value.isEmpty ? '-' : ctl.signature.value}',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 14),
//                   )),
//               const SizedBox(height: 24),

//               /// Disconnect Wallet Button
//               ElevatedButton(
//                 onPressed: ctl.deauthorize,
//                 child: const Text('Disconnect Wallet'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
