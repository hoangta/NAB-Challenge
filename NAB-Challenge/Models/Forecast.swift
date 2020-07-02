//
//  Forecast.swift
//  NAB-Challenge
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import Foundation

struct Forecast: Decodable {
  let date: Date
  let avgTemperature: Double
  let pressure: Double
  let humidity: Double
  let description: String?

  init(from decoder: Decoder) throws {
    let dt: TimeInterval = try decoder.decode("dt")
    self.date = Date(timeIntervalSince1970: dt)
    let temp: [String: Double] = try decoder.decode("temp")
    self.avgTemperature = temp["day"] ?? 0
    self.pressure = try decoder.decode("pressure")
    self.humidity = try decoder.decode("humidity")
    let weathers: [Weather] = try decoder.decode("weather")
    self.description = weathers.first?.description
  }
}

// MARK: Decoding Helper
private extension Forecast {
  struct Weather: Decodable {
    let description: String
  }
}

// MARK: Wrapper
struct Forecasts: Decodable {
  let list: [Forecast]
  init(from decoder: Decoder) throws {
    self.list = (try? decoder.decode("list")) ?? []
  }
}
