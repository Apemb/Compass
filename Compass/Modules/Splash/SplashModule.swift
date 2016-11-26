//
//  SplashModule.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import UIKit

class SplashModule {

  var firstViewController: UIViewController {
    let controller = StoryboardScene.Splash.initialViewController()
    controller.presenter = SplashPresenter()
    return controller
  }

}
