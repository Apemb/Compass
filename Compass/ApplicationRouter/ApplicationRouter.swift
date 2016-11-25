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
