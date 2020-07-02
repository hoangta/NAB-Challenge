//
//  UIViewController+Ex.swift
//  NAB-Challenge
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import UIKit

// MARK: Factory
protocol ViewControllerFactory {}
extension UIViewController: ViewControllerFactory {}

extension ViewControllerFactory where Self: UIViewController {
  static func instantiate() -> Self {
    let name = String(describing: self).replacingOccurrences(of: "ViewController", with: "")
    let storyboard = UIStoryboard(name: name, bundle: nil)
    let initial = storyboard.instantiateInitialViewController()
    guard let controller = initial as? Self else {
      fatalError("Could not create \(name), please check your storyboard again.")
    }
    return controller
  }
}

// MARK: UINavigationController
extension UIViewController {
  func embeded(in nav: UINavigationController? = nil) -> UINavigationController {
    if let nav = nav {
      nav.setViewControllers([self], animated: false)
      return nav
    } else {
      return UINavigationController(rootViewController: self)
    }
  }
}
