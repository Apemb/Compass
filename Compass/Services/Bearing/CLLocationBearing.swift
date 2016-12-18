//
//  CLLocationBearing.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import CoreLocation

enum BearingUnit {
  case radian
  case degree
}

extension CLLocation {

  private func degreesToRadians(degrees: Double ) -> Double {
    return degrees * Double.pi / 180
  }

  private func radiansToDegrees(radians: Double) -> Double {
    return radians * 180 / Double.pi
  }

  private func bearingInRadian(to destinationLocation: CLLocation) -> Double {

    let lat1 = degreesToRadians(degrees: self.coordinate.latitude)
    let lon1 = degreesToRadians(degrees: self.coordinate.longitude)

    let lat2 = degreesToRadians(degrees: destinationLocation.coordinate.latitude)
    let lon2 = degreesToRadians(degrees: destinationLocation.coordinate.longitude)

    let dLon = lon2 - lon1

    let y = sin(dLon) * cos(lat2)
    let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
    let radiansBearing = atan2(y, x)

    let positiveRadiansBearing = radiansBearing < 0.0 ? radiansBearing + 2 * Double.pi : radiansBearing
    return positiveRadiansBearing
  }

  private func bearingInDegrees(to destinationLocation: CLLocation) -> Double {
    return   radiansToDegrees(radians: bearingInRadian(to: destinationLocation))
  }

  func bearing(to destination: CLLocation, in unit: BearingUnit) -> Double {
    switch unit {
    case .degree:
      return bearingInDegrees(to: destination)
    case .radian:
      return bearingInRadian(to: destination)
    }
  }
}
