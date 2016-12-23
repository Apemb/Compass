//
//  MapInteractor.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import CoreLocation

protocol MapInteractorDelegate {

}

protocol MapInteractorProtocol {

  var destination: CLLocation? { get }
  var bearingToDestination: Double? { get }
  func setDestination(to destination: CLLocationCoordinate2D)
}

class MapInteractor: MapInteractorProtocol {

  let bluetoothService: BluetoothServiceProtocol

  //  let delegate: MapInteractorDelegate
  var destination: CLLocation?
  var bearingToDestination: Double?

  init(bluetoothService: BluetoothServiceProtocol) {
    self.bluetoothService = bluetoothService
    self.bluetoothService.delegate = self

    bluetoothService.startScanning()
  }

  // TODO: TEST
  func setDestination(to destination: CLLocationCoordinate2D) {
    print("wrote: \(destination.latitude)")
    bluetoothService.sendBearingToDevice(destination.latitude) { error in
      print("Wrote to device with error: \(error)")
    }
  }
}

extension MapInteractor: BluetoothServiceDelegate {

  func didSuccessfullyConnectToDevice() {}

  func didFailToConnectToDevice(with error: Error?) {
    print("Error:\(error)")
    bluetoothService.startScanning()
  }

  func didDisconnectFromDevice(with error: Error?) {
    print("Error:\(error)")
    bluetoothService.startScanning()
  }

}
