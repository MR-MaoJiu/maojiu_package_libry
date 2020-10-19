import Flutter
import UIKit

public class SwiftMaojiuPackageLibryPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "maojiu_package_libry", binaryMessenger: registrar.messenger())
    let instance = SwiftMaojiuPackageLibryPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
