//
//  BluetoothService.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import CoreBluetooth

protocol BluetoothServiceProtocol {

  var delegate: BluetoothServiceDelegate? { get set }

  func startScanning()
  func stopScanning()
  func disconnect()

  func sendBearingToDevice(_ bearing: Double, completionHandler: (Error?) -> Void)

}

protocol BluetoothServiceDelegate {

  func didSuccessfullyConnectToDevice()
  func didFailToConnectToDevice(with error: Error?)
  func didDisconnectFromDevice(with error: Error?)

}

class BluetoothService: NSObject, BluetoothServiceProtocol {

  var bleManager: CBCentralManager!
  let bleConfiguration: BLEConfiguration

  var dataBuffer: NSMutableData
  var peripheral: CBPeripheral?
  var delegate: BluetoothServiceDelegate?

  var bearingWriteCharacteristic: CBCharacteristic?

  init(bleConfiguration: BLEConfiguration) {
    self.bleConfiguration = bleConfiguration

    dataBuffer = NSMutableData()
    super.init()

    bleManager = CBCentralManager(delegate: self,
                                  queue: DispatchQueue.global(qos: .background))
  }

  func startScanning() {
    guard !bleManager.isScanning else {
      print("Central Manager is already scanning!!")
      return
    }
    bleManager.scanForPeripherals(withServices: nil, options: nil)
    //        centralManager.scanForPeripherals(withServices: [bleConfiguration.bearingService.uuid], options:nil)
    print("Scanning Started!")
  }

  func stopScanning() {
    bleManager.stopScan()
  }

  func disconnect() {
    guard let peripheral = self.peripheral else {
      return
    }

    if peripheral.state != .connected {
      self.peripheral = nil
      return
    }

    guard let services = peripheral.services else {
      bleManager.cancelPeripheralConnection(peripheral)
      return
    }

    for service in services {
      guard let characteristics = service.characteristics else {
        continue
      }

      for characteristic in characteristics {
        if characteristic.isNotifying {
          peripheral.setNotifyValue(false, for: characteristic)
          return
        }
      }
    }

    bleManager.cancelPeripheralConnection(peripheral)
  }

  func sendBearingToDevice(_ bearing: Double, completionHandler: (Error?) -> Void) {

    guard let peripheral = peripheral,
      let bearingWriteCharacteristic = bearingWriteCharacteristic else {
        let error = NSError(domain: "no peri or char", code: 42, userInfo: nil)
        completionHandler(error)
        return
    }

    let bearingString = NSString(format: "%.2f", bearing)
    let stringData = "{b}\(bearingString){EOM}"
    print("send \(stringData)")
    let data = stringData.data(using: .utf8)!
    peripheral.writeValue(data, for: bearingWriteCharacteristic,
                          type: CBCharacteristicWriteType.withResponse)
    completionHandler(nil)
  }
}

extension BluetoothService: CBCentralManagerDelegate {
  // *********************************************************************
  // MARK: - CBCentralManagerDelegate

  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
    case .poweredOn:
      startScanning()

    default:
      // TODO: Ask permission ? :-)
      print("ERROR on Bluetooth state: \(central.state)")
    }
  }

  func centralManager(_ central: CBCentralManager,
                      didDiscover peripheral: CBPeripheral,
                      advertisementData: [String : Any],
                      rssi RSSI: NSNumber) {
    print("Discovered \(peripheral.name) at \(RSSI)")

    guard self.peripheral != peripheral else {
      return
    }
    guard peripheral.name == bleConfiguration.deviceName else {
      return
    }

    self.peripheral = peripheral
    print("Connecting to peripheral: \(peripheral)")
    bleManager.connect(peripheral, options: nil)
  }

  func centralManager(_ central: CBCentralManager,
                      didConnect peripheral: CBPeripheral) {
    print("Connected peripheral: \(peripheral)")

    bleManager.stopScan()
    dataBuffer.length = 0
    peripheral.delegate = self

    peripheral.discoverServices(nil)
    //TODO: Don't search all services, only the bleConfiguration.services
    delegate?.didSuccessfullyConnectToDevice()
  }

  func centralManager(_ central: CBCentralManager,
                      didFailToConnect peripheral: CBPeripheral,
                      error: Error?) {
    print("Failed to connect to \(peripheral) (\(error?.localizedDescription))")
    self.disconnect()
    delegate?.didFailToConnectToDevice(with: error)
  }

  func centralManager(_ central: CBCentralManager,
                      didDisconnectPeripheral peripheral: CBPeripheral,
                      error: Error?) {
    print("Disconnected peripheral: \(peripheral)")
    self.peripheral = nil
    delegate?.didDisconnectFromDevice(with: error)
  }
}

extension BluetoothService: CBPeripheralDelegate {
  // *********************************************************************
  // MARK: - CBPeripheralDelegate

  func peripheral(_ peripheral: CBPeripheral,
                  didDiscoverServices error: Error?) {
    guard error == nil else {
      print("Error discovering services: \(error?.localizedDescription)")
      disconnect()
      return
    }
    guard let services = peripheral.services else {
      print("Error discovering services: no services discovered")
      disconnect()
      return
    }

    for service in services {
      // TODO: do something better about not discovering everything
      // Like matching the bleConfiguration maybe
      peripheral.discoverCharacteristics(nil, for: service)
    }
  }

  func peripheral(_ peripheral: CBPeripheral,
                  didDiscoverCharacteristicsFor service: CBService,
                  error: Error?) {
    guard error == nil else {
      print("Error discovering characteristics: \(error?.localizedDescription)")
      disconnect()
      return
    }
    guard let characteristics = service.characteristics else {
      print("Error discovering characteristics: no characteristics discovered")
      disconnect()
      return
    }

    for characteristic in characteristics {
      print("characteristics discovered: \(characteristic.uuid) for serivce: \(characteristic.service.uuid)")
      if characteristic.uuid == bleConfiguration.bearingService.bearingWriteCharacteristic.uuid {
        bearingWriteCharacteristic = characteristic
      }
    }

  }

  func peripheral(_ peripheral: CBPeripheral,
                  didUpdateValueFor characteristic: CBCharacteristic,
                  error: Error?) {
  }

  func peripheral(_ peripheral: CBPeripheral,
                  didUpdateNotificationStateFor characteristic: CBCharacteristic,
                  error: Error?) {
  }

  func peripheral(_ peripheral: CBPeripheral,
                  didWriteValueFor descriptor: CBDescriptor,
                  error: Error?) {
    print("wrote to \(descriptor.characteristic) with error: \(error)")
  }
}
