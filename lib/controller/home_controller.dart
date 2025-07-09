import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlaunch/service/solana_service.dart';
import 'package:solana_wallet_provider/solana_wallet_provider.dart';
import 'dart:convert';

class HomeController extends GetxController {
  var status = ''.obs;
  final ownerAddress = ''.obs;
  final newOwnerAddress = ''.obs;
  var balance = ''.obs;

  void updateStatus(String newStatus) {
    status.value = newStatus;
  }

  Future<void> connect(SolanaWalletProvider provider) async {
    if (!provider.adapter.isAuthorized) {
      await provider.connect(Get.context!);
      updateStatus('Connected');
    }
  }

  Future<void> disconnect(SolanaWalletProvider provider) async {
    if (provider.adapter.isAuthorized) {
      await provider.disconnect(Get.context!);
      updateStatus('Disconnected');
    }
  }

  Future<void> signTransactions(
    SolanaWalletProvider provider,
    int count,
  ) async {
    final String description = "Sign Transactions ($count)";
    try {
      updateStatus("Create $description...");
      final transfers = await _createTransfers(
        provider.connection,
        provider.adapter,
        count: count,
      );

      updateStatus("$description...");
      final result = await provider.signTransactions(
        Get.context!,
        transactions: transfers.map((t) => t.transaction).toList(),
      );

      updateStatus("Broadcast $description...");
      final signatures = await provider.connection.sendSignedTransactions(
        result.signedPayloads,
        eagerError: true,
      );

      updateStatus("Confirm $description...");
      await _confirmTransfers(provider.connection, signatures, transfers);
    } catch (e) {
      updateStatus("Error: $e");
    }
  }

  Future<void> signAndSendTransactions(
    SolanaWalletProvider provider,
    int count,
  ) async {
    final String description = "Sign And Send Transactions ($count)";
    try {
      updateStatus("Create $description...");
      final transfers = await _createTransfers(
        provider.connection,
        provider.adapter,
        count: count,
      );

      updateStatus("$description...");
      final result = await provider.signAndSendTransactions(
        Get.context!,
        transactions: transfers.map((t) => t.transaction).toList(),
      );

      updateStatus("Confirm $description...");
      await _confirmTransfers(
        provider.connection,
        result.signatures,
        transfers,
      );
    } catch (e) {
      updateStatus("Error: $e");
    }
  }

  Future<void> signMessages(SolanaWalletProvider provider, int count) async {
    final String description = "Sign Messages ($count)";
    try {
      updateStatus("Create $description...");
      final messages = List.generate(count, (index) => 'Sign message $index');

      updateStatus("$description...");
      final result = await provider.signMessages(
        Get.context!,
        messages: messages,
        addresses: [
          provider.adapter.encodeAccount(provider.adapter.connectedAccount!),
        ],
      );

      updateStatus("Signed Messages:\n${result.signedPayloads.join('\n')}");
    } catch (e) {
      updateStatus("Error: $e");
    }
  }

  Future<void> getAirdrop(SolanaWalletProvider provider) async {
    try {
      updateStatus("request airdrop5 sol");
      final currentOwner = Pubkey.fromBase58(
        base58.encode(
          base64.decode(provider.adapter.connectedAccount!.address),
        ),
      );

      provider.connection.requestAndConfirmAirdrop(
        currentOwner,
        solToLamports(5).toInt(),
      ).then((_) async {
        final balance = await provider.connection.getBalance(currentOwner);
        updateStatus("Balance: $balance");
      }).catchError((e) {
        updateStatus("Error: $e");
      });
    } catch (e) {
      updateStatus(e.toString());
    }
  }

  Future<void> _airdrop(Connection connection, Pubkey wallet) async {
    if (connection.httpCluster != Cluster.mainnet) {
      updateStatus("Requesting airdrop...");
      await connection.requestAndConfirmAirdrop(
        wallet,
        solToLamports(5).toInt(),
      );
    }
  }

  Future<List<TransferData>> _createTransfers(
    Connection connection,
    SolanaWalletAdapter adapter, {
    required int count,
  }) async {
    updateStatus("Pending...");
    final wallet = Pubkey.tryFromBase64(adapter.connectedAccount?.address);
    if (wallet == null) throw 'Wallet not connected';

    updateStatus("Checking balance...");
    final balance = await connection.getBalance(wallet);
    if (balance < lamportsPerSol) await _airdrop(connection, wallet);

    updateStatus("Creating transaction...");
    final latestBlockhash = await connection.getLatestBlockhash();
    final List<TransferData> txs = [];

    for (int i = 0; i < count; ++i) {
      final receiver = Keypair.generateSync();
      final lamports = solToLamports(0.01);
      final transaction = Transaction.v0(
        payer: wallet,
        recentBlockhash: latestBlockhash.blockhash,
        instructions: [
          SystemProgram.transfer(
            fromPubkey: wallet,
            toPubkey: receiver.pubkey,
            lamports: lamports,
          ),
        ],
      );
      txs.add(
        TransferData(
          transaction: transaction,
          receiver: receiver,
          lamports: lamports,
        ),
      );
    }
    return txs;
  }

  Future<void> _confirmTransfers(
    Connection connection,
    List<String?> signatures,
    List<TransferData> transfers,
  ) async {
    updateStatus("Confirming transaction signature...");
    await Future.wait([
      for (final sig in signatures)
        connection.confirmTransaction(base58To64Decode(sig!)),
    ], eagerError: true);

    updateStatus("Checking balance...");
    final receiverBalances = await Future.wait([
      for (final t in transfers) connection.getBalance(t.receiver.pubkey),
    ], eagerError: true);

    final List<String> results = [];
    for (int i = 0; i < receiverBalances.length; ++i) {
      final transfer = transfers[i];
      final balance = receiverBalances[i].toBigInt();
      if (balance != transfer.lamports) {
        throw Exception('Post transaction balance mismatch.');
      }
      results.add(
        "Transfer: Address ${transfer.receiver.pubkey} received $balance SOL",
      );
    }

    updateStatus(
      "Success!\n\nSignatures: $signatures\n\n${results.join('\n')}\n",
    );
  }

  final RxBool serviceReady = false.obs;

  SolanaService? solanaService;

  void setupService(Connection connection) {
    if (solanaService == null) {
      solanaService = SolanaService(connection);
      serviceReady.value = true;
    }
  }

  void updateNewOwnerAddress(String address) {
    newOwnerAddress.value = address;
  }

  Future<void> fetchOwner(SolanaWalletProvider provider) async {
    if (solanaService == null) {
      status.value = 'Service not initialized';
      return;
    }
    try {
      status.value = 'Fetching owner...';
      // final owner = await solanaService!.getOwner(provider);
      final owner = await solanaService?.fetchOwnerRaw();
      // ownerAddress.value = owner?.toBase58() ?? 'Not Found';
      status.value = owner as String;
      ownerAddress.value = owner;
    } catch (e) {
      status.value = 'Error fetching owner: $e';
    }
  }

  Future<void> changeOwner(SolanaWalletProvider provider) async {
    try {
      //Bs6wVhKdTh7HMkomXo8aGDWhkX9F9udd8YeM3ZVj5fAD
      status.value = 'Changing owner...';
      await solanaService?.changeOwner(provider, newOwnerAddress.value);
      status.value = 'Owner changed successfully';
      await fetchOwner(provider);
    } catch (e) {
      status.value = 'Error changing owner: $e';
    }
  }

  // Future<void> initializeOwner(SolanaWalletProvider provider) async {
  //   if (solanaService == null) {
  //     status.value = 'Service not initialized';
  //     return;
  //   }
  //   try {
  //     status.value = 'Initializing global state...';
  //     await solanaService!.initialize(provider);
  //     status.value = 'Initialized successfully!';
  //     await fetchOwner(provider);
  //   } catch (e) {
  //     status.value = 'Error initializing: $e';
  //   }
  // }

  Future<void> fetchBalance(SolanaWalletProvider provider) async {
    if (solanaService == null) {
      status.value = 'Service not initialized';
      return;
    }
    try {
      status.value = 'Fetching balance...';
      final balancex = await solanaService!.getBalance(provider);
      status.value = 'Balance: $balance';
      balance.value = balancex.toString();
    } catch (e) {
      status.value = 'Error fetching balance: $e';
    }
  }
}

class TransferData {
  const TransferData({
    required this.transaction,
    required this.receiver,
    required this.lamports,
  });

  final Transaction transaction;
  final Keypair receiver;
  final BigInt lamports;
}
