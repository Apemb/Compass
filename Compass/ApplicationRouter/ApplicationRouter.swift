//
//  ApplicationRouter.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import UIKit

class ApplicationRouter {

  var window: UIWindow
  var navigationController: UINavigationController!

  init(window: UIWindow) {
    self.window = window

    let splashModule = SplashModule(delegate: self)
    let splashViewController = splashModule.firstViewController
    window.rootViewController = splashViewController

    // TODO: Move init to splash screen ?
    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
      self.navigationController = UINavigationController()
      self.navigationController.isNavigationBarHidden = false
    }
  }

  func fadeToMapView() {
    let module = MapModule()
    let mapController = module.firstViewController

    navigationController.pushViewController(mapController, animated: false)
    navigationController.modalPresentationStyle = .custom
    navigationController.modalTransitionStyle = .crossDissolve

    window.rootViewController?.present(navigationController, animated: true, completion: nil)
  }

  func pushViewController(_ viewController: UIViewController) {
    navigationController.pushViewController(viewController, animated: true)
  }

  // swiftlint:disable cyclomatic_complexity
  // swiftlint:disable:next function_body_length
  func presentModule(_ moduleType: ModuleType) {
    switch moduleType {
    case .splash:
      let module = SplashModule(delegate: self)
      pushViewController(module.firstViewController)

    case .map:
      let module = MapModule()
      pushViewController(module.firstViewController)
    }
  }
  // swiftlint:enable cyclomatic_complexity
}
