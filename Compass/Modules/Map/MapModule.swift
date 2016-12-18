//
//  MapModule.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import UIKit

class MapModule {

  var firstViewController: UIViewController {
    let controller = StoryboardScene.Map.instantiateMapViewController()
    controller.presenter = MapPresenter(delegate: controller)
    return controller
  }

}
