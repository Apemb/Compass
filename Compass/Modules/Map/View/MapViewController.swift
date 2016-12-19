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
  @IBOutlet weak var bottomBarView: UIView!
  @IBOutlet weak var bottomBarLabel: UILabel!

  // *********************************************************************
  // MARK: - Properties
  var presenter: MapPresenter!

  var userLocation: CLLocation?

  var destinationAnnotation: MapDestinationAnnotation? {
    didSet {
      if let annotation = destinationAnnotation {
          mapView.addAnnotation(annotation)
      }
      if let oldValue = oldValue {
        mapView.removeAnnotation(oldValue)
      }
    }
  }

  fileprivate let permissionScope = PermissionScope()
  fileprivate var permissionAlreadyRequested = false
  fileprivate var userLocationUpdateNeeded = false
  fileprivate var permissionCanceled = false

  // *********************************************************************
  // MARK: - UIViewController Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = presenter.title

    setupMapView()
    setupTouchRecognizer()
    setupPermissionScope()
    setupBottomBar()
  }

  private func setupMapView() {
    mapView.showsUserLocation = true
    mapView.delegate = self
  }

  private func setupTouchRecognizer() {
    let gestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                         action:#selector(MapViewController.handleLongTap(_:)))

    mapView.addGestureRecognizer(gestureRecognizer)
  }

  private func setupPermissionScope() {
    permissionAlreadyRequested = false
    permissionScope.addPermission(LocationAlwaysPermission(),
                                  message: "Compass needs that")
  }

  private func setupBottomBar() {
    bottomBarView.isOpaque = false
    bottomBarView.backgroundColor = Color.white.withAlphaComponent(0.95)
    bottomBarLabel.textAlignment = .center
    bottomBarLabel.text = presenter.bottomBarLabelText
  }

  // *********************************************************************
  // MARK: - IBActions
  @IBAction func localizeMeButtonTapped() {
    let authorized = permissionScope.statusLocationInUse() == .authorized
    permissionCanceled = false
    permissionAlreadyRequested = false
    presenter.localizeMeButtonTappedWithLocationAuthorized(authorized)
  }

  func handleLongTap(_ gestureReconizer: UILongPressGestureRecognizer) {
    guard gestureReconizer.state == .ended else {
      return
    }
    let tapLocation = gestureReconizer.location(in: mapView)
    let coordinate = mapView.convert(tapLocation,
                                     toCoordinateFrom: mapView)

    presenter.handleLongTap(at: coordinate)
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
  // *********************************************************************
  // MARK: - MKMapViewDelegate

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

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let annotation = annotation as? MapDestinationAnnotation else {
      return nil
    }
    return MapDestinationAnnotationView(annotation: annotation)
  }
}

extension MapViewController: MapPresenterDelegate {
  // *********************************************************************
  // MARK: - MapPresenterDelegate
  func centerMapOnCurrentLocation() {
    guard let location = userLocation?.coordinate else {
      userLocationUpdateNeeded = !permissionCanceled
      return
    }
    userLocationUpdateNeeded = false
    permissionAlreadyRequested = true
    centerMap(on: location)
  }

  func addDestination(_ destination: MapDestinationAnnotation) {
    destinationAnnotation = destination
  }

  private func centerMap(on location: CLLocationCoordinate2D) {
    let region = MKCoordinateRegionMakeWithDistance(location,
                                                    presenter.mapDistance,
                                                    presenter.mapDistance)
    mapView.setRegion(region, animated: true)
  }
}
