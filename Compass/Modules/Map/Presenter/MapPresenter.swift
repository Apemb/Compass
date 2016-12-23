//
//  MapPresenter.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import MapKit

protocol MapPresenterDelegate {
  func centerMapOnCurrentLocation()
  func addDestination(_ destination: MapDestinationAnnotation)
}

struct MapPresenter {

  let delegate: MapPresenterDelegate
  let interactor: MapInteractorProtocol

  var mapDistance: Double {
    return 1000
  }

  var title: String {
    return L10n.mapScreenTitle.string
  }

  var bottomBarLabelText: String {
    return L10n.mapSelectDestination.string
  }

  // *********************************************************************
  // MARK: - Permissions 
  func locationPermissionAuthorized() {
    delegate.centerMapOnCurrentLocation()
  }

  func locationPermissionCanceled() {}

  // *********************************************************************
  // MARK: - Action Management
  func localizeMeButtonTappedWithLocationAuthorized(_ authorized: Bool) {
    if authorized == true {
      delegate.centerMapOnCurrentLocation()
    }
  }

  func handleLongTap(at coordinate: CLLocationCoordinate2D) {
    delegate.addDestination(MapDestinationAnnotation(coordinate: coordinate))

    // TODO: test
    interactor.setDestination(to: coordinate)
  }
}
