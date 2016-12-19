//
//  SplashPresenterTests.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import Quick
import Nimble
import MapKit

@testable import Compass

extension MapPresenterTests: MapPresenterDelegate {
  func centerMapOnCurrentLocation() {
    funcCalledCenterMapOnCurrentLocation = true
  }
  func addDestination(_ destination: MapDestinationAnnotation) {
    annotationToAdd = destination
  }
}

fileprivate struct MockInteractor: MapInteractorProtocol {
  var destination: CLLocation? = nil
  var bearingToDestination: Double? = nil
  func setDestination(to destination: CLLocationCoordinate2D) {}
}
class MapPresenterTests: QuickSpec {

  var funcCalledCenterMapOnCurrentLocation = false
  var annotationToAdd: MKAnnotation?
  fileprivate var interactor: MockInteractor!

  //swiftlint:disable:next function_body_length
  override func spec() {
    beforeEach {
      self.funcCalledCenterMapOnCurrentLocation = false
      self.annotationToAdd = nil
      self.interactor = MockInteractor()
    }
    describe("MapPresenter") {
      describe("mapDistance") {
        context("whenever") {
          it("should return 1000") {
            //Arrange
            let presenter = MapPresenter(delegate: self,
                                         interactor: self.interactor)

            //Act
            let appName = presenter.mapDistance

            //Assert
            expect(appName).to(equal(1000))
          }
        }
      }
      describe("title") {
        context("whenever") {
          it("should return Compass") {
            //Arrange
            let presenter = MapPresenter(delegate: self,
                                         interactor: self.interactor)

            //Act
            let appName = presenter.title

            //Assert
            expect(appName).to(equal("Map"))
          }
        }
      }
      describe("bottomBarLabelText") {
        context("when no destination selected") {
          it("should return Select Destination") {
            //Arrange
            let presenter = MapPresenter(delegate: self,
                                         interactor: self.interactor)

            //Act
            let bottomBarLabelText = presenter.bottomBarLabelText

            //Assert
            expect(bottomBarLabelText).to(equal("Select destination"))
          }
        }
      }
      describe("locationPermissionAuthorized") {
        context("whenever") {
          it("should call delegate.centerMapOnCurrentLocation") {
            //Arrange
            let presenter = MapPresenter(delegate: self,
                                         interactor: self.interactor)

            //Act
            presenter.locationPermissionAuthorized()

            //Assert
            expect(self.funcCalledCenterMapOnCurrentLocation).to(beTrue())
          }
        }
      }
      describe("localizeMeButtonTappedWithLocationAuthorized") {
        context("whenever") {
          it("should call delegate.centerMapOnCurrentLocation if authorized true") {
            //Arrange
            let presenter = MapPresenter(delegate: self,
                                         interactor: self.interactor)

            //Act
            presenter.localizeMeButtonTappedWithLocationAuthorized(true)

            //Assert
            expect(self.funcCalledCenterMapOnCurrentLocation).to(beTrue())
          }
          it("should not call delegate.centerMapOnCurrentLocation if authorized false") {
            //Arrange
            let presenter = MapPresenter(delegate: self,
                                         interactor: self.interactor)

            //Act
            presenter.localizeMeButtonTappedWithLocationAuthorized(false)

            //Assert
            expect(self.funcCalledCenterMapOnCurrentLocation).to(beFalse())
          }
        }
      }
      describe("handleLongTap") {
        context("whenever") {
          it("should call delegate.addAnnotation with the annotation at the right coordinate") {
            //Arrange
            let presenter = MapPresenter(delegate: self,
                                         interactor: self.interactor)
            let expectedCoordinate = CLLocationCoordinate2D(latitude: 23, longitude: 43)

            //Act
            presenter.handleLongTap(at: expectedCoordinate)

            //Assert
            expect(self.annotationToAdd?.coordinate.latitude).to(equal(expectedCoordinate.latitude))
            expect(self.annotationToAdd?.coordinate.longitude).to(equal(expectedCoordinate.longitude))
          }
        }
      }
    }
  }
}
