//
//  BleDevice.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import CoreBluetooth

protocol BleDeviceManagerProtocol {

  func sendBearingToDevice(_ bearing: Double, completionHandler: (Error?) -> Void)

}

protocol BleDeviceManagerDelegate {

  func didDiscoverBearingSerivce()
  func deviceDisconnected()
}

class BleDeviceManager: NSObject, BleDeviceManagerProtocol {

  var delegate: BleDeviceManagerDelegate?
  let peripheral: CBPeripheral

  init?(peripheral: CBPeripheral,
        bleConfiguration: BLEConfiguration) {
    // Check if the device corresponds to the Configuration
    guard peripheral.name == bleConfiguration.deviceName else {
      return nil
    }

    self.peripheral = peripheral
    super.init()

    self.peripheral.delegate = self
  }

  func sendBearingToDevice(_ bearing: Double,
                           completionHandler: (Error?) -> Void) {

  }
}

extension BleDeviceManager: CBPeripheralDelegate {

  func peripheral(_ peripheral: CBPeripheral,
                  didDiscoverServices error: Error?) {
  }

  func peripheral(_ peripheral: CBPeripheral,
                  didDiscoverCharacteristicsFor service: CBService,
                  error: Error?) {
  }

  func peripheral(_ peripheral: CBPeripheral,
                  didUpdateValueFor characteristic: CBCharacteristic,
                  error: Error?) {
  }

  func peripheral(_ peripheral: CBPeripheral,
                  didUpdateNotificationStateFor characteristic: CBCharacteristic,
                  error: Error?) {
  }

}
