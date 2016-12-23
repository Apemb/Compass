//
//  MapModule.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import UIKit

class MapModule {

  let bluetoothService: BluetoothServiceProtocol

  init(bluetoothService: BluetoothServiceProtocol) {
    self.bluetoothService = bluetoothService
  }

  var firstViewController: UIViewController {
    let controller = StoryboardScene.Map.instantiateMapViewController()
    let interactor = MapInteractor(bluetoothService: bluetoothService)
    controller.presenter = MapPresenter(delegate: controller,
                                        interactor: interactor)
    return controller
  }

}
