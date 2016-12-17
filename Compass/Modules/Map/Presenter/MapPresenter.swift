//
//  MapPresenter.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import Foundation

protocol MapPresenterDelegate {
  func centerMapOnCurrentLocation()
}

struct MapPresenter {

  let delegate: MapPresenterDelegate

  var mapDistance: Double {
    return 1000
  }

  var title: String {
    return L10n.mapScreenTitle.string
  }

  // *********************************************************************
  // MARK: - Permissions 
  func locationPermissionAuthorized() {
    delegate.centerMapOnCurrentLocation()
  }

  func locationPermissionCanceled() {

  }

  // *********************************************************************
  // MARK: - Action Management
  func localizeMeButtonTappedWithLocationAuthorized(_ authorized: Bool) {
    if authorized == true {
      delegate.centerMapOnCurrentLocation()
    }
  }
}
