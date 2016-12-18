//
//  SplashPresenter.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import Foundation

protocol SplashPresenterDelegate {
  func splashScreenShouldEnd()
  func splashScreenShouldStartAnimations()
}

struct SplashPresenter {

  let delegate: SplashPresenterDelegate

  var appNameLabelText: String {
    return L10n.appName.string
  }

  func viewDidAppear() {
    delegate.splashScreenShouldStartAnimations()
  }

  func animationsCompleted() {
    delegate.splashScreenShouldEnd()
  }
}
