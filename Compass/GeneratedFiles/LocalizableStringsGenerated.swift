// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum L10n {
  /// Compass
  case appName
  /// Ok
  case generalOk
  /// Cancel
  case generalCancel
  /// Confirm
  case generalConfirm
  /// Error
  case generalError
  /// Start
  case generalStart
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .appName:
        return L10n.tr(key: "AppName")
      case .generalOk:
        return L10n.tr(key: "GeneralOk")
      case .generalCancel:
        return L10n.tr(key: "GeneralCancel")
      case .generalConfirm:
        return L10n.tr(key: "GeneralConfirm")
      case .generalError:
        return L10n.tr(key: "GeneralError")
      case .generalStart:
        return L10n.tr(key: "GeneralStart")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(key: L10n) -> String {
  return key.string
}

