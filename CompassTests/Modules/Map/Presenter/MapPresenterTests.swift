//
//  SplashPresenterTests.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import Quick
import Nimble

@testable import Compass

extension MapPresenterTests: MapPresenterDelegate {
  func centerMapOnCurrentLocation() {
    funcCalledCenterMapOnCurrentLocation = true
  }
}

class MapPresenterTests: QuickSpec {

  var funcCalledCenterMapOnCurrentLocation = false

  override func spec() {
    beforeEach {
      self.funcCalledCenterMapOnCurrentLocation = false
    }
    describe("MapPresenter") {
      describe("mapDistance") {
        context("whenever") {
          it("should return 1000") {
            //Arrange
            let presenter = MapPresenter(delegate: self)

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
            let presenter = MapPresenter(delegate: self)

            //Act
            let appName = presenter.title

            //Assert
            expect(appName).to(equal("Map"))
          }
        }
      }
      describe("locationPermissionAuthorized") {
        context("whenever") {
          it("should call delegate.centerMapOnCurrentLocation") {
            //Arrange
            let presenter = MapPresenter(delegate: self)

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
            let presenter = MapPresenter(delegate: self)

            //Act
            presenter.localizeMeButtonTappedWithLocationAuthorized(true)

            //Assert
            expect(self.funcCalledCenterMapOnCurrentLocation).to(beTrue())
          }
          it("should not call delegate.centerMapOnCurrentLocation if authorized false") {
            //Arrange
            let presenter = MapPresenter(delegate: self)

            //Act
            presenter.localizeMeButtonTappedWithLocationAuthorized(false)

            //Assert
            expect(self.funcCalledCenterMapOnCurrentLocation).to(beFalse())
          }
        }
      }
    }
  }
}
