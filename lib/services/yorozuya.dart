part of 'services.dart';

/// Yorozuya 万事屋 よろずや
///
/// Does other stuffs like generating uuid, do whatever shits here and there
/// that others need
class _YorozuyaService {
  Future<void> _init() async {
  }

  final Uuid _uuidGenerator = const Uuid();

  String uuid() {
    return _uuidGenerator.v4();
  }
}
