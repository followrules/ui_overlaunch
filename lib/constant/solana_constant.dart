import 'dart:typed_data';

class SolanaConstants {
  static const String programId = 'BWrSo4boSipbo4MvnXF4TKnZznPeqgrF4YKB9N9UyNyV';
  static final seed = Uint8List.fromList("global-state".codeUnits);

  static const List<int> pdaSeed = [
    103, 108, 111, 98, 97, 108, 45, 115, 116, 97, 116, 101
  ]; // 'global-state'
}
