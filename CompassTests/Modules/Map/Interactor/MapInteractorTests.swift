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

class MapInteractorTests: QuickSpec {

  override func spec() {
    describe("MapPresenter") {
      describe("destination") {
        context("when just initialized") {
          it("should have no destination") {
            //Arrange
            let interactor = MapInteractor()

            //Act
            let destination = interactor.destination

            //Assert
            expect(destination).to(beNil())
          }
        }
      }
    }
  }
}
