// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: nil)
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func perform<S: StoryboardSegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

struct StoryboardScene {
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Map: String, StoryboardSceneType {
    static let storyboardName = "Map"

    case mapViewControllerScene = "MapViewController"
    static func instantiateMapViewController() -> MapViewController {
      guard let vc = StoryboardScene.Map.mapViewControllerScene.viewController() as? MapViewController
      else {
        fatalError("ViewController 'MapViewController' is not of the expected class MapViewController.")
      }
      return vc
    }
  }
  enum Splash: String, StoryboardSceneType {
    static let storyboardName = "Splash"

    case splashViewControllerScene = "SplashViewController"
    static func instantiateSplashViewController() -> SplashViewController {
      guard let vc = StoryboardScene.Splash.splashViewControllerScene.viewController() as? SplashViewController
      else {
        fatalError("ViewController 'SplashViewController' is not of the expected class SplashViewController.")
      }
      return vc
    }
  }
}

struct StoryboardSegue {
}
