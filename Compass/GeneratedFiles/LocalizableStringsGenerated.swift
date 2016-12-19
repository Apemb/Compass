// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum L10n {
  /// Compass
  case appName
  /// Cancel
  case generalCancel
  /// Confirm
  case generalConfirm
  /// Error
  case generalError
  /// Ok
  case generalOk
  /// Start
  case generalStart
  /// Map
  case mapScreenTitle
  /// Select destination
  case mapSelectDestination
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .appName:
        return L10n.tr(key: "AppName")
      case .generalCancel:
        return L10n.tr(key: "GeneralCancel")
      case .generalConfirm:
        return L10n.tr(key: "GeneralConfirm")
      case .generalError:
        return L10n.tr(key: "GeneralError")
      case .generalOk:
        return L10n.tr(key: "GeneralOk")
      case .generalStart:
        return L10n.tr(key: "GeneralStart")
      case .mapScreenTitle:
        return L10n.tr(key: "MapScreenTitle")
      case .mapSelectDestination:
        return L10n.tr(key: "MapSelectDestination")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(_ key: L10n) -> String {
  return key.string
}
