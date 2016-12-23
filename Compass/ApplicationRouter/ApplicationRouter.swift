//
//  ApplicationRouter.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import UIKit
import CoreBluetooth

class ApplicationRouter {

  var window: UIWindow
  var navigationController: UINavigationController!
  var bluetoothService: BluetoothService!

  var bleConfiguration: BLEConfiguration {
    let bearingWriteCharacteristic = BLECharacteristic(uuid: CBUUID(string: "2F016955-E675-49A6-9176-111E2A1CF333"),
                                                       property: CBCharacteristicProperties.write )
    let bearingService = BLEBearingService(uuid: CBUUID(string: "E71EE188-279F-4ED6-8055-12D77BFD900C"),
                                           bearingWriteCharacteristic: bearingWriteCharacteristic,
                                           distanceWriteCharacteristic: bearingWriteCharacteristic)

    return BLEConfiguration(deviceName: "Adafruit Bluefruit LE",
                            bearingService: bearingService)
  }

  init(window: UIWindow) {
    self.window = window

    let splashModule = SplashModule(delegate: self)
    let splashViewController = splashModule.firstViewController
    window.rootViewController = splashViewController

    // TODO: Move init to splash screen ?
    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
      self.navigationController = UINavigationController()
      self.navigationController.isNavigationBarHidden = false
      self.bluetoothService = BluetoothService(bleConfiguration: self.bleConfiguration)
    }
  }

  func fadeToMapView() {
    let module = MapModule(bluetoothService: bluetoothService)
    let mapController = module.firstViewController

    navigationController.pushViewController(mapController, animated: false)
    navigationController.modalPresentationStyle = .custom
    navigationController.modalTransitionStyle = .crossDissolve

    window.rootViewController?.present(navigationController, animated: true, completion: nil)
  }

  func pushViewController(_ viewController: UIViewController) {
    navigationController.pushViewController(viewController, animated: true)
  }

  // swiftlint:disable cyclomatic_complexity
  // swiftlint:disable:next function_body_length
  func presentModule(_ moduleType: ModuleType) {
    switch moduleType {
    case .splash:
      let module = SplashModule(delegate: self)
      pushViewController(module.firstViewController)

    case .map:
      let module = MapModule(bluetoothService: bluetoothService)
      pushViewController(module.firstViewController)
    }
  }
  // swiftlint:enable cyclomatic_complexity
}
