//
//  LocationService.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import CoreLocation

protocol LocationServiceProtocol {
  var delegate: LocationServiceProtocolDelegate { get set }
}

protocol LocationServiceProtocolDelegate {
  func locationServiceDidUpdateLocation(to location: CLLocation)
}

class LocationService: NSObject, LocationServiceProtocol {

  let locationManager: CLLocationManager
  var delegate: LocationServiceProtocolDelegate

  init(delegate: LocationServiceProtocolDelegate) {
    locationManager = CLLocationManager()
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

    self.delegate = delegate
    super.init()
  }
}

extension LocationService: CLLocationManagerDelegate {

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let lastLocation = locations.last else {
      return
    }
    delegate.locationServiceDidUpdateLocation(to: lastLocation)
  }
}
