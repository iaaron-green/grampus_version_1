//
//  CompatibilityShims.swift
//  Pie Chart View
//
//

import UIKit

#if !swift(>=4.2)
extension UIApplication {
  typealias LaunchOptionsKey = UIApplicationLaunchOptionsKey
}

extension NSAttributedString {
  typealias Key = NSAttributedStringKey
}
#endif
