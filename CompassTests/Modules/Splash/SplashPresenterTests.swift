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

class SplashPresenterTests: QuickSpec {
  override func spec() {
    describe("SplashPresenter") {
      describe("appNameLabelText") {
        context("whenever") {
          it("should return Compass") {
            //Arrange
            let presenter = SplashPresenter()

            //Act
            let appName = presenter.appNameLabelText

            //Assert
            expect(appName).to(equal("Compass"))
          }
        }
      }
    }
  }
}
