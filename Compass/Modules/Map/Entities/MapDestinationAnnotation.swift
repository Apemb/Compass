//
//  MapDestinationAnnotation.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import MapKit

class MapDestinationAnnotation: NSObject, MKAnnotation {

  let coordinate: CLLocationCoordinate2D

  init(coordinate: CLLocationCoordinate2D) {
    self.coordinate = coordinate
  }

}
