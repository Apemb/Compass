//
//  SplashModule.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import UIKit

protocol SplashModuleDelegate {
  func splashModuleEnded()
}

class SplashModule {

  let delegate: SplashModuleDelegate

  init(delegate: SplashModuleDelegate) {
    self.delegate = delegate
  }

  var firstViewController: UIViewController {
    let controller = StoryboardScene.Splash.instantiateSplashViewController()
    controller.presenter = SplashPresenter(delegate: controller)
    controller.delegate = self
    return controller
  }

}

extension SplashModule: SplashViewControllerDelegate {
  func splashScreenShouldEnd() {
    delegate.splashModuleEnded()
  }
}
