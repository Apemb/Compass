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

//  let delegate: MapInteractorDelegate
  var destination: CLLocation?
  var bearingToDestination: Double?

  init() {}

  func setDestination(to destination: CLLocationCoordinate2D) {

  }
}
