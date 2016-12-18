//
//  ApplicationRouterSplashModule.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import Foundation

extension ApplicationRouter: SplashModuleDelegate {

  func splashModuleEnded() {
    fadeToMapView()
  }
}
