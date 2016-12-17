//
//  MapViewController.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import MapKit
import PermissionScope

class MapViewController: UIViewController {

  // *********************************************************************
  // MARK: - IBOutlets
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var localizeMeButton: UIButton!

  // *********************************************************************
  // MARK: - Properties
//  var delegate: SplashViewControllerDelegate?
  var presenter: MapPresenter!

  var userLocation: CLLocation?

  fileprivate let permissionScope = PermissionScope()
  fileprivate var permissionAlreadyRequested = false
  fileprivate var userLocationUpdateNeeded = false
  fileprivate var permissionCanceled = false

  // *********************************************************************
  // MARK: - UIViewController Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = presenter.title

    mapView.showsUserLocation = true
    mapView.delegate = self

    permissionAlreadyRequested = false
    permissionScope.addPermission(LocationAlwaysPermission(),
                                  message: "Compass needs that")
  }

  // *********************************************************************
  // MARK: - IBActions
  @IBAction func localizeMeButtonTapped() {
    let authorized = permissionScope.statusLocationInUse() == .authorized
    permissionCanceled = false
    permissionAlreadyRequested = false
    presenter.localizeMeButtonTappedWithLocationAuthorized(authorized)
  }

  // *********************************************************************
  // MARK: - Permissions
  func requestLocationPermission() {
    guard !permissionCanceled else {
      return
    }

    permissionScope.show({ finished, results in
      if let authorization = results.first as PermissionResult? {
        self.manageLocationResult(authorization)
      }
    }) { _ in
      self.permissionCanceled = true
      self.presenter.locationPermissionCanceled()
    }
  }

  private func manageLocationResult(_ authorization: PermissionResult?) {
    if let status = authorization?.status,
      status == PermissionStatus.authorized {
      presenter.locationPermissionAuthorized()
    } else {
      presenter.locationPermissionCanceled()
    }
  }
}

extension MapViewController: MKMapViewDelegate {

  func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
    if !permissionAlreadyRequested {
      requestLocationPermission()
    }
  }

  func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    self.userLocation = userLocation.location
    if userLocationUpdateNeeded {
      centerMapOnCurrentLocation()
    }
  }
}

extension MapViewController: MapPresenterDelegate {
  func centerMapOnCurrentLocation() {
    guard let location = userLocation?.coordinate else {
      userLocationUpdateNeeded = !permissionCanceled
      return
    }
    userLocationUpdateNeeded = false
    permissionAlreadyRequested = true
    centerMap(on: location)
  }

  private func centerMap(on location: CLLocationCoordinate2D) {
    mapView.setCenter(location, animated: true)
    let region = MKCoordinateRegionMakeWithDistance(location,
                                                    presenter.mapDistance,
                                                    presenter.mapDistance)
    mapView.setRegion(region, animated: true)
  }
}
