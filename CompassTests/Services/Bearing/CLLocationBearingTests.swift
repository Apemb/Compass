//
//  SplashPresenterTests.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import Quick
import Nimble
import CoreLocation

@testable import Compass

class CLLocationBearingTests: QuickSpec {

  override func spec() {
    describe("CLLocationBearing") {
      describe("bearingToLocationDegrees") {
        context("whenever") {
          it("should return 0 between a point and North Pole") {
            //Arrange
            let northPole = CLLocation(latitude: 90.0, longitude: 0)
            let parisLocation = CLLocation(latitude: 48.85364, longitude: 2.34747)
            let expectedBearing = 360.00

            //Act
            let bearing = parisLocation.bearing(to: northPole, in: .degree)

            //Assert
            expect(bearing).to(beCloseTo(expectedBearing, within: 0.05))
          }
          it("should return 180 between a point and South Pole") {
            //Arrange
            let southPole = CLLocation(latitude: -90.0, longitude: 0)
            let parisLocation = CLLocation(latitude: 48.85364, longitude: 2.34747)
            let expectedBearing = 180.00

            //Act
            let bearing = parisLocation.bearing(to: southPole, in: .degree)

            //Assert
            expect(bearing).to(beCloseTo(expectedBearing, within: 0.05))
          }
          it("should return 266.70 between Paris and Brest") {
            //Arrange
            let parisLocation = CLLocation(latitude: 48.85364, longitude: 2.34747)
            let brestLocation = CLLocation(latitude: 48.38776, longitude: -4.48594)
            let expectedBearing = 266.70

            //Act
            let bearing = parisLocation.bearing(to: brestLocation, in: .degree)

            //Assert
            expect(bearing).to(beCloseTo(expectedBearing, within: 0.05))
          }
          it("should return 134.4 between Paris and Rome") {
            //Arrange
            let parisLocation = CLLocation(latitude: 48.85364, longitude: 2.34747)
            let romeLocation = CLLocation(latitude: 41.8958, longitude: 12.48244)
            let expectedBearing = 130.63

            //Act
            let bearing = parisLocation.bearing(to: romeLocation, in: .degree)

            //Assert
            expect(bearing).to(beCloseTo(expectedBearing, within: 0.05))
          }
        }
      }
    }
  }
}
