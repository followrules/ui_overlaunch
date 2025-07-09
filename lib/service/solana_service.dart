import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:overlaunch/constant/solana_constant.dart';
import 'package:solana/solana.dart';
import 'package:solana_wallet_provider/solana_wallet_provider.dart';
import 'package:http/http.dart' as http;

class SolanaService {
  final Connection connection;

  SolanaService(this.connection);

  /// Dapatkan PDA untuk global_state
  Future<Pubkey> getGlobalStatePDA() async {
    // Perhatikan pemakaian Uint8List.fromList dan .codeUnits!
    final seed = Uint8List.fromList("global-state".codeUnits);
    final programId = Pubkey.fromBase58(
      "BWrSo4boSipbo4MvnXF4TKnZznPeqgrF4YKB9N9UyNyV",
    );
    final pdaResult = await Pubkey.findProgramAddress([seed], programId);
    print('Flutter PDA: ${pdaResult.pubkey.toBase58()}');
    return pdaResult.pubkey;
  }

  /// Fetch current owner dari account global_state PDA
  Future<Pubkey?> getOwner(SolanaWalletProvider provider) async {
    final pda = await getGlobalStatePDA();
    final accountInfo = await provider.connection.getAccountInfo(pda);
    print('Flutter PDA: ${pda.toBase58()}');
    if (accountInfo == null) {
      print('Flutter: Account not found!');
      return null;
    }
    final ownerBytes = accountInfo.data.sublist(8, 40);
    final owner = Pubkey(ownerBytes);
    print('Flutter Owner address: ${owner.toBase58()}');
    return owner;
  }

  Future<dynamic> fetchOwnerRaw() async {
    // final pda = '872kRsqjwSo5iGNwpJrcs1L5pGAE3XjuuWpg45s5wM8E'; // dari hasil JS
    final pda = await getGlobalStatePDA();
    final url = 'https://api.devnet.solana.com';
    final body = jsonEncode({
      "jsonrpc": "2.0",
      "id": 1,
      "method": "getAccountInfo",
      "params": [
        pda.toBase58(),
        {"encoding": "base64"},
      ],
    });
    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {"Content-Type": "application/json"},
    );
    final data = jsonDecode(response.body);
    final value = data['result']['value'];
    if (value == null) {
      return "Not initialized";
    }
    final base64Data = value['data'][0];
    final bytes = base64.decode(base64Data);
    final ownerBytes = bytes.sublist(8, 40);
    final base58String = base58.encode(ownerBytes);
    final owner = Ed25519HDPublicKey.fromBase58(base58String);
    return owner.toBase58();
  }

  /// Change owner (hanya owner sekarang yang bisa memanggil)
  Future<SignAndSendTransactionsResult?> changeOwner(
    SolanaWalletProvider provider,
    String newOwnerAddress,
  ) async {
    final pda = await getGlobalStatePDA();
    final newOwner = Pubkey.fromBase58(newOwnerAddress);
    final currentOwner = Pubkey.fromBase58(
      base58.encode(base64.decode(provider.adapter.connectedAccount!.address)),
    );

    final instruction = TransactionInstruction(
      programId: Pubkey.fromBase58(SolanaConstants.programId),
      keys: [
        AccountMeta(pda, isSigner: false, isWritable: true),
        AccountMeta(currentOwner, isSigner: true, isWritable: true),
      ],
      data: Uint8List.fromList([
        109,
        40,
        40,
        90,
        224,
        120,
        193,
        184,
        ...newOwner.toBytes(),
      ]),
    );

    final transaction = await provider.signAndSendTransactions(
      Get.context!,
      transactions: [
        Transaction.v0(
          payer: currentOwner,
          recentBlockhash: (await connection.getLatestBlockhash()).blockhash,
          instructions: [instruction],
        ),
      ],
    );

    if (transaction == null) return null;
    return transaction;
  }

  // /// Initialize global_state PDA (harus dari deployer/owner pertama)
  Future<void> initialize(SolanaWalletProvider provider) async {
    final pda = await getGlobalStatePDA();
    final initializer = Pubkey.fromBase58(
      provider.adapter.connectedAccount!.address,
    );

    final instruction = TransactionInstruction(
      programId: Pubkey.fromBase58(SolanaConstants.programId),
      keys: [
        AccountMeta(pda, isSigner: false, isWritable: true),
        AccountMeta(initializer, isSigner: true, isWritable: true),
        AccountMeta(
          Pubkey.fromBase58('11111111111111111111111111111111'),
          isSigner: false,
          isWritable: false,
        ), // System Program
      ],
      data: Uint8List.fromList([
        175, 175, 109, 31, 13, 152, 155, 237, // discriminator initialize
      ]),
    );

    final latestBlockhash = await connection.getLatestBlockhash();
    final transaction = Transaction.v0(
      payer: initializer,
      recentBlockhash: latestBlockhash.blockhash,
      instructions: [instruction],
    );

    await provider.signAndSendTransactions(
      Get.context!,
      transactions: [transaction],
    );
  }

  Future<double> getBalance(SolanaWalletProvider provider) async {
    final currentOwner = Pubkey.fromBase58(
      base58.encode(base64.decode(provider.adapter.connectedAccount!.address)),
    );
    final lamport = await connection.getBalance(currentOwner);
    return lamport / 1e9;
  }
}
