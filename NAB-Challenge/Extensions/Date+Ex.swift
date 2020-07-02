//
//  Date+Ex.swift
//  NABChallenge
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import Foundation

extension Date {
  enum Format: String {
    case longDate = "EEE, dd MMM yyyy"
  }

  private static var formatter: DateFormatter = {
    let formatter = DateFormatter()
    return formatter
  }()

  func toString(_ format: Format) -> String {
    Date.formatter.dateFormat = format.rawValue
    return Date.formatter.string(from: self)
  }
}
