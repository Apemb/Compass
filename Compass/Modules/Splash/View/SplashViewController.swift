//
//  SplashViewController.swift
//  Compass
//
//  Copyright (c) 2016 Antoine Boileau
//  MIT License
//

import UIKit

protocol SplashViewControllerDelegate {
  func splashScreenShouldEnd()
}

class SplashViewController: UIViewController {

  // *********************************************************************
  // MARK: - IBOutlets
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  @IBOutlet weak var appNameLabel: UILabel!
  @IBOutlet weak var logoImageView: UIImageView!

  // *********************************************************************
  // MARK: - Properties
  var delegate: SplashViewControllerDelegate?
  var presenter: SplashPresenter!

  // *********************************************************************
  // MARK: - UIViewController Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    appNameLabel.text = presenter.appNameLabelText

    spinner.activityIndicatorViewStyle = .whiteLarge
    spinner.color = UIColor.darkGray
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presenter.viewDidAppear()
  }

}

extension SplashViewController: SplashPresenterDelegate {

  func splashScreenShouldEnd() {
    delegate?.splashScreenShouldEnd()
  }

  func splashScreenShouldStartAnimations() {
    spinner.startAnimating()

    UIView.animate(withDuration: 2.0,
                   delay: 0,
                   usingSpringWithDamping: 1.0,
                   initialSpringVelocity: 1.0,
                   options: UIViewAnimationOptions.curveEaseOut,
                   animations: {
                    self.logoImageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
    },
                   completion: { _ -> Void in
                    self.presenter.animationsCompleted()
    })
  }
}
