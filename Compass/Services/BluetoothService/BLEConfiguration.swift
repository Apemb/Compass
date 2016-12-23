//
//  BLEService.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import CoreBluetooth

struct BLEConfiguration {

  let deviceName: String
//  let nameService: BLENameService
  let bearingService: BLEBearingService

  var services: [BLEService] {
    return [bearingService]
  }
  var servicesUUID: [CBUUID] {
    return services.map { $0.uuid }
  }
}

//struct BLENameService: BLEService {
//
//  let uuid: CBUUID
//  let nameCharacteristic: BLECharacteristic
//
//  var characteristics: [BLECharacteristic] {
//    return [nameCharacteristic]
//  }
//}

struct BLEBearingService: BLEService {

  let uuid: CBUUID
  let bearingWriteCharacteristic: BLECharacteristic
  let distanceWriteCharacteristic: BLECharacteristic

  var characteristics: [BLECharacteristic] {
    return [bearingWriteCharacteristic, distanceWriteCharacteristic]
  }
}

protocol BLEService {
  var uuid: CBUUID { get }
  var characteristics: [BLECharacteristic] { get }
}

struct BLECharacteristic {
  let uuid: CBUUID
  let property: CBCharacteristicProperties
}
