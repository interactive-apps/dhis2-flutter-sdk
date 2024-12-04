import 'dart:math';

String randomStrings({int length = 5}) {
  const String _chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final Random _random = Random.secure();

  return List.generate(
      length, (index) => _chars[_random.nextInt(_chars.length)]).join();
}
