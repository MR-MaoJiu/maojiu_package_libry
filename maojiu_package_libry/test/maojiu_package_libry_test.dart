import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maojiu_package_libry/maojiu_package_libry.dart';

void main() {
  const MethodChannel channel = MethodChannel('maojiu_package_libry');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await MaojiuPackageLibry.platformVersion, '42');
  });
}
