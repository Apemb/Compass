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

extension SplashPresenterTests: SplashPresenterDelegate {

  func splashScreenShouldEnd() {
    funcCalledSplashScreenShouldEnd = true
  }
  func splashScreenShouldStartAnimations() {
    funcCalledSplashScreenShouldStartAnimations = true
  }
}

class SplashPresenterTests: QuickSpec {

  var funcCalledSplashScreenShouldEnd = false
  //swiftlint:disable:next variable_name
  var funcCalledSplashScreenShouldStartAnimations = false

  override func spec() {
    beforeEach {
      self.funcCalledSplashScreenShouldEnd = false
      self.funcCalledSplashScreenShouldStartAnimations = false
    }
    describe("SplashPresenter") {
      describe("appNameLabelText") {
        context("whenever") {
          it("should return Compass") {
            //Arrange
            let presenter = SplashPresenter(delegate: self)

            //Act
            let appName = presenter.appNameLabelText

            //Assert
            expect(appName).to(equal("Compass"))
          }
        }
      }

      describe("viewDidAppear") {
        context("whenever") {
          it("should start annimation") {
            //Arrange
            let presenter = SplashPresenter(delegate: self)

            //Act
            presenter.viewDidAppear()

            //Assert
            expect(self.funcCalledSplashScreenShouldStartAnimations).to(beTrue())
          }
        }
      }
      describe("annimationCompleted") {
        context("whenever") {
          it("should end module") {
            //Arrange
            let presenter = SplashPresenter(delegate: self)

            //Act
            presenter.animationsCompleted()

            //Assert
            expect(self.funcCalledSplashScreenShouldEnd).to(beTrue())
          }
        }
      }
    }
  }
}
