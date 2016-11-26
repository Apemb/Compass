//
//  SplashPresenter.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import UIKit

class ApplicationRouter {

  var window: UIWindow

  init(window: UIWindow) {
    self.window = window

    let splashModule = SplashModule()
    let splashViewController = splashModule.firstViewController
    window.rootViewController = splashViewController
  }
}
