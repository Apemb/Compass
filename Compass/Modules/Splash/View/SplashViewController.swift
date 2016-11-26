//
//  SplashViewController.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import UIKit

class SplashViewController: UIViewController {

  // *********************************************************************
  // MARK: - IBOutlets
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  @IBOutlet weak var appNameLabel: UILabel!

  // *********************************************************************
  // MARK: - Properties
  var presenter: SplashPresenter!

  // *********************************************************************
  // MARK: - UIViewController Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    appNameLabel.text = presenter.appNameLabelText
    spinner.activityIndicatorViewStyle = .whiteLarge
    spinner.color = UIColor.darkGray
    spinner.startAnimating()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}
